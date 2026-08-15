import '../../data/db/app_database.dart';

class Workspace {
  const Workspace({
    required this.organization,
    required this.location,
    required this.settings,
  });

  final Organization organization;
  final Location location;
  final LocationSetting settings;
}

class LocationSettingView {
  const LocationSettingView({
    required this.inactivityMonitorDays,
    required this.inactivityFollowUpDays,
    required this.inactivityHighRiskDays,
    required this.inactivityCriticalDays,
    required this.staleImportHours,
    this.gymPhone,
    this.peakHighAttendance,
    this.closureDates = const {},
  });

  final int inactivityMonitorDays;
  final int inactivityFollowUpDays;
  final int inactivityHighRiskDays;
  final int inactivityCriticalDays;
  final int staleImportHours;
  final String? gymPhone;
  final int? peakHighAttendance;
  final Set<String> closureDates;

  factory LocationSettingView.fromRow(LocationSetting row) {
    return LocationSettingView(
      inactivityMonitorDays: row.inactivityMonitorDays,
      inactivityFollowUpDays: row.inactivityFollowUpDays,
      inactivityHighRiskDays: row.inactivityHighRiskDays,
      inactivityCriticalDays: row.inactivityCriticalDays,
      staleImportHours: row.staleImportHours,
      gymPhone: row.gymPhone,
      peakHighAttendance: row.peakHighAttendance,
      closureDates: _parseClosures(row.closureDatesJson),
    );
  }

  static const defaults = LocationSettingView(
    inactivityMonitorDays: 7,
    inactivityFollowUpDays: 14,
    inactivityHighRiskDays: 21,
    inactivityCriticalDays: 30,
    staleImportHours: 24,
  );

  static Set<String> _parseClosures(String? json) {
    if (json == null || json.trim().isEmpty) return {};
    return json
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll('"', '')
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toSet();
  }
}
