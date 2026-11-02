import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cycle.dart';
import '../services/cycle_calculation_service.dart';
import 'database_provider.dart';
import 'daily_log_provider.dart';

final cycleServiceProvider = Provider((_) => CycleCalculationService());

final cyclesProvider = FutureProvider<List<Cycle>>((ref) async {
  final db = ref.read(databaseProvider);
  return db.getAllCycles();
});

final cycleStatisticsProvider = Provider<CycleStatistics>((ref) {
  final cycles = ref.watch(cyclesProvider).maybeWhen(
        data: (d) => d,
        orElse: () => <Cycle>[],
      );
  return ref.read(cycleServiceProvider).computeStatistics(cycles);
});

final currentPhaseProvider = Provider<CyclePhase?>((ref) {
  final logsAsync = ref.watch(dailyLogsProvider);
  final logs = logsAsync.maybeWhen(data: (d) => d, orElse: () => []);
  if (logs.isEmpty) return null;

  final sorted = [...logs]..sort((a, b) => a.date.compareTo(b.date));
  final firstDay = sorted.first.date;
  final stats = ref.watch(cycleStatisticsProvider);

  return ref.read(cycleServiceProvider).currentPhase(
        today: DateTime.now(),
        cycleStart: firstDay,
        cycleLength: stats.averageCycleLength.round(),
      );
});

final fertileWindowProvider = Provider<FertileWindow?>((ref) {
  final cyclesAsync = ref.watch(cyclesProvider);
  final cycles = cyclesAsync.maybeWhen(data: (d) => d, orElse: () => []);
  if (cycles.isEmpty) return null;
  final stats = ref.watch(cycleStatisticsProvider);
  final lastCycle = cycles.first;
  return ref.read(cycleServiceProvider).estimateFertileWindow(
        lastPeriodStart: lastCycle.startDate,
        cycleLength: stats.averageCycleLength.round(),
      );
});

final perimenopauseFlagProvider = Provider<bool>((ref) {
  final cycles = ref.watch(cyclesProvider).maybeWhen(
        data: (d) => d,
        orElse: () => <Cycle>[],
      );
  return ref.read(cycleServiceProvider).isPerimenopausePattern(cycles);
});
