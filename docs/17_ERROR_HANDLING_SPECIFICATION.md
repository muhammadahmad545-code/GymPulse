# GymPulse — Error Handling & Resilience Specification

## 1. Objective

Error handling is a first-class requirement.

The application must:
- fail safely
- explain problems clearly
- provide a recovery action whenever possible
- preserve user work where possible
- never expose stack traces/secrets
- log actionable technical context
- distinguish user errors from system errors
- distinguish stale data from zero data
- never silently discard attendance events

## 2. Error categories

Every error must belong to a known category.

### A. Validation errors
Examples:
- invalid phone number
- invalid membership dates
- missing required field
- unsupported file format

User experience:
- show field-level message
- highlight invalid field
- preserve other entered values
- do not submit until fixable validation errors are resolved

### B. Authentication errors (local unlock)
Examples:
- invalid app PIN
- lockout cool-down active
- lock timeout
- biometric unlock failure / unavailable
- PIN setup mismatch (confirm failed)
- PIN change current-PIN invalid

Behavior:
- show friendly message
- return to unlock/local sign-in screen when locked
- show remaining cool-down during lockout
- never reveal PIN values or hash material
- never reveal sensitive profile enumeration details across profiles where avoidable

### B2. Backup / restore errors
Examples:
- incorrect / invalid backup password
- corrupt/unreadable backup
- incompatible backup version
- interrupted backup creation
- insufficient storage
- interrupted restore
- integrity/authentication failure
- permission denied
- restore cancelled
- attempt to treat plaintext file as encrypted backup
- CSV validation failure / partial CSV import

Behavior:
- never mark backup/restore as successful on failure
- never write or leave behind plain-text sensitive full-backup payloads
- delete/abort partial backup output files when creation fails or is interrupted
- decrypt + verify before any live DB replacement
- write to temporary DB, verify, then atomic swap where technically possible
- never apply partial restore to the live database
- failed or interrupted restore must preserve the existing database
- show actionable user messages + Retry / Backup Now where appropriate
- for CSV (separate from encrypted backup): row-level error report when partial processing is allowed

User-facing examples:
- > Incorrect backup password. This backup cannot be opened.
- > This backup file is corrupted or unreadable.
- > This backup was created by a newer/incompatible GymPulse version.
- > Not enough storage to create a backup.
- > Restore was interrupted. Your existing data was not changed.

### C. Authorization errors
Examples:
- user lacks location access
- reception role attempts administrative action

Behavior:
- deny in service/repository layer
- return appropriate authorization error
- UI should hide unavailable actions where practical
- do not reveal restricted data

### D. Network errors (optional features only)
Examples:
- no internet during GitHub update check
- DNS failure
- timeout
- TLS failure
- release metadata unreachable

Behavior:
- core app continues using local data
- show retry for the optional network action only
- never block membership/attendance/follow-up workflows on network loss
- retry transient failures with bounded exponential backoff
- allow manual retry

### E. Application / service errors
Examples:
- unexpected domain service failure
- aggregate job failure
- local dependency failure

Behavior:
- show generic user-safe message
- attach request/correlation ID
- log technical details locally (structured)
- allow retry
- keep last known good aggregates with freshness

Example:
> Something went wrong while loading attendance. Try again.

Optional:
> Reference: GP-7F82A1

Never:
> NullReferenceException at MemberAnalyticsService.cs:182

### F. Database errors (local SQLite/Drift)
Behavior:
- never expose SQL/database details
- rollback failed transactions
- log query context safely
- retry only when operation is known to be safe/idempotent
- return stable application error codes
- offer backup/restore guidance on corruption

### G. Integration / import errors
Examples:
- attendance source stale
- unsupported file format
- malformed source record
- duplicate attendance event
- unknown member ID
- connector export missing

Behavior:
- preserve raw/source event when safe
- mark unmatched/error records
- show integration/import health
- provide reconciliation tools
- never interpret a missing/stale import as zero attendance

