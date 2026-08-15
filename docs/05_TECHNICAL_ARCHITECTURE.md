# GymPulse — Technical Architecture

## 1. Architecture principle: local-first, zero mandatory cloud cost

GymPulse is a **local-first** Flutter application.

- Core features must work fully **offline** on the owner's Android device.
- Primary persistence is **on-device SQLite** via **Drift**.
- There is **no mandatory paid backend, hosting, database, or cloud service**.
- Supabase, Firebase, hosted Postgres, and similar services are **not** required for MVP or ongoing core use.
- Repository and service abstractions must allow an **optional** future sync backend without rewriting domain logic.

## 2. Recommended stack

### Mobile app
Flutter + Dart.

Reason:
- single codebase for Android/iOS
- native compilation
- strong platform integration
- mature ecosystem
- suitable for scalable feature-rich applications
- developable from Cursor/VS Code + CLI

### Persistence
Drift + SQLite on device.

Reason:
- type-safe queries and migrations
- solid Flutter integration
- no hosting cost
- works offline
- supports relational multi-location / multi-org schema on one device

### State management
Riverpod (consistent across the app).

### Auth (MVP)
Mandatory local app protection via **user-created PIN/passcode**:

- first-launch PIN create/confirm
- unlock screen
- progressive lockout / rate limiting
- manual lock + idle/background auto-lock
- PIN change (current + new + confirm)
- recovery via encrypted backup restore or destructive factory reset
- optional OS biometric convenience unlock after PIN exists

PIN is stored as salted one-way hash in secure/local storage — never plaintext.

No cloud identity provider required.

See Feature Specification §1 for full behavior.

### Notifications
- **Local notifications** for reminders, follow-up due items, daily summaries, integration warnings, and backup reminders
- No mandatory FCM/APNs cloud push provider for MVP

### Backup & Restore
On-device **encrypted** full backup create/share/restore is mandatory for MVP.

- Backup files must not store sensitive business data as plaintext.
- Password confirmation + unrecoverable-password warning at creation.
- KDF + authenticated encryption; no plaintext password/key storage.
- Android Keystore / secure storage used appropriately for PIN and ephemeral key handling.
- Restore: decrypt/verify → temp DB → integrity check → atomic swap; failed/interrupted restore preserves live DB.
- Backup Reminder: last backup time, configurable stale interval, Backup Now, clear failure errors.
- CSV export/import is separate interoperability (not an encrypted backup substitute).
- No cloud backup service.

### Messaging (WhatsApp / SMS)
- Open external WhatsApp / dialer / share intents
- Editable message templates stored locally
- **No** paid WhatsApp Business API dependency

### Integration connector (optional tooling)
For gyms that need help exporting from a reception PC:

- Optional **Windows connector** (.NET 10 LTS worker) that reads a supported local source and writes **normalized CSV/JSON** for phone import
- Optional future LAN transfer to the phone (free local network) — never a paid cloud relay
- Vendor adapters only with official documentation

### Observability (cost-free for MVP)
- Structured on-device logs
- Local audit log table
- Optional future opt-in crash reporting (must remain non-mandatory and free/self-hostable if introduced)

### Distribution / updates
- GitHub source remote + GitHub Releases for APK testing distribution (free)
- `AppUpdateService` → `GitHubReleaseUpdateProvider` (now) / `PlayStoreUpdateProvider` (future)

## 3. Architecture diagram

```text
Flutter Mobile App (UI / ViewModels)
              |
              v
    Domain Services (on-device)
              |
              v
         Repositories  ---------------------> SyncPort (future optional)
              |                                      |
              v                                      v
     Local Data Source                    Optional Cloud Adapter
     (Drift / SQLite)                     (NOT required for MVP)
              |
              v
     Attendance Integration Layer
              |
              +-- CsvImportAdapter          (MVP primary)
              +-- ManualImportAdapter
              +-- RestApiAdapter            (optional when free/local)
              +-- LocalDatabaseAdapter      (via connector export)
              +-- WindowsConnectorExport    (file / optional LAN)
              +-- VendorSdkAdapter          (only with official docs)
              +-- WebhookAdapter            (future; not MVP-required)
```

## 4. Mobile architecture

Use feature-first structure with:
- presentation/views
- view models/controllers
- repositories
- services
- models
- shared design system

Do not put business logic directly into widgets.

Repositories expose domain interfaces. Default implementations are local (Drift). Future cloud sync implementations plug in behind the same interfaces.

## 5. Networking

Networking is **not** required for core MVP features.

When network is used (GitHub update checks, optional future sync, optional remote attendance APIs):
- typed clients
- interceptors
- bounded retry + exponential backoff
- request IDs where applicable
- consistent error model
- never block core offline workflows on network failure

## 6. Local data

SQLite/Drift stores:
- organizations, locations, users/profiles, roles
- members, memberships, plans
- attendance sources/events
- trials, follow-ups, cancellations
- risk/health aggregates
- audit logs
- preferences and message templates
- integration sync metadata

Use secure storage (platform keystore / flutter_secure_storage) for:
- app unlock secrets / tokens if any
- encryption keys for sensitive local fields where justified

## 7. Multi-tenancy (on-device)

Every organization-owned record must carry tenant context:

- `organization_id`
- `location_id` where applicable

Enforce authorization in domain services / repositories so a local profile cannot access another organization's data on the same device.

Never trust UI-supplied organization IDs without service-layer checks.

## 8. Background processing

Use on-device asynchronous work for:
- attendance ingestion/import
- aggregation
- risk calculation
- daily summaries
- large exports
- local notification scheduling

Do not freeze the UI thread for expensive analytics. Prefer isolates / background tasks as appropriate for Flutter on Android.

## 9. Analytics data model

Keep raw events immutable where practical.

Pipeline (all on-device):

```text
Raw attendance
→ normalized attendance
→ daily/member aggregates
→ retention features
→ risk calculation
→ dashboard metrics
```

## 10. Integration reliability

Each adapter/source must report:
- connected/disconnected / last import status
- last successful ingest
- last attempted ingest
- records imported
- duplicate records ignored
- errors
- device/source identifier

CSV import is the MVP path. Missing imports must never be interpreted as zero attendance.

## 11. Offline behavior

The app **is** the system of record for MVP.

- Always operate from local database
- Show data freshness for imports/aggregates
- Never pretend import/sync completed if it failed
- Optional future cloud sync must be additive, not required

## 12. Scalability and modularity

Use a modular **on-device** monolith:

- Identity (local PIN)
- Organizations
- Members
- Memberships
- Attendance
- Trials
- Retention
- Follow-ups
- Analytics
- Integrations
- Notifications (local)
- BackupRestore
- Audit
- App Updates

Do not introduce microservices, mandatory cloud infra, or paid platforms.

## 13. Future optional cloud sync (non-goals for MVP)

A future optional sync backend may:
- replicate encrypted tenant data across devices
- enable shared staff accounts

It must:
- plug in via `SyncPort` / repository adapters
- remain disabled by default
- never become a paid mandatory dependency without explicit product approval
- preserve local-first operation when sync is unavailable
