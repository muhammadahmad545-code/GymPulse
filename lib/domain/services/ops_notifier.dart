import '../attendance/attendance_source.dart';
import '../models/workspace.dart';
import 'local_notification_service.dart';
import 'operations_service.dart';

/// Fires local operations notifications at most once per local day.
class OpsNotifier {
  const OpsNotifier({required this.operations, required this.notifications});

  final OperationsService operations;
  final LocalNotificationService notifications;

  Future<void> maybeNotify({
    required Workspace workspace,
    required AttendanceSourceHealth importHealth,
    required OperationsSnapshot snapshot,
  }) async {
    final prefs = await operations.notificationPrefs(workspace.organization.id);
    final today = await operations.consumeDailySummaryDate(
      workspace: workspace,
      nowUtc: DateTime.now().toUtc(),
    );
    if (today == null) return;

    if ((prefs[OpsNotifyKeys.importStale] ?? true) &&
        !importHealth.isDataReliable) {
      await notifications.show(
        id: 31,
        title: 'Attendance import',
        body:
            importHealth.message ??
            'Attendance is stale or unavailable. This is not zero attendance.',
      );
    }
    if (prefs[OpsNotifyKeys.dailySummary] ?? true) {
      await notifications.show(
        id: 30,
        title: 'Mr. Gym daily summary',
        body: snapshot.daily.explanation,
      );
    }
    if ((prefs[OpsNotifyKeys.highRisk] ?? true) &&
        snapshot.daily.highRisk > 0) {
      await notifications.show(
        id: 32,
        title: 'High-risk members',
        body: '${snapshot.daily.highRisk} member(s) need attention.',
      );
    }
    if ((prefs[OpsNotifyKeys.expiryQueue] ?? true) &&
        snapshot.daily.expiring7 >= 3) {
      await notifications.show(
        id: 33,
        title: 'Expiry queue',
        body: '${snapshot.daily.expiring7} memberships expire within 7 days.',
      );
    }
  }
}