### H. Import errors
For CSV/Excel:
- validate headers
- validate rows
- produce row-level errors
- allow valid rows to be processed when safe
- provide downloadable error report
- use transactional/controlled import strategy
- prevent duplicate imports

### I. Notification/message errors
Examples:
- WhatsApp unavailable
- SMS provider failure
- push token invalid

Behavior:
- never mark a message as sent until provider confirmation
- allow retry
- show delivery status where provider supports it
- do not duplicate messages on retry

### J. Background job errors
Examples:
- analytics job fails
- daily summary job fails
- risk calculation job fails

Behavior:
- retry transient errors
- dead-letter/failed-job handling after retry limit
- alert operators
- keep previous valid aggregate available with a freshness timestamp
- never overwrite good data with invalid calculations

## 3. Error response contract

Application errors must follow one predictable structure:

```json
{
  "error": {
    "code": "ATTENDANCE_SYNC_FAILED",
    "message": "Attendance synchronization failed.",
    "requestId": "01J...",
    "retryable": true
  }
}
```

Rules:
- `code` is stable and machine-readable
- `message` is safe for the client/UI
- `requestId` allows support/debugging
- `retryable` guides UI behavior
- never include secrets
- never include stack traces
- never include SQL
- never expose internal infrastructure details

## 4. Error code strategy

Use namespaced/stable codes, for example:

```text
AUTH_INVALID_PIN
AUTH_UNLOCK_FAILED
AUTH_LOCKOUT_ACTIVE
AUTH_FORBIDDEN
VALIDATION_INVALID_FIELD
MEMBER_NOT_FOUND
MEMBERSHIP_INVALID_DATES
ATTENDANCE_SOURCE_OFFLINE
ATTENDANCE_SYNC_FAILED
ATTENDANCE_UNMATCHED_MEMBER
ATTENDANCE_DUPLICATE_EVENT
ATTENDANCE_DATA_STALE
ATTENDANCE_DATA_UNAVAILABLE
IMPORT_INVALID_FILE
IMPORT_PARTIAL_FAILURE
BACKUP_PASSPHRASE_INVALID
BACKUP_CORRUPT
BACKUP_INCOMPATIBLE_VERSION
BACKUP_INSUFFICIENT_STORAGE
BACKUP_INTERRUPTED
BACKUP_FAILED
BACKUP_PERMISSION_DENIED
RESTORE_INTERRUPTED
RESTORE_FAILED
RESTORE_INTEGRITY_FAILED
NOTIFICATION_SCHEDULE_FAILED
ANALYTICS_DATA_INSUFFICIENT
ANALYTICS_JOB_FAILED
DB_CORRUPTION_DETECTED
UPDATE_CHECK_FAILED
UPDATE_DOWNLOAD_FAILED
INTERNAL_UNEXPECTED_ERROR
```

Do not use HTTP status text as the application's only error identifier.

## 5. Status mapping for optional remote adapters

If an optional remote/sync adapter is introduced later, typical HTTP mapping may be used. For local MVP services, map failures to the stable error codes above without requiring HTTP.

## 6. Mobile error UX

Every async screen must have:

### Loading
Skeleton/progress indicator.

### Success
Show result and update local state.

### Empty
Explain why no data exists and what the user can do.

### Error
Explain:
1. what failed
2. whether the data may be stale
3. what action is available

Example:

> Attendance data couldn't be refreshed.
> Last successful sync: 12 minutes ago.

Actions:
- Retry
- View cached data

### Offline
Example:

> You're offline.
> Showing data from 14:22.

Action:
- Retry connection

## 7. Stale data

The app must distinguish:

- current
- recently refreshed
- stale
- unavailable

A dashboard must never silently present old analytics as live data.

Example:

> Last updated 18 minutes ago

If freshness exceeds configured threshold:

> Attendance data may be stale.

