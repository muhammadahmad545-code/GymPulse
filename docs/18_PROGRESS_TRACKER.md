# Mr. Gym — Progress Tracker

**Product:** Mr. Gym (offline single-gym management)  
**Repo:** https://github.com/muhammadahmad545-code/GymPulse  
**Package ID:** `com.gympulse.app`  
**Latest release:** [v1.0.0](https://github.com/muhammadahmad545-code/GymPulse/releases/tag/v1.0.0) (`1.0.0+8`)

The old GymPulse Phase 4/5 SaaS / biometric / AI roadmap is **cancelled**. This tracker describes the final Mr. Gym MVP only.

## Current status

| Item | Status |
|---|---|
| Product rebaseline to Mr. Gym | Done |
| Offline Flutter + Drift/SQLite | Done |
| In-app Mark Attendance | Done |
| Same-day duplicate protection | Done |
| Calendar-month fee cycle | Done |
| 3-day and due-today reminders | Done |
| WhatsApp intent (opened, not sent) | Done |
| Today dashboard | Done |
| Member search / filters | Done |
| Deterministic retention | Kept from Phase 2 |
| Trials / cancellations / custom reasons | Done |
| Renewal history | Done |
| Encrypted backup/restore | Kept |
| CSV export (not import) | Done |
| Local notifications | Done |
| PIN / lock / factory reset | Kept |
| GitHub optional updater | Kept |
| Hidden: import, locations, biometric, AI | Done |

## Historical releases (pre-rebaseline)

| Version | Code | Notes |
|---|---|---|
| 0.0.1 | 1 | Foundation, PIN, Drift, backup |
| 0.1.0–0.1.3 | 2–5 | MVP + GitHub updater |
| 0.2.0 | 6 | Retention intelligence |
| 0.3.0 | 7 | Operations analytics |

Those builds still used the GymPulse name and older attendance-import assumptions. v1.0.0 is the first Mr. Gym product release.

## Conflict decisions

- Keep `organizations` / `locations` tables internally; hide multi-gym UI.
- Keep `com.gympulse.app` so updates can replace previous installs.
- Keep import/connector code on disk for migration tests; remove from primary UI.
- Do not claim WhatsApp "sent".
- Do not claim physical-device QA unless a device was actually used.

## QA (v1.0.0)

- `flutter analyze`: no issues
- `flutter test`: 70 passed
- Coverage includes fee-cycle, duplicate attendance, reminder once-per-cycle, WhatsApp template (no “sent”), search, custom cancellation reasons, renewal history, 200-member directory performance, plus existing Phase 0–3 / updater tests
- Release APK built: `GymPulse-1.0.0.apk` (64,245,136 bytes)
- SHA-256: `b271cae63f78cbeddf298bc01794c8fefaf8ccae0fe4b1bfaa5a72001ba55a89`
- Signing: debug (honest; not production)
- Physical device: **not tested by the agent**. Automated QA passed; physical-device verification remains required.

## Stop rule

After v1.0.0 ships, do **not** start another product phase unless the owner requests it.
