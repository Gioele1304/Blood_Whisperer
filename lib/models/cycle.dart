class Cycle {
  final int? id;
  final DateTime startDate;
  final DateTime? endDate;
  final int? lengthDays;
  final int? periodLengthDays;
  final String? notes;

  const Cycle({
    this.id,
    required this.startDate,
    this.endDate,
    this.lengthDays,
    this.periodLengthDays,
    this.notes,
  });
}

enum CyclePhase { menstrual, follicular, ovulatory, luteal }

class CyclePhaseInfo {
  final CyclePhase phase;
  final DateTime start;
  final DateTime end;
  final String description;
  final String lifestyleTip;

  const CyclePhaseInfo({
    required this.phase,
    required this.start,
    required this.end,
    required this.description,
    required this.lifestyleTip,
  });

  String get phaseName {
    switch (phase) {
      case CyclePhase.menstrual:
        return 'Fase Mestruale';
      case CyclePhase.follicular:
        return 'Fase Follicolare';
      case CyclePhase.ovulatory:
        return 'Fase Ovulatoria';
      case CyclePhase.luteal:
        return 'Fase Luteale';
    }
  }
}
