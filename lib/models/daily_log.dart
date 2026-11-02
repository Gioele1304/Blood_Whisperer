
enum FlowIntensity { none, spotting, light, medium, heavy }

enum CervicalMucusType { none, dry, sticky, creamy, watery, eggWhite }

enum MoodType { happy, calm, anxious, irritable, sad, energetic, tired }

enum SymptomType {
  cramps,
  headache,
  bloating,
  acne,
  breastTenderness,
  fatigue,
  backache,
  nausea,
  cravings,
  insomnia,
}

class DailyLog {
  final int? id;
  final DateTime date;
  final FlowIntensity flow;
  final CervicalMucusType mucus;
  final List<MoodType> moods;
  final List<SymptomType> symptoms;
  final double? bbt;
  final double? weight;
  final double? hydrationLiters;
  final double? sleepHours;
  final int? sleepQuality; // 1-5
  final bool? hadSex;
  final bool? sexProtected;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const DailyLog({
    this.id,
    required this.date,
    this.flow = FlowIntensity.none,
    this.mucus = CervicalMucusType.none,
    this.moods = const [],
    this.symptoms = const [],
    this.bbt,
    this.weight,
    this.hydrationLiters,
    this.sleepHours,
    this.sleepQuality,
    this.hadSex,
    this.sexProtected,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  DailyLog copyWith({
    int? id,
    DateTime? date,
    FlowIntensity? flow,
    CervicalMucusType? mucus,
    List<MoodType>? moods,
    List<SymptomType>? symptoms,
    double? bbt,
    double? weight,
    double? hydrationLiters,
    double? sleepHours,
    int? sleepQuality,
    bool? hadSex,
    bool? sexProtected,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DailyLog(
      id: id ?? this.id,
      date: date ?? this.date,
      flow: flow ?? this.flow,
      mucus: mucus ?? this.mucus,
      moods: moods ?? this.moods,
      symptoms: symptoms ?? this.symptoms,
      bbt: bbt ?? this.bbt,
      weight: weight ?? this.weight,
      hydrationLiters: hydrationLiters ?? this.hydrationLiters,
      sleepHours: sleepHours ?? this.sleepHours,
      sleepQuality: sleepQuality ?? this.sleepQuality,
      hadSex: hadSex ?? this.hadSex,
      sexProtected: sexProtected ?? this.sexProtected,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