## 8. Retry strategy

Use bounded exponential backoff with jitter for transient operations.

Example conceptual schedule:
- immediate/short retry
- 2s
- 5s
- 15s
- then stop and surface an actionable error

Do not retry forever.

Do not automatically retry unsafe non-idempotent mutations unless idempotency protection exists.

## 9. Offline queue

Only safe operations should be queued.

Suitable examples:
- preference changes with versioning
- locally created notes where conflict handling exists

Attendance ingestion:
- connector queues source events locally
- events carry stable source IDs
- retries are idempotent
- successful acknowledgement removes/marks queued event

Never lose attendance events because the internet temporarily failed.

## 10. Conflict handling

For concurrent updates (multi-profile on one device, or future sync):
- detect version conflicts
- do not silently overwrite newer data
- explain conflict
- allow reload/merge where appropriate

## 11. Global exception handling

Flutter:
- install top-level error handling
- catch framework errors
- catch uncaught async errors
- write sanitized diagnostics to local logs (optional future opt-in crash reporting must remain non-mandatory)

Domain/services:
- centralized error mapping
- structured logging
- request/correlation IDs
- sanitized user-facing errors

Windows connector (optional tooling):
- global exception boundary
- persistent safe queue/export folder
- restart/recovery behavior
- health heartbeat / status file

## 12. Logging

Use structured logs.

Include where appropriate:
- timestamp
- service
- environment
- request ID
- organization ID in a privacy-safe/internal context
- location ID
- integration source ID
- operation
- error code
- duration
- retry count

Never log:
- passwords
- access tokens
- refresh tokens
- biometric templates
- full payment data
- unnecessary personal data

## 13. Monitoring and alerting

Monitor locally / in CI:
- error rate in logs
- crash-free sessions (device testing)
- failed aggregate jobs
- import failures
- attendance import delay/staleness
- unmatched attendance
- notification schedule failures
- database errors
- APK update check/download failures

Set alerts based on sustained thresholds for optional future sync; for MVP prefer in-app warnings and local notifications.

## 14. Integration resilience

For biometric/local connectors:
- checkpoint incremental sync
- idempotent ingestion
- local queue
- retry
- reconciliation
- last successful sync
- health heartbeat

If a connector is down:

DO NOT:
> Today's attendance = 0

Instead:
> Attendance unavailable. Last successful sync: 08:42.

## 15. Error UX copy rules

Good:
> We couldn't connect to your attendance system. Check the connector and try again.

Bad:
> Error 500.

Good:
> 14 rows imported. 3 rows need attention.

Bad:
> Import failed.

Good:
> Your session expired. Please sign in again.

Bad:
> UnauthorizedException.

## 16. Destructive-operation errors

For:
- delete member
- delete organization
- disconnect integration
- bulk operations

Use:
- confirmation
- clear consequences
- safe failure
- audit log
- recovery where possible

## 17. Security-related errors

Do not reveal:
- whether another tenant exists
- hidden resources
- credentials
- internal topology
- stack traces

Example:
If unauthorized to access member ID 123:
> Member not found.

or the application's standardized forbidden/not-found behavior, consistently applied to prevent enumeration.

## 18. Testing requirements

Every feature must test:
- expected success
- validation failure
- unauthorized access
- local DB failure/corruption handling
- stale data
- retry
- duplicate request/import
- malformed import/response
- recovery
- optional network failure for update checks without breaking core flows

Integration features additionally test:
- source stale/missing
- duplicate event
- unknown member
- malformed source data
- partial import
- reconnect/re-import
- reconciliation

## 19. Definition of done for error handling

A feature is not complete until:
- errors are classified
- stable error codes exist where applicable
- user-facing states exist
- retry behavior is defined
- logs are structured
- sensitive information is redacted
- tests cover failure paths
- stale/offline/local states are handled
- recovery action is available where possible
- core success does not depend on a paid cloud service
