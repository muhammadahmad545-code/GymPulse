> **SUPERSEDED.** Phase 4/5 and later GymPulse phases are cancelled. The final product is Mr. Gym v1.0.0. See [18_PROGRESS_TRACKER.md](18_PROGRESS_TRACKER.md).

# GymPulse — Product Roadmap

## Cost constraint (all phases)

Every phase must preserve **local-first operation** with **zero mandatory paid cloud/backend cost**. Optional sync may appear later only as an explicitly approved, non-mandatory capability.

## Phase 0 — Foundation

- Product architecture (local-first; zero mandatory cloud cost)
- Design system
- Local PIN setup/unlock/lockout/change/recovery contracts (UI shell + security_state)
- Multi-tenancy on device
- Organization/location
- Member model
- Membership model
- Attendance canonical model
- Drift/SQLite schema
- Audit logging
- AppUpdateService skeleton
- GitHub APK pipeline (distribution only; not runtime backend)

## Phase 1 — MVP

Build only what proves the core value:

1. Organization setup (country/timezone/currency/configurable gym settings)
2. Members
3. Memberships
4. Attendance CSV import + mock attendance source
5. Adapter interface (biometric extensibility without vendor invention)
6. Dashboard with stale/unavailable attendance states (never zero-from-missing)
7. Expiry detection
8. Inactivity detection
9. Follow-up queue
10. WhatsApp/copy/call via external intents
11. Basic attendance analytics + peak hours foundation
12. Health score
13. Integration/import health
14. Local notifications
15. **Complete Local Backup & Restore** (encrypted-only full backups; password confirm + unrecoverable warning; Keystore-safe handling; atomic restore; Backup Reminder with last backup time / stale warning / configurable interval / Backup Now / clear errors; CSV export/import separate from encrypted backup)

Phase 1 must preserve architecture hooks for trial conversion and cancellation reasons (data model + navigation placeholders acceptable only if explicitly labeled incomplete — prefer shipping basic trial/cancellation capture in MVP when feasible; full analytics may continue in Phase 2).

## Phase 2 — Retention Intelligence

- Member risk score
- Attendance decline
- Advanced follow-up prioritization
- Renewal analytics
- Member detail timeline
- Trial conversion
- Cancellation reasons

## Phase 3 — Operations Intelligence

- Peak-hour analysis
- Capacity utilization
- Multi-location analytics
- Advanced reporting
- Scheduled local reports/notifications
- Optional free Windows connector export tooling
- Better adapter ecosystem (still no paid cloud required)

## Phase 4 — Global Scale (still local-first)

- More biometric export adapters (official docs only)
- Localization packs beyond English
- Regional compliance tooling
- Enterprise organization controls on device
- Advanced exports
- Optional multi-device sync design spike (must remain optional and cost-approved)

## Phase 5 — Advanced intelligence

Only after adequate on-device data:
- churn prediction (on-device / explainable)
- renewal prediction
- recommended contact timing
- anomaly detection
- optional assistant features that do not require paid cloud by default

## MVP success criterion

A gym owner should be able to import attendance data and answer:

> Who needs my attention today?

within one minute — fully offline after install/import.

## Avoid feature creep

If a proposed feature does not directly improve:
- retention
- attendance understanding
- follow-up
- membership conversion
- owner decision-making

defer it.

If a proposed feature requires a mandatory paid cloud service, reject it unless explicitly re-approved as an optional paid product.
