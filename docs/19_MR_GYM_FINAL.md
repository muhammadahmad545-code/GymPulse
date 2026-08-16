# Mr. Gym — Final product specification

This document replaces the old GymPulse Phase 4/5 roadmap.

## Identity

- Display name: **Mr. Gym**
- Application ID: `com.gympulse.app`
- One gym. Organization/location tables may remain internally for migration safety. The UI does not offer add/switch gym.

## Offline architecture

Core data lives in Drift/SQLite on the Android device. No cloud backend is required.

Internet may be used only to:

- open WhatsApp via Android intent
- optionally download an APK from GitHub Releases

## Attendance

Reception searches a member and taps **Mark Attendance**.

Stored fields:

- member ID
- local date (`YYYY-MM-DD`)
- local date/time
- UTC timestamp
- `isManual = true`

Default rule: one manual mark per member per local day. A duplicate attempt shows the member name and today's time and requires an explicit "Record another visit" action.

Attendance import is not part of the primary product. Historical import code may remain for migration compatibility.

## Members

Required:

- Full name
- WhatsApp number (when WhatsApp reminders are enabled)
- Joining Date / Fee Date

Duplicate names are allowed. The unique identifier is the member UUID.

## Fee cycle

Joining/Fee date is the recurring monthly fee day.

Rule: same calendar day next month when that day exists; otherwise the last valid day of the month.

Examples:

- 10 August → 10 September
- 31 January 2026 → 28 February 2026
- 31 January 2024 → 29 February 2024

Do not add 30 days.

## Reminders

For each member and fee cycle:

- `due_in_3_days` once
- `due_today` once

Statuses: `pending`, `opened`, `dismissed`, `completed`.

Opening WhatsApp → `opened`. The app never claims WhatsApp delivery.

Default messages:

```
Assalam-o-Alaikum [Name],

This is a friendly reminder from Mr. Gym that your monthly gym fee is due on [Fee Date].

Thank you,
Mr. Gym
```

3-day variant: "due in 3 days, on [Fee Date]".

## Retention, trials, cancellations

Keep deterministic risk scores, attendance decline vs personal baseline, trials, cancellations, and renewals.

Custom cancellation reasons can be added or deactivated. Historical reason rows are not deleted.

Renewal creates a new membership row and marks the previous row `renewed`.

## Backup

Encrypted local backup/restore remains the disaster-recovery path. Wrong password, corrupt file, or interrupted restore must not modify the live database.

CSV export is labeled as not an encrypted backup.

## Signing

This team-lead build is **debug-signed**, same as previous GymPulse APKs, so in-place updates continue to work. A production keystore is not configured in the repository. Secrets are never committed. Do not claim Play Store / production signing.

## WhatsApp limitation

WhatsApp messages require user confirmation in WhatsApp because the application is offline and does not use WhatsApp Business/API services.
