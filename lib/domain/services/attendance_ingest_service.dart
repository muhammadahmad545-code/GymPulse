import '../../data/repositories/local_attendance_repository.dart';
import '../attendance/attendance_source.dart';
import '../models/workspace.dart';

/// Local attendance health for dashboards and analytics.
class AttendanceIngestService {
  AttendanceIngestService({required LocalAttendanceRepository attendance})
    : _attendance = attendance;

  final LocalAttendanceRepository _attendance;

  Future<AttendanceSourceHealth> importHealth(Workspace workspace) async {
    final source = await _attendance.sourceFor(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
    );
    final events = await _attendance.list(
      organizationId: workspace.organization.id,
      locationId: workspace.location.id,
    );
    if (events.isNotEmpty) {
      return AttendanceSourceHealth(
        status: AttendanceSourceHealthStatus.ready,
        lastSuccessAt: source?.lastSuccessAt ?? events.first.ingestedAt,
        lastAttemptAt: source?.lastAttemptAt,
      );
    }
    if (source == null || source.lastSuccessAt == null) {
      return AttendanceSourceHealth(
        status: AttendanceSourceHealthStatus.unavailable,
        lastSuccessAt: source?.lastSuccessAt,
        lastAttemptAt: source?.lastAttemptAt,
        message: 'No attendance has been recorded yet.',
      );
    }
    final staleAfter = Duration(hours: workspace.settings.staleImportHours);
    final age = DateTime.now().toUtc().difference(source.lastSuccessAt!);
    if (source.status == 'error') {
      return AttendanceSourceHealth(
        status: AttendanceSourceHealthStatus.error,
        lastSuccessAt: source.lastSuccessAt,
        lastAttemptAt: source.lastAttemptAt,
        message: 'The last attendance sync failed.',
      );
    }
    if (age > staleAfter) {
      return AttendanceSourceHealth(
        status: AttendanceSourceHealthStatus.delayed,
        lastSuccessAt: source.lastSuccessAt,
        lastAttemptAt: source.lastAttemptAt,
        message: 'Attendance data may be stale.',
      );
    }
    return AttendanceSourceHealth(
      status: AttendanceSourceHealthStatus.ready,
      lastSuccessAt: source.lastSuccessAt,
      lastAttemptAt: source.lastAttemptAt,
    );
  }
}
