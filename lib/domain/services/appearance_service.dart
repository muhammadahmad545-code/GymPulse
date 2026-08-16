import 'package:flutter/material.dart';

import '../../data/db/app_database.dart';

/// Persists the owner's dark / light / system theme choice locally.
class AppearanceService {
  AppearanceService({required AppDatabase db}) : _db = db;

  final AppDatabase _db;
  static const themeKey = 'theme_mode';

  Future<ThemeMode> load() async {
    final row = await (_db.select(
      _db.appMetaEntries,
    )..where((t) => t.key.equals(themeKey))).getSingleOrNull();
    return fromStorage(row?.value);
  }

  Future<void> save(ThemeMode mode) async {
    await _db
        .into(_db.appMetaEntries)
        .insertOnConflictUpdate(
          AppMetaEntriesCompanion.insert(
            key: themeKey,
            value: toStorage(mode),
            updatedAt: DateTime.now().toUtc(),
          ),
        );
  }

  static String toStorage(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.system:
        return 'system';
      case ThemeMode.dark:
        return 'dark';
    }
  }

  static ThemeMode fromStorage(String? value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.dark;
    }
  }
}
