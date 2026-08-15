import 'attendance_source.dart';

/// Parses gym attendance CSV exports into canonical events.
/// Expected headers (aliases accepted):
/// external_event_id, external_member_id, occurred_at, event_type
class CsvImportAdapter implements AttendanceSource {
  CsvImportAdapter({this.sourceId = 'csv-import'});

  final String sourceId;
  String? _lastCsv;
  DateTime? _lastSuccess;
  DateTime? _lastAttempt;
  String? _lastError;

  @override
  String get id => sourceId;

  @override
  String get displayName => 'CSV attendance import';

  void loadCsv(String csv) => _lastCsv = csv;

  @override
  Future<void> connect() async {}

  @override
  Future<void> disconnect() async {}

  @override
  Future<bool> testConnection() async => _lastCsv != null;

  @override
  Future<List<AttendanceEvent>> syncSince(DateTime? checkpoint) async {
    _lastAttempt = DateTime.now().toUtc();
    final csv = _lastCsv;
    if (csv == null || csv.trim().isEmpty) {
      _lastError = 'No CSV content was provided.';
      return const [];
    }
    final events = parse(csv);
    _lastSuccess = DateTime.now().toUtc();
    _lastError = null;
    if (checkpoint == null) return events;
    return events.where((e) => e.occurredAt.isAfter(checkpoint)).toList();
  }

  @override
  Future<AttendanceSourceHealth> health() async {
    if (_lastCsv == null) {
      return AttendanceSourceHealth(
        status: AttendanceSourceHealthStatus.unavailable,
        lastSuccessAt: _lastSuccess,
        lastAttemptAt: _lastAttempt,
        message: 'No CSV has been imported yet.',
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
    return AttendanceEvent(
      externalEventId: rawEvent['externalEventId']?.toString() ?? '',
      externalMemberId: rawEvent['externalMemberId']?.toString() ?? '',
      sourceId: rawEvent['sourceId']?.toString() ?? id,
      occurredAt: DateTime.parse(rawEvent['occurredAt'].toString()).toUtc(),
      eventType: rawEvent['eventType']?.toString() ?? 'check_in',
      metadata: rawEvent,
    );
  }

  List<AttendanceEvent> parse(String csv) {
    final rows = _parseRows(csv);
    if (rows.isEmpty) return const [];
    final header = rows.first.map(_normalizeHeader).toList();
    final eventIdIdx = _indexOf(header, const [
      'external_event_id',
      'event_id',
      'id',
    ]);
    final memberIdx = _indexOf(header, const [
      'external_member_id',
      'member_id',
      'memberid',
      'user_id',
    ]);
    final timeIdx = _indexOf(header, const [
      'occurred_at',
      'timestamp',
      'time',
      'datetime',
      'date',
    ]);
    final typeIdx = _indexOf(header, const ['event_type', 'type']);
    if (memberIdx == null || timeIdx == null) {
      throw FormatException(
        'CSV must include external_member_id and occurred_at columns.',
      );
    }

    final events = <AttendanceEvent>[];
    for (var i = 1; i < rows.length; i++) {
      final row = rows[i];
      if (row.every((c) => c.trim().isEmpty)) continue;
      final memberId = _cell(row, memberIdx);
      final occurredRaw = _cell(row, timeIdx);
      if (memberId.isEmpty || occurredRaw.isEmpty) continue;
      final occurred = DateTime.tryParse(occurredRaw);
      if (occurred == null) continue;
      events.add(
        AttendanceEvent(
          externalEventId: eventIdIdx == null
              ? 'csv-$i-$memberId-$occurredRaw'
              : _cell(row, eventIdIdx),
          externalMemberId: memberId,
          sourceId: id,
          occurredAt: occurred.toUtc(),
          eventType: typeIdx == null ? 'check_in' : _cell(row, typeIdx),
          metadata: {'row': i + 1, 'raw': row.join(',')},
        ),
      );
    }
    return events;
  }

  List<List<String>> _parseRows(String csv) {
    final rows = <List<String>>[];
    var current = <String>[];
    final cell = StringBuffer();
    var inQuotes = false;
    for (var i = 0; i < csv.length; i++) {
      final ch = csv[i];
      if (ch == '"') {
        if (inQuotes && i + 1 < csv.length && csv[i + 1] == '"') {
          cell.write('"');
          i++;
        } else {
          inQuotes = !inQuotes;
        }
      } else if (ch == ',' && !inQuotes) {
        current.add(cell.toString());
        cell.clear();
      } else if ((ch == '\n' || ch == '\r') && !inQuotes) {
        if (ch == '\r' && i + 1 < csv.length && csv[i + 1] == '\n') i++;
        current.add(cell.toString());
        cell.clear();
        if (current.any((c) => c.trim().isNotEmpty)) rows.add(current);
        current = <String>[];
      } else {
        cell.write(ch);
      }
    }
    current.add(cell.toString());
    if (current.any((c) => c.trim().isNotEmpty)) rows.add(current);
    return rows;
  }

  String _normalizeHeader(String value) =>
      value.trim().toLowerCase().replaceAll(' ', '_');

  int? _indexOf(List<String> header, List<String> aliases) {
    for (final alias in aliases) {
      final idx = header.indexOf(alias);
      if (idx >= 0) return idx;
    }
    return null;
  }

  String _cell(List<String> row, int index) {
    if (index >= row.length) return '';
    return row[index].trim();
  }
}
