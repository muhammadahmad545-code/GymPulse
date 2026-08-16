import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/data/latest.dart' as tzdata;

import 'app/mr_gym_app.dart';
import 'app/providers.dart';
import 'core/logging/app_logger.dart';
import 'data/db/app_database.dart';
import 'data/db/database_session.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tzdata.initializeTimeZones();

  final logger = AppLogger();
  FlutterError.onError = (details) {
    logger.error(
      'Flutter framework error',
      error: details.exceptionAsString(),
      stackTrace: details.stack,
    );
  };

  final session = DatabaseSession(await AppDatabase.open(), AppDatabase.open);

  runApp(
    ProviderScope(
      overrides: [
        databaseSessionProvider.overrideWith((ref) => session),
        appLoggerProvider.overrideWithValue(logger),
      ],
      child: const MrGymApp(),
    ),
  );
}
