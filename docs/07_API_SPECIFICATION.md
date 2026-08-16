> **SUPERSEDED.** Mr. Gym has no backend API. Local services only. See [19_MR_GYM_FINAL.md](19_MR_GYM_FINAL.md).

# GymPulse — Application Service Contracts

## Purpose

GymPulse MVP does **not** require a hosted HTTP backend.

This document defines the **application service contracts** used by the Flutter UI through repositories/services. Implementations are **local** (Drift/SQLite) by default.

The same contracts are intentionally shaped so an optional future remote/sync adapter can implement them without rewriting feature code.

Where a path-style name appears (e.g. `organizations.list`), it is a **logical operation name**, not a mandatory public cloud REST URL.

## Contract style

- Typed request/response models in Dart
- Predictable error objects
- Idempotency for imports/ingestion
- Cursor pagination for large local lists where needed

## Error format

```json
{
  "error": {
    "code": "MEMBER_NOT_FOUND",
    "message": "Member was not found.",
    "requestId": "...",
    "retryable": false
  }
}
```

Never expose stack traces, SQL, or secrets.

## Authentication / authorization

Local PIN unlock validates access to the app. After unlock, services validate:
- identity of the active local profile
- organization membership
- role
- location access

Authorization is enforced in services/repositories, not only in UI widgets.

Security operations:
- `security.setupPin`
- `security.unlock`
- `security.lock`
- `security.changePin`
- `security.getLockState`
- `security.factoryReset` (destructive; multi-step confirm)

## Operations

### Organizations
- `organizations.list`
- `organizations.get`
- `organizations.update`
- `organizations.create` (first-run setup)

### Locations
- `locations.list`
- `locations.create`
- `locations.get`
- `locations.update`

### Members
- `members.list` (filters: status, location, membership_status, risk_level, inactivity_days)
- `members.create`
- `members.get`
- `members.update`

### Memberships
- `memberships.list`
- `memberships.create`
- `memberships.update`

### Attendance
- `attendance.list`
- `members.attendance.list`
- `attendance.import` (CSV/file)
- `integrations.attendanceEvents.ingest` (adapter/normalized batch)

### Follow-ups
- `followUps.list`
- `followUps.create`
- `followUps.update`
- `followUps.resolve`
- `followUps.snooze`

### Trials
- `trials.list`
- `trials.create`
- `trials.update`

### Cancellations
- `cancellations.list`
- `cancellations.create`

### Analytics
- `analytics.health`
- `analytics.attendance`
- `analytics.peakHours`
- `analytics.retention`
- `analytics.trials`
- `analytics.cancellations`

### Integrations
- `integrations.list`
- `integrations.create`
- `integrations.get`
- `integrations.test`
- `integrations.syncOrImport`
- `integrations.reconcile`

### Backup
- `backup.createEncrypted` (password + confirm; unrecoverable-password warning)
- `backup.share`
- `backup.restore` (password + confirm; atomic swap)
- `backup.status` (last backup/restore times, stale flag, last error)
- `backup.getReminderSettings` / `backup.updateReminderSettings`
- `backup.exportCsv` (dataset key; not encrypted backup)
- `backup.importCsv` (dataset key / attendance)

### App updates (distribution only)
- `appUpdates.check` (GitHub Releases metadata; optional network)
- `appUpdates.downloadAndInstall` (Android package installer with user consent)

## Idempotency

All ingestion/import operations must support idempotency where duplicate delivery is possible.

Use:
- external_event_id
- source_id
- import batch idempotency key when available

## Pagination

Cursor-based pagination for large local datasets (especially attendance).

## Rate limiting

Not applicable to local DB calls as a cloud concern.

For optional network operations (update checks, future sync, optional remote adapters):
- bound concurrency
- backoff on failure
- avoid abusive polling

## Versioning

Never silently break local repository contracts within a release train.

Schema migrations must be backward-compatible or provide explicit migration paths.

## Future remote API (optional)

If a remote sync backend is ever introduced:

- It may expose REST `/api/v1` or equivalent
- It must implement the same domain operations behind repositories
- It must remain **optional** and disabled by default
- Local-first behavior must continue when remote is unavailable
- It must not introduce a mandatory paid dependency without explicit product approval

## Outbound webhooks

Outbound cloud webhooks are **not** part of MVP.

Local notification + on-device events replace them for core workflows.
