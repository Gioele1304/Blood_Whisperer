import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/app_mode.dart';
import '../../models/cycle.dart';
import '../../providers/app_mode_provider.dart';
import '../../providers/cycle_provider.dart';
import '../../providers/daily_log_provider.dart';
import '../../providers/pregnancy_provider.dart';
import '../widgets/cycle_ring.dart';
import '../widgets/phase_card.dart';
import '../widgets/fertile_window_badge.dart';
import '../widgets/disclaimer_banner.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(appModeProvider);
    final phase = ref.watch(currentPhaseProvider);
    final stats = ref.watch(cycleStatisticsProvider);
    final pregnancy = ref.watch(pregnancyInfoProvider);
    final fertile = ref.watch(fertileWindowProvider);
    final logsAsync = ref.watch(dailyLogsProvider);

    final logs = logsAsync.maybeWhen(data: (d) => d, orElse: () => []);
    final cycleLength = stats.averageCycleLength.round();
    final currentDay = _currentCycleDay(logs, cycleLength);

    return Scaffold(
      appBar: AppBar(title: Text(mode.label)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const DisclaimerBanner(),
          const SizedBox(height: 16),
          Center(
            child: mode == AppMode.pregnancy
                ? _pregnancyRing(context, pregnancy)
                : CycleRing(currentDay: currentDay, cycleLength: cycleLength),
          ),
          const SizedBox(height: 16),
          if (mode == AppMode.tryingToConceive)
            Center(
              child: FertileWindowBadge(
                isFertile: fertile?.contains(DateTime.now()) ?? false,
                ovulationDay: fertile?.ovulationDay,
              ),
            ),
          const SizedBox(height: 16),
          _statsRow(context, stats, cycleLength),
          const SizedBox(height: 16),
          PhaseCard(phaseInfo: _phaseInfo(ref, phase, logs, cycleLength)),
        ],
      ),
    );
  }

  Widget _pregnancyRing(BuildContext context, dynamic pregnancy) {
    if (pregnancy == null) {
      return const Text('Configura la gravidanza nelle impostazioni');
    }
    return SizedBox(
      width: 180,
      height: 180,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 180,
            height: 180,
            child: CircularProgressIndicator(
              value: (pregnancy.gestationalDays / 280).clamp(0.0, 1.0),
              strokeWidth: 12,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Settimana',
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
              Text(
                '${pregnancy.gestationalWeeks}',
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              Text('+${pregnancy.gestationalDaysRemainder} giorni'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statsRow(BuildContext context, dynamic stats, int cycleLength) {
    return Row(
      children: [
        Expanded(child: _statTile(context, 'Ciclo medio', '${stats.averageCycleLength.toStringAsFixed(1)} gg')),
        const SizedBox(width: 8),
        Expanded(child: _statTile(context, 'Deviazione', '${stats.stdDeviation.toStringAsFixed(1)} gg')),
        const SizedBox(width: 8),
        Expanded(child: _statTile(context, 'Cicli', '${stats.cyclesAnalyzed}')),
      ],
    );
  }

  Widget _statTile(BuildContext context, String label, String value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          children: [
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }

  CyclePhaseInfo? _phaseInfo(WidgetRef ref, CyclePhase? phase, List<dynamic> logs, int cycleLength) {
    if (phase == null || logs.isEmpty) return null;
    final sorted = [...logs]..sort((a, b) => a.date.compareTo(b.date));
    final cycleStart = sorted.first.date;
    final phases = ref.read(cycleServiceProvider).computePhases(
      cycleStart: cycleStart,
      cycleLength: cycleLength,
    );
    return phases.firstWhere(
      (p) => p.phase == phase,
      orElse: () => phases.first,
    );
  }

  int _currentCycleDay(List<dynamic> logs, int cycleLength) {
    if (logs.isEmpty) return 1;
    final sorted = [...logs]..sort((a, b) => b.date.compareTo(a.date));
    final last = sorted.first.date;
    final diff = DateTime.now().difference(last).inDays;
    return (diff % cycleLength) + 1;
  }
}
