import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/app_mode.dart';
import 'database_provider.dart';

class AppModeNotifier extends StateNotifier<AppMode> {
  final Ref _ref;
  AppModeNotifier(this._ref) : super(AppMode.cycleTracking) {
    _load();
  }

  Future<void> _load() async {
    final db = _ref.read(databaseProvider);
    final stored = await db.getSetting('app_mode');
    if (stored != null) {
      state = AppMode.values.firstWhere(
        (e) => e.name == stored,
        orElse: () => AppMode.cycleTracking,
      );
    }
  }

  Future<void> setMode(AppMode mode) async {
    state = mode;
    final db = _ref.read(databaseProvider);
    await db.setSetting('app_mode', mode.name);
  }
}

final appModeProvider = StateNotifierProvider<AppModeNotifier, AppMode>(
  (ref) => AppModeNotifier(ref),
);
