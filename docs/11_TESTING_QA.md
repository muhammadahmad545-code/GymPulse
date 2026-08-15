# GymPulse — Testing & QA Specification

## 1. Testing pyramid

- Unit tests
- Widget/component tests
- Integration tests (local DB / Drift)
- Repository/service contract tests
- Database isolation/authorization tests
- End-to-end tests
- Device tests (physical Android)
- Connector/import adapter tests

No mandatory cloud API suite is required for MVP core features.

## 2. Mandatory unit coverage

Test:
- membership expiry calculations
- timezone conversions
- inactivity rules
- risk score
- health score
- trial conversion
- peak-hour calculations
- cancellation percentages
- duplicate attendance handling
- CSV parse/normalize

## 3. Timezone tests

Test gyms in:
- UTC
- UTC+5
- UTC-5
- DST-observing zones
- DST-free zones

Never compare naive timestamps.

## 4. Attendance tests

Cases:
- duplicate event
- late event
- future event
- unknown member
- missing event ID
- import file missing/unreadable
- partial CSV import
- malformed event/row
- stale source health ≠ zero attendance

## 5. Multi-tenant tests

Local profile for organization A must never:
- read organization B
- modify organization B
- export organization B

Test at repository/service level, not just UI.

## 6. Role / security tests

Also test:
- first-launch PIN setup
- unlock success/failure
- progressive lockout
- auto-lock / manual lock
- PIN change
- backup restore recovery path
- factory reset confirmation path
- OS biometric convenience disabled/enabled without removing PIN

Owner:
- full access

Admin:
- configured administrative access

Manager:
- assigned locations

Reception:
- operational member/follow-up access

Analyst:
- read-only analytics

## 6b. Backup & restore tests (mandatory)

Encrypted backup / restore:
- create encrypted backup succeeds; output is not plain-text business data
- password confirmation mismatch blocks creation
- forgotten-password warning is shown at creation
- wrong/invalid password fails decrypt cleanly (`BACKUP_PASSPHRASE_INVALID`)
- corrupted backup rejected (`BACKUP_CORRUPT` / integrity failure)
- incompatible backup version rejected
- interrupted backup creation leaves no successful plaintext/partial sensitive artifact; status not success
- insufficient storage fails with clear error
- interrupted restore preserves existing live DB
- failed restore does not corrupt existing DB
- successful restore is atomic (temp → verify → swap) where technically possible; no partial live restore
- permission denied paths handled
- no plaintext backup password/key in logs, prefs, or DB columns
- Android secure storage/Keystore used appropriately for PIN/ephemeral key handling per security spec

Backup Reminder:
- last backup date/time displayed
- stale warning when older than configured interval (and when never backed up after data exists)
- configurable reminder interval persists
- Backup Now action opens create flow
- failed Backup Now shows clear error + retry

CSV (separate from encrypted backup):
- CSV export authorization
- CSV import validation/partial failure report
- UI does not label CSV as encrypted backup

Status:
- last successful backup/restore times accurate
- failed attempt never marked success

## 7. UI tests

Verify:
- dark mode
- light mode
- small screens
- tablets
- large text
- RTL scaffold
- localization keys
- loading
- empty
- error
- offline (always-on local)
- slow import

## 8. Performance targets

Initial goals:
- cold start: reasonable on mid-range devices
- dashboard render from local DB: near-instant after first load
- import of typical CSV sizes without UI freezes (use isolates where needed)
- analytics jobs asynchronous
- no UI thread blocking

Measure rather than blindly guarantee.

## 9. Security QA

Run:
- dependency audit
- secret scanning
- local authorization tests
- import validation tests
- storage security tests
- export authorization tests
- APK update verification tests (package/version/hash)

## 10. Release gates

Do not release if:
- organization isolation test fails
- crash-critical defect exists
- attendance duplication is possible
- timezone calculation is wrong
- data can be exposed through unauthorized exports
- import silently loses events
- core feature requires a paid cloud service

## 11. Error-handling test matrix

Every production feature must test at least:

| Failure | Expected behavior |
|---|---|
| Corrupt/missing local DB | Safe recovery guidance + backup restore path |
| Corrupted backup file | Reject; clear error; live DB unchanged |
| Invalid backup password | Reject decrypt; clear error |
| Incompatible backup version | Reject; clear error |
| Interrupted backup | Not success; no plaintext/partial sensitive artifact retained |
| Insufficient storage (backup) | Clear error; no success mark |
| Interrupted / failed restore | Live DB preserved; no partial apply |
| Successful restore | Atomic temp→verify→swap where technically possible |
| Import timeout/cancel | Partial-safe handling + report |
| Duplicate import | Idempotent/conflict-safe result |
| Stale attendance source | Freshness warning, never zero attendance |
| Unknown member | Unmatched queue |
| Duplicate attendance | Deduplicated |
| Partial import | Row-level report |
| Notification schedule failure | Not marked as delivered |
| Background aggregate failure | Retry + keep last good metrics + freshness |
| Unexpected exception | Sanitized error + local diagnostics |
| Update download failure | Actionable retry; no partial install |
| External WhatsApp intent unavailable | Friendly fallback (copy/share/call) |

No critical user flow is considered complete until its failure paths are tested.
