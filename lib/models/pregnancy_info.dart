class PregnancyInfo {
  final DateTime lastMenstrualPeriod;
  final DateTime? dueDate;
  final DateTime? conceptionDate;

  const PregnancyInfo({
    required this.lastMenstrualPeriod,
    this.dueDate,
    this.conceptionDate,
  });

  DateTime get calculatedDueDate =>
      dueDate ?? lastMenstrualPeriod.add(const Duration(days: 280));

  int get gestationalDays =>
      DateTime.now().difference(lastMenstrualPeriod).inDays;

  int get gestationalWeeks => gestationalDays ~/ 7;

  int get gestationalDaysRemainder => gestationalDays % 7;

  int get trimester {
    if (gestationalWeeks < 13) return 1;
    if (gestationalWeeks < 27) return 2;
    return 3;
  }
}
