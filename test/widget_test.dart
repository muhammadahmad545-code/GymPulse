import 'package:timezone/data/latest.dart' as tzdata;
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gympulse/app/gympulse_app.dart';
import 'package:gympulse/app/providers.dart';
import 'package:gympulse/core/logging/app_logger.dart';
import 'package:gympulse/core/security/secure_store.dart';
import 'package:gympulse/data/db/app_database.dart';
import 'package:gympulse/data/db/database_session.dart';

void main() {
  tzdata.initializeTimeZones();
  testWidgets('shows PIN setup on first launch', (tester) async {
    final db = AppDatabase.memory();
    final session = DatabaseSession(db, () async => db);
    addTearDown(session.close);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseSessionProvider.overrideWith((ref) => session),
          secureStoreProvider.overrideWithValue(MemorySecureStore()),
          appLoggerProvider.overrideWithValue(
            AppLogger(sink: (_, __, {error, stackTrace}) {}),
          ),
        ],
        child: const GymPulseApp(),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Create your app PIN'), findsOneWidget);
    expect(find.text('GymPulse'), findsWidgets);
  });
}
