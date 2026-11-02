import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/pregnancy_info.dart';

class PregnancyNotifier extends StateNotifier<PregnancyInfo?> {
  PregnancyNotifier() : super(null);

  void setLmp(DateTime lmp) {
    state = PregnancyInfo(lastMenstrualPeriod: lmp);
  }

  void setDueDate(DateTime due) {
    final lmp = due.subtract(const Duration(days: 280));
    state = PregnancyInfo(lastMenstrualPeriod: lmp, dueDate: due);
  }

  void clear() => state = null;
}

final pregnancyInfoProvider =
    StateNotifierProvider<PregnancyNotifier, PregnancyInfo?>(
  (ref) => PregnancyNotifier(),
);
