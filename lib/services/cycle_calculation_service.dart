import 'dart:math';
import '../models/cycle.dart';
import '../models/daily_log.dart';
import '../models/pregnancy_info.dart';

class CycleStatistics {
  final double averageCycleLength;
  final double stdDeviation;
  final int cyclesAnalyzed;
  final int? shortestCycle;
  final int? longestCycle;

  const CycleStatistics({
    required this.averageCycleLength,
    required this.stdDeviation,
    required this.cyclesAnalyzed,
    this.shortestCycle,
    this.longestCycle,
  });

  bool get isRegular => stdDeviation < 4.0;
}

class FertileWindow {
  final DateTime ovulationDay;
  final DateTime fertileStart;
  final DateTime fertileEnd;

  const FertileWindow({
    required this.ovulationDay,
    required this.fertileStart,
    required this.fertileEnd,
  });

  bool contains(DateTime date) {
    final d = DateTime(date.year, date.month, date.day);
    return !d.isBefore(fertileStart) && !d.isAfter(fertileEnd);
  }
}

class CycleCalculationService {
  /// Calcola media e deviazione standard delle durate ciclo.
  CycleStatistics computeStatistics(List<Cycle> cycles) {
    final lengths = cycles
        .where((c) => c.lengthDays != null && c.lengthDays! > 0)
        .map((c) => c.lengthDays!)
        .toList();

    if (lengths.isEmpty) {
      return const CycleStatistics(
        averageCycleLength: 28,
        stdDeviation: 0,
        cyclesAnalyzed: 0,
      );
    }

    final mean = lengths.reduce((a, b) => a + b) / lengths.length;
    final variance =
        lengths.map((l) => pow(l - mean, 2)).reduce((a, b) => a + b) /
            lengths.length;
    final stdDev = sqrt(variance.toDouble());

    lengths.sort();
    return CycleStatistics(
      averageCycleLength: mean,
      stdDeviation: stdDev,
      cyclesAnalyzed: lengths.length,
      shortestCycle: lengths.first,
      longestCycle: lengths.last,
    );
  }

  /// Stima la finestra fertile a partire dall'ultimo ciclo.
  FertileWindow estimateFertileWindow({
    required DateTime lastPeriodStart,
    required int cycleLength,
    int lutealPhaseLength = 14,
  }) {
    final ovulation =
        lastPeriodStart.add(Duration(days: cycleLength - lutealPhaseLength));
    final fertileStart = ovulation.subtract(const Duration(days: 5));
    final fertileEnd = ovulation.add(const Duration(days: 1));
    return FertileWindow(
      ovulationDay: ovulation,
      fertileStart: fertileStart,
      fertileEnd: fertileEnd,
    );
  }

  /// Suddivide il ciclo in fasi fisiologiche.
  List<CyclePhaseInfo> computePhases({
    required DateTime cycleStart,
    required int cycleLength,
    int periodLength = 5,
    int lutealPhaseLength = 14,
  }) {
    final ovulationDay = cycleLength - lutealPhaseLength;
    final menstrualEnd = cycleStart.add(Duration(days: periodLength - 1));
    final follicularEnd = cycleStart.add(Duration(days: ovulationDay - 2));
    final ovulatoryEnd = cycleStart.add(Duration(days: ovulationDay + 1));
    final lutealEnd = cycleStart.add(Duration(days: cycleLength - 1));

    return [
      CyclePhaseInfo(
        phase: CyclePhase.menstrual,
        start: cycleStart,
        end: menstrualEnd,
        description:
            'Il rivestimento uterino si sfalda. I livelli di estrogeni e progesterone sono ai minimi.',
        lifestyleTip:
            'Riposa di più, idratati, assumi ferro con alimenti come legumi e verdure a foglia verde.',
      ),
      CyclePhaseInfo(
        phase: CyclePhase.follicular,
        start: menstrualEnd.add(const Duration(days: 1)),
        end: follicularEnd,
        description:
            'L\'FSH stimola la maturazione dei follicoli. Gli estrogeni iniziano a salire.',
        lifestyleTip:
            'Ottimo periodo per attività fisica intensa e nuovi progetti. Aumenta l\'apporto proteico.',
      ),
      CyclePhaseInfo(
        phase: CyclePhase.ovulatory,
        start: follicularEnd.add(const Duration(days: 1)),
        end: ovulatoryEnd,
        description:
            'Picco di LH ed estrogeni. Rilascio dell\'ovulo: massima fertilità.',
        lifestyleTip:
            'Energia al top. Consuma antiossidanti e mantieni una buona idratazione.',
      ),
      CyclePhaseInfo(
        phase: CyclePhase.luteal,
        start: ovulatoryEnd.add(const Duration(days: 1)),
        end: lutealEnd,
        description:
            'Il corpo luteo produce progesterone. Possibili sintomi premestruali.',
        lifestyleTip:
            'Riduci caffeina e sale. Preferisci magnesio (frutta secca, banane) e attività leggere.',
      ),
    ];
  }

  CyclePhase currentPhase({
    required DateTime today,
    required DateTime cycleStart,
    required int cycleLength,
    int periodLength = 5,
  }) {
    final dayIndex = today.difference(cycleStart).inDays;
    final phases = computePhases(
      cycleStart: cycleStart,
      cycleLength: cycleLength,
      periodLength: periodLength,
    );
    for (final p in phases) {
      if (!today.isBefore(p.start) && !today.isAfter(p.end)) {
        return p.phase;
      }
    }
    // Fallback: se oltre il ciclo stimato, riparti dalla mestruale
    return dayIndex < periodLength
        ? CyclePhase.menstrual
        : CyclePhase.luteal;
  }

  /// Rileva fluttuazioni perimenopausali.
  bool isPerimenopausePattern(List<Cycle> cycles) {
    if (cycles.length < 6) return false;
    final stats = computeStatistics(cycles);
    // Cicli irregolari: deviazione standard > 7 giorni
    if (stats.stdDeviation > 7) return true;
    // Cicli troppo corti o troppo lunghi
    if (stats.shortestCycle != null &&
        stats.longestCycle != null &&
        stats.longestCycle! - stats.shortestCycle! > 14) {
      return true;
    }
    return false;
  }

  /// Calcola info di gravidanza da LMP.
  PregnancyInfo computePregnancy(DateTime lmp) {
    return PregnancyInfo(lastMenstrualPeriod: lmp);
  }

  /// Rileva l'ovulazione basandosi sulla BBT (rialzo termico).
  DateTime? detectOvulationFromBBT(List<DailyLog> logs) {
    final bbtLogs = logs
        .where((l) => l.bbt != null && l.bbt! > 0)
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    if (bbtLogs.length < 6) return null;

    for (int i = 3; i < bbtLogs.length - 2; i++) {
      final prev = bbtLogs
          .sublist(i - 3, i)
          .map((e) => e.bbt!)
          .reduce((a, b) => a + b) /
          3;
      final next = bbtLogs
          .sublist(i, i + 3)
          .map((e) => e.bbt!)
          .reduce((a, b) => a + b) /
          3;
      if (next - prev >= 0.2) {
        return bbtLogs[i].date;
      }
    }
    return null;
  }
}
