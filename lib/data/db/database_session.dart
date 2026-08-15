import 'package:flutter/foundation.dart';

import 'app_database.dart';

/// Holds the live Drift database so backup restore can close, swap, and reopen
/// without leaking a stale connection.
class DatabaseSession extends ChangeNotifier {
  DatabaseSession(this._db, this._open);

  AppDatabase _db;
  final Future<AppDatabase> Function() _open;

  AppDatabase get db => _db;

  Future<AppDatabase> reopen() async {
    try {
      await _db.close();
    } catch (_) {
      // Closing a already-closed database is not fatal; continue reopen.
    }
    _db = await _open();
    notifyListeners();
    return _db;
  }

  Future<void> close() => _db.close();
}
