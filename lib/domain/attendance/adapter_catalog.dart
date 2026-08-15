import 'attendance_source.dart';

/// Catalog of attendance adapters. Vendor/REST/SDK entries stay pending
/// until the owner provides official documentation. No vendor APIs invented.
class AdapterDescriptor {
  const AdapterDescriptor({
    required this.id,
    required this.displayName,
    required this.status,
    required this.summary,
    this.available = false,
  });

  final String id;
  final String displayName;
  final String status;
  final String summary;
  final bool available;
}

class PendingAttendanceAdapter implements AttendanceSource {
  PendingAttendanceAdapter({
    required this.id,
    required this.displayName,
    required this.message,
  });

  @override
  final String id;
  @override
  final String displayName;
  final String message;

  @override
  Future<void> connect() async {}

  @override
  Future<void> disconnect() async {}

  @override
  Future<bool> testConnection() async => false;

  @override
  Future<List<AttendanceEvent>> syncSince(DateTime? checkpoint) async =>
      const [];

  @override
  Future<AttendanceSourceHealth> health() async {
    return AttendanceSourceHealth(
      status: AttendanceSourceHealthStatus.disabled,
      message: message,
    );
  }

  @override
  AttendanceEvent normalize(Map<String, dynamic> rawEvent) {
    throw UnsupportedError(message);
  }
}

class AdapterCatalog {
  const AdapterCatalog();

  List<AdapterDescriptor> get descriptors => const [
    AdapterDescriptor(
      id: 'csv-import',
      displayName: 'CSV / Excel import',
      status: 'Ready',
      summary:
          'Primary path. Export from the gym PC or device software, then import on the phone.',
      available: true,
    ),
    AdapterDescriptor(
      id: 'json-import',
      displayName: 'JSON import',
      status: 'Ready',
      summary:
          'Normalized GymPulse JSON: events with external_member_id and occurred_at.',
      available: true,
    ),
    AdapterDescriptor(
      id: 'mock-dev',
      displayName: 'Mock attendance (test only)',
      status: 'Ready',
      summary: 'Explicit development fixture. Never treated as a real vendor.',
      available: true,
    ),
    AdapterDescriptor(
      id: 'windows-connector',
      displayName: 'Windows connector export',
      status: 'Ready (PC tool)',
      summary:
          'Free offline .NET tool that normalizes official CSV/JSON exports for phone import. No cloud relay.',
      available: true,
    ),
    AdapterDescriptor(
      id: 'local-database',
      displayName: 'Local database adapter',
      status: 'Pending official docs',
      summary:
          'Use the Windows connector after a documented local export. GymPulse does not invent vendor database protocols.',
    ),
    AdapterDescriptor(
      id: 'rest-api',
      displayName: 'REST / local API adapter',
      status: 'Pending official docs',
      summary:
          'Enabled only when a gym system exposes a free/local API. Provide official docs before wiring it.',
    ),
    AdapterDescriptor(
      id: 'vendor-sdk',
      displayName: 'Vendor SDK adapter',
      status: 'Pending official docs',
      summary:
          'Real vendor SDKs only after official documentation is provided. No invented credentials or protocols.',
    ),
  ];

  AttendanceSource pending(String id) {
    final match = descriptors.firstWhere(
      (d) => d.id == id,
      orElse: () => const AdapterDescriptor(
        id: 'unknown',
        displayName: 'Unknown adapter',
        status: 'Disabled',
        summary: 'This adapter is not available.',
      ),
    );
    return PendingAttendanceAdapter(
      id: match.id,
      displayName: match.displayName,
      message: match.summary,
    );
  }
}
