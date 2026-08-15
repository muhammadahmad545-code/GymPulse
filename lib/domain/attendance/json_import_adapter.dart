import 'dart:convert';

import 'attendance_source.dart';

/// Parses normalized GymPulse JSON attendance exports.
/// Expected shape: `{ "events": [ { ... } ] }` or a raw event array.
/// Field aliases match the CSV adapter. No vendor schema is invented.
class JsonImportAdapter implements AttendanceSource {
  JsonImportAdapter({this.sourceId = 'json-import'});

  final String sourceId;
  String? _lastJson;
  DateTime? _lastSuccess;
  DateTime? _lastAttempt;
  String? _lastError;

  @override
  String get id => sourceId;

  @override
  String get displayName => 'JSON attendance import';

  void loadJson(String json) => _lastJson = json;

  @override
  Future<void> connect() async {}

  @override
  Future<void> disconnect() async {}

  @override
  Future<bool> testConnection() async => _lastJson != null;

  @override
  Future<List<AttendanceEvent>> syncSince(DateTime? checkpoint) async {
    _lastAttempt = DateTime.now().toUtc();
    final raw = _lastJson;
    if (raw == null || raw.trim().isEmpty) {
      _lastError = 'No JSON content was provided.';
      return const [];
    }
    final events = parse(raw);
    _lastSuccess = DateTime.now().toUtc();
    _lastError = null;
    if (checkpoint == null) return events;
    return events.where((e) => e.occurredAt.isAfter(checkpoint)).toList();
  }

  @override
  Future<AttendanceSourceHealth> health() async {
    if (_lastJson == null) {
      return AttendanceSourceHealth(
        status: AttendanceSourceHealthStatus.unavailable,
        lastSuccessAt: _lastSuccess,
        lastAttemptAt: _lastAttempt,
        message: 'No JSON has been imported yet.',
      );
    }
    if (_lastError != null) {
      return AttendanceSourceHealth(
        status: AttendanceSourceHealthStatus.error,
        lastSuccessAt: _lastSuccess,
        lastAttemptAt: _lastAttempt,
        errorCount: 1,
        message: _lastError,
      );
    }
    return AttendanceSourceHealth(
      status: AttendanceSourceHealthStatus.ready,
      lastSuccessAt: _lastSuccess,
      lastAttemptAt: _lastAttempt,
    );
  }

  @override
  AttendanceEvent normalize(Map<String, dynamic> rawEvent) {
    final occurred = _first(rawEvent, const [
      'occurredAt',
      'occurred_at',
      'timestamp',
      'time',
      'datetime',
      'date',
    ]);
    return AttendanceEvent(
      externalEventId: _first(rawEvent, const [
        'externalEventId',
        'external_event_id',
        'event_id',
        'id',
      ]),
      externalMemberId: _first(rawEvent, const [
        'externalMemberId',
        'external_member_id',
        'member_id',
        'memberId',
        'user_id',
      ]),
      sourceId: rawEvent['sourceId']?.toString() ?? id,
      occurredAt: DateTime.parse(occurred).toUtc(),
      eventType: _first(rawEvent, const [
        'eventType',
        'event_type',
        'type',
      ], fallback: 'check_in'),
      metadata: rawEvent,
    );
  }

  List<AttendanceEvent> parse(String raw) {
    final decoded = jsonDecode(raw);
    final rows = <Map<String, dynamic>>[];
    if (decoded is List) {
      for (final item in decoded) {
        if (item is Map) rows.add(Map<String, dynamic>.from(item));
      }
    } else if (decoded is Map) {
      final events =
          decoded['events'] ?? decoded['attendance'] ?? decoded['data'];
      if (events is List) {
        for (final item in events) {
          if (item is Map) rows.add(Map<String, dynamic>.from(item));
        }
      } else {
        rows.add(Map<String, dynamic>.from(decoded));
      }
    } else {
      throw const FormatException(
        'JSON must be an event array or an object with an events list.',
      );
    }

    final events = <AttendanceEvent>[];
    for (var i = 0; i < rows.length; i++) {
      final row = rows[i];
      final memberId = _first(row, const [
        'externalMemberId',
        'external_member_id',
        'member_id',
        'memberId',
        'user_id',
      ]);
      final occurredRaw = _first(row, const [
        'occurredAt',
        'occurred_at',
        'timestamp',
        'time',
        'datetime',
        'date',
      ]);
      if (memberId.isEmpty || occurredRaw.isEmpty) continue;
      final occurred = DateTime.tryParse(occurredRaw);
      if (occurred == null) continue;
      final eventId = _first(row, const [
        'externalEventId',
        'external_event_id',
        'event_id',
        'id',
      ]);
      events.add(
        AttendanceEvent(
          externalEventId: eventId.isEmpty
              ? 'json-$i-$memberId-$occurredRaw'
              : eventId,
          externalMemberId: memberId,
          sourceId: id,
          occurredAt: occurred.toUtc(),
          eventType: _first(row, const [
            'eventType',
            'event_type',
            'type',
          ], fallback: 'check_in'),
          metadata: {'row': i + 1, 'raw': row},
        ),
      );
    }
    return events;
  }

  String _first(
    Map<String, dynamic> row,
    List<String> keys, {
    String fallback = '',
  }) {
    for (final key in keys) {
      final value = row[key]?.toString().trim();
      if (value != null && value.isNotEmpty) return value;
    }
    return fallback;
  }
}
