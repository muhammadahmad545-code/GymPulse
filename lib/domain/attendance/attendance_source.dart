import 'package:equatable/equatable.dart';

/// Canonical attendance event (docs/08).
class AttendanceEvent extends Equatable {
  const AttendanceEvent({
    required this.externalEventId,
    required this.externalMemberId,
    required this.sourceId,
    required this.occurredAt,
    required this.eventType,
    this.metadata = const {},
  });

  final String externalEventId;
  final String externalMemberId;
  final String sourceId;
  final DateTime occurredAt;
  final String eventType;
  final Map<String, Object?> metadata;

  @override
  List<Object?> get props => [
    externalEventId,
    externalMemberId,
    sourceId,
    occurredAt,
    eventType,
  ];
}

enum AttendanceSourceHealthStatus {
  ready,
  delayed,
  error,
  disabled,
  unavailable,
}

class AttendanceSourceHealth extends Equatable {
  const AttendanceSourceHealth({
    required this.status,
    this.lastSuccessAt,
    this.lastAttemptAt,
    this.errorCount = 0,
    this.message,
  });

  final AttendanceSourceHealthStatus status;
  final DateTime? lastSuccessAt;
  final DateTime? lastAttemptAt;
  final int errorCount;
  final String? message;

  /// Missing/unavailable source must never be treated as zero attendance.
  bool get isDataReliable =>
      status == AttendanceSourceHealthStatus.ready ||
      status == AttendanceSourceHealthStatus.delayed;

  @override
  List<Object?> get props => [
    status,
    lastSuccessAt,
    lastAttemptAt,
    errorCount,
    message,
  ];
}

/// Adapter contract for attendance sources. No vendor APIs invented here.
abstract class AttendanceSource {
  String get id;
  String get displayName;

  Future<void> connect();
  Future<void> disconnect();
  Future<bool> testConnection();
  Future<List<AttendanceEvent>> syncSince(DateTime? checkpoint);
  Future<AttendanceSourceHealth> health();
  AttendanceEvent normalize(Map<String, dynamic> rawEvent);
}

/// Development/testing mock source — explicitly labeled, not a real vendor.
class MockAttendanceSource implements AttendanceSource {
  MockAttendanceSource({this.sourceId = 'mock-dev'});

  final String sourceId;
  bool _connected = false;
  DateTime? _lastSuccess;

  @override
  String get id => sourceId;

  @override
  String get displayName => 'Mock attendance source (dev/test)';

  @override
  Future<void> connect() async {
    _connected = true;
  }

  @override
  Future<void> disconnect() async {
    _connected = false;
  }

  @override
  Future<bool> testConnection() async => _connected;

  @override
  Future<List<AttendanceEvent>> syncSince(DateTime? checkpoint) async {
    if (!_connected) {
      return const [];
    }
    final now = DateTime.now().toUtc();
    _lastSuccess = now;
    return [
      AttendanceEvent(
        externalEventId: 'mock-${now.millisecondsSinceEpoch}',
        externalMemberId: 'M-MOCK-001',
        sourceId: id,
        occurredAt: now,
        eventType: 'check_in',
        metadata: const {'simulated': true},
      ),
    ];
  }

  @override
  Future<AttendanceSourceHealth> health() async {
    if (!_connected) {
      return const AttendanceSourceHealth(
        status: AttendanceSourceHealthStatus.unavailable,
        message: 'Mock source is not connected.',
      );
    }
    return AttendanceSourceHealth(
      status: AttendanceSourceHealthStatus.ready,
      lastSuccessAt: _lastSuccess,
      lastAttemptAt: DateTime.now().toUtc(),
    );
  }

  @override
  AttendanceEvent normalize(Map<String, dynamic> rawEvent) {
    return AttendanceEvent(
      externalEventId: rawEvent['externalEventId']?.toString() ?? '',
      externalMemberId: rawEvent['externalMemberId']?.toString() ?? '',
      sourceId: rawEvent['sourceId']?.toString() ?? id,
      occurredAt: DateTime.parse(rawEvent['occurredAt'].toString()).toUtc(),
      eventType: rawEvent['eventType']?.toString() ?? 'check_in',
    );
  }
}

/// Future optional sync boundary — disabled and unused in Phase 0.
abstract class SyncPort {
  Future<bool> get isEnabled;
  Future<void> push();
  Future<void> pull();
}

class DisabledSyncPort implements SyncPort {
  @override
  Future<bool> get isEnabled async => false;

  @override
  Future<void> push() async {}

  @override
  Future<void> pull() async {}
}
