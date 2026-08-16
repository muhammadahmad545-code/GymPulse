# Mr. Gym — Offline Gym Management

This repository is the source of truth for **Mr. Gym**, a dedicated offline-first management application for one gym: **Mr. Gym**.

It is not a global SaaS platform, not a multi-gym marketplace, and not a biometric hardware product.

## Product promise

> What does Mr. Gym need to handle today?

Daily work is local: create members, mark attendance, track monthly fees, open WhatsApp with a prefilled reminder, and keep encrypted backups on the phone.

## Hard constraints

- Completely offline for core operation (Wi-Fi off, mobile data off, airplane mode).
- Flutter + Riverpod + Drift / SQLite only.
- No Supabase, Firebase, cloud database, backend server, paid API, analytics service, or AI/ML.
- No biometric hardware, fingerprint/face templates, or attendance CSV/JSON import in the primary product.
- Internet is optional and only used to open WhatsApp or download a GitHub APK update.
- Package ID remains `com.gympulse.app`.

## Architecture

- Local SQLite is the system of record.
- Attendance is marked in-app: search member → open member → **Mark Attendance**.
- One manual attendance record per member per local day by default. A second mark requires an explicit override.
- Fee dates use calendar-month arithmetic (same day when possible, otherwise last valid day of the month).
- Fee reminders: 3 days before and on the fee date, once per member/cycle/type.
- Opening WhatsApp sets reminder status to **opened**, never **sent**.
- Retention scores are deterministic and explainable. Nothing is labeled AI.
- Encrypted local backup/restore remains mandatory. CSV export is reporting only.

## Documentation map

| Doc | Status |
|---|---|
| [19_MR_GYM_FINAL.md](19_MR_GYM_FINAL.md) | **Current product specification** |
| [18_PROGRESS_TRACKER.md](18_PROGRESS_TRACKER.md) | Current release status |
| [17_ERROR_HANDLING_SPECIFICATION.md](17_ERROR_HANDLING_SPECIFICATION.md) | Still in force |
| [04_DESIGN_SYSTEM.md](04_DESIGN_SYSTEM.md) | Visual system (branded as Mr. Gym) |
| [10_SECURITY_PRIVACY_COMPLIANCE.md](10_SECURITY_PRIVACY_COMPLIANCE.md) | PIN, backup, no cloud auth |
| Docs 01–16 | Historical GymPulse drafts. Superseded where they conflict with this README or doc 19. |

Obsolete product concepts (do not implement):

- Cloud tenancy / organizations / multi-location UX
- Biometric devices, vendor adapters, Windows connector as a required workflow
- Attendance CSV/JSON import as the attendance system
- AI assistants, ML models, churn prediction APIs
