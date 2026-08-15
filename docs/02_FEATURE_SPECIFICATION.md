# GymPulse — Functional Feature Specification

## 1. Authentication (local PIN / passcode)

GymPulse uses **secure local app protection**. There is no cloud identity provider for MVP.

Primary credential: a **user-created PIN/passcode** (not gym fingerprint templates, not a paid auth SaaS).

Optional convenience after PIN is set: OS biometric unlock (device fingerprint/face) that only unlocks the already-configured app session. OS biometrics never replace the requirement to create a PIN, and never store gym member biometric templates.

Roles (local authorization after unlock):
- Owner
- Admin
- Manager
- Reception
- Analyst/read-only

Cloud identity providers, SSO, and shared multi-device accounts are **out of scope for MVP** and may only be added later behind optional sync abstractions.

### 1.1 First-launch setup

On first launch (no PIN configured):

1. Show GymPulse welcome / privacy (local-data) notice.
2. Require creation of an app PIN/passcode:
   - minimum length: 6 digits for numeric PIN, or equivalent strength policy if alphanumeric passcode is enabled
   - confirm by re-entry
   - store only a **salted one-way hash** (never plaintext PIN)
3. Optionally offer OS biometric unlock for convenience (can be enabled later in Settings).
4. Show backup education: “Your data stays on this phone. Create encrypted backups regularly.”
5. Continue to organization setup (country, timezone, currency, location, etc.).

If the user abandons setup before PIN confirmation, no unprotected access to business data is allowed.

### 1.2 Unlock

- Cold start and lock timeout present an Unlock screen.
- User enters PIN (or OS biometric if enabled).
- Successful unlock opens the last active local profile/session within policy.
- Failed attempts show a clear, non-enumerating error: “Incorrect PIN. Try again.”

### 1.3 Lockout / rate limiting

- After consecutive failures, apply progressive lockout (example policy):
  - 5 failures → short cool-down (e.g. 30 seconds)
  - further failures → increasing cool-down (e.g. 5 minutes, then longer)
- Show remaining cool-down time.
- Lockout state is stored securely on device.
- Lockout never silently wipes data.
- After lockout window ends, user may retry or use recovery paths below.

Exact numeric thresholds may be tuned, but rate limiting is mandatory.

### 1.4 Logout / lock behavior

- Manual **Lock app** from Settings / profile menu returns to Unlock immediately.
- Auto-lock after configurable idle timeout (default on; owner-configurable).
- Lock on app background after a short grace period (configurable).
- Locking does not delete data; it only requires re-unlock.

### 1.5 PIN change

From Settings (while unlocked):

1. Enter current PIN.
2. Enter new PIN.
3. Confirm new PIN.
4. Re-hash and store; update audit log (“pin_changed”).
5. Optionally re-prompt to enable/disable OS biometric convenience.

Failed current-PIN verification does not reveal the correct PIN and counts toward rate limiting if abused.

### 1.6 Recovery / reset behavior

There is **no cloud “forgot PIN” email reset**.

Supported recovery paths:

**A. Restore from encrypted backup (preferred)**  
- User chooses Restore on the unlock/recovery screen.  
- Selects a GymPulse backup file.  
- Enters the **backup passphrase** (separate from app PIN; chosen when the backup was created).  
- On success: local database is replaced/restored per restore rules, and the restored app PIN state from backup applies (or user is guided to set a new PIN if backup policy requires re-PIN — document the chosen behavior in implementation as: restore includes PIN hash from backup; user unlocks with the PIN that was active when backup was made, then may change PIN).  
- On failure: clear error; no partial corrupt overwrite.

**B. Destructive factory reset (last resort)**  
- Multi-step typed confirmation (e.g. type RESET).  
- Explicit warning: all local GymPulse data on this device will be permanently deleted.  
- Recommend exporting/finding a backup first.  
- After reset: return to first-launch PIN setup with empty database.  
- Audit trail on device is wiped with the data (expected).

Never:
- store PIN in plaintext
- sync PIN to GitHub or any cloud by default
- bypass unlock for “demo” in production builds
- use gym biometric templates for app unlock

## 2. Organization setup

On first setup (after PIN):
1. Create organization
2. Add gym location
3. Select country
4. Select timezone
5. Select currency
6. Add membership rules
7. Configure inactivity thresholds
8. Configure notification preferences (local)
9. Configure attendance integration (CSV/adapters)
10. Confirm backup reminder

All setup data is stored in the local SQLite database.

Gym settings remain configurable per organization/location (thresholds, capacity, templates, holidays/closures, etc.).

## 3. Member model

Member profile:
- Internal member ID
- External member ID
- Name
- Phone
- Email (optional)
- Membership status
- Membership start/end
- Trial status
- Last attendance
- Attendance frequency
- Risk score
- Consent/preferences
- Location

Do not store biometric fingerprint templates, fingerprint images, or biometric credentials in GymPulse. Attendance identity should preferably arrive as an external member/device identifier.

## 4. Membership expiry

Rules:
- Expiring in configurable windows: 1, 3, 7, 14, 30 days
- Expired
- Renewed
- Never assume renewal if payment confirmation is unavailable

Actions:
- Contact
- Copy message
- Snooze
- Mark resolved

## 5. Inactivity

Default example thresholds:
- 7 days: Monitor
- 14 days: Follow-up
- 21 days: High risk
- 30 days: Critical

These are configurable per location.

The engine must account for:
- Member's historical attendance
- Membership status
- Trial status
- Expected schedule if available
- Holidays/closure days
- Location timezone

Do not label someone "inactive" solely because of a missing event if the integration/import source is unhealthy or stale.

## 6. Attendance anomaly protection

If no attendance events arrive for a configured period while imports are expected:

Show:
> Attendance sync may be delayed.

Do not interpret missing data as zero attendance.

## 7. Follow-up center

Every action has:
- Reason
- Priority
- Created time
- Due time
- Assigned user (local profile)
- Status
- Contact channel
- Resolution note

Statuses:
- New
- In progress
- Contacted
- Snoozed
- Resolved
- Dismissed

## 8. Message generation

Templates support variables:
- {{member_name}}
- {{gym_name}}
- {{expiry_date}}
- {{days_since_visit}}
- {{gym_phone}}

Messages must be editable before external sending.

Contact flow:
1. Owner taps Contact
2. Review/edit template message
3. Open WhatsApp / dialer / share via **external intent**
4. Mark contacted manually or after returning (never assume delivery success from launching an intent alone)

Avoid deceptive, manipulative or threatening wording.

Do not require a paid WhatsApp Business API.

## 9. Gym Health Score

Score components should be configurable but default to:
- Retention
- Attendance health
- Membership renewal
- Trial conversion
- Member engagement
- Data quality

Each component must have:
- score
- confidence
- explanation
- data freshness

Never display a precise score when there is insufficient data. Use:
> Not enough data

instead.

Computed entirely on-device.

## 10. Peak-hour analytics

Calculate on-device:
- attendance by local hour
- attendance by day of week
- rolling average
- peak windows
- capacity utilization if gym capacity is configured

Never call a time "crowded" unless capacity or a configured threshold exists.

## 11. Trial conversion

Track:
- Trial started
- Trial end
- Converted
- Cancelled/expired
- Conversion source

Conversion:
`converted_trials / eligible_trials * 100`

Define eligibility explicitly and consistently.

## 12. Cancellation reasons

Support customizable reasons.

Default:
- Price
- Moving
- Schedule
- Equipment
- Trainer
- Not satisfied
- Found another gym
- Other

Allow anonymous member feedback if configured.

## 13. Notifications

Local notifications for:
- Integration/import failure or staleness
- High-risk member threshold
- Large expiry queue
- Trial expiry
- Daily summary / follow-ups due
- **Backup reminder** when last backup is stale or missing (per configurable interval)

Allow notification controls.

No mandatory cloud push provider.

## 14. Search

Global search should find:
- Members
- Memberships
- Follow-ups
- Locations
- Attendance events

Search must be organization/tenant-scoped on device.

## 15. Export

Allow authorized local profiles to export:
- Member list
- Attendance reports
- Follow-up report
- Trial report
- Cancellation report

Use CSV for simple exports and generated reports for richer exports.

Exports support portability and backups without a cloud dependency.

## 16. Audit log

Track locally:
- Unlock / lock / unlock failures (without recording PIN values)
- PIN change
- Role changes
- Member edits
- Membership edits
- Imports
- Integration changes
- Exports
- Backup create / restore / factory reset
- Follow-up changes
- Data deletion

## 17. Local Backup & Restore (MVP mandatory)

Local Backup & Restore is a **core MVP feature**. Cloud backup is **not** required and must never become mandatory without explicit owner approval.

**Hard rule:** Backup files must **never** be written as plain-text sensitive business data. Member PII, attendance, memberships, follow-ups, and related operational data in a GymPulse backup package must be stored only in an **encrypted** form.

CSV business exports (separate from encrypted full backups) are intentional plain-text interoperability files; they require authorization, audit logging, and clear UI labeling that CSV is not an encrypted backup.

### 17.1 Encryption & password flow

When creating a full GymPulse backup:

1. User enters a **backup password/passphrase** (distinct from the app PIN).
2. User **confirms** the password by re-entry; mismatch blocks creation.
3. Show an explicit, unavoidable warning before continuing, for example:
   > If you forget this backup password, this backup cannot be recovered. GymPulse cannot reset it.
4. Derive an encryption key from the password using a modern KDF (e.g. Argon2id or PBKDF2-HMAC-SHA256 with high iteration count / memory parameters appropriate for mobile). Do **not** store the backup password or derived key in plaintext anywhere (app storage, logs, analytics, GitHub, or the backup header).
5. Encrypt the backup payload with authenticated encryption (e.g. AES-256-GCM). Include integrity verification (auth tag / checksum over ciphertext + version metadata).
6. Write a portable `.gympulse-backup` (or equivalent) file containing only:
   - non-sensitive metadata needed to open the file (format version, KDF params, salt, IV/nonce, created_at, app version)
   - **ciphertext** of the business payload
7. Clear password material from memory as soon as practical after key derivation/use.

**Android secure storage / Keystore (where applicable):**
- App PIN hash/salt and lockout state use platform-appropriate secure storage.
- Ephemeral backup session keys or wrapping keys may use Android Keystore when that improves safety for in-app temporary handling.
- The **user backup password itself is not permanently stored**. If a short-lived in-memory/session handle is required during create/restore, it must not be written to disk in plaintext and must be discarded when the flow ends.
- Never log passwords, KDF outputs, or raw encryption keys.

Restore flow:
1. Select backup file.
2. Enter backup password (no recovery hint that reveals the password).
3. Decrypt + verify integrity.
4. Show preview metadata (org name if available in authenticated associated data or decryptable header fields designed for preview, created_at, format version).
5. Confirm destructive restore.
6. Apply restore atomically (see §17.4).

### 17.2 Create encrypted backup

- Owner (authorized role) can create a full encrypted backup of local GymPulse data.
- Payload includes data required to restore operations (orgs, locations, members, memberships, attendance, trials, follow-ups, cancellations, settings, templates, aggregates as applicable).
- App PIN **hash** may be included inside the encrypted payload so restore returns to a known unlock state; never store plaintext PIN in the backup.
- On success: update last successful backup timestamp; offer Share/Save.
- On failure: clear error state; do not write a “successful” plaintext or incomplete sensitive file; delete/abort partial output files when possible.

### 17.3 Export / share backup file

- After creation, allow Save/Share via Android system share sheet / file picker.
- GymPulse does not require any paid cloud to store backups.
- Remind the owner they are responsible for storing the encrypted file safely and remembering the backup password.
- Sharing an encrypted backup does not exempt the encryption requirement.

### 17.4 Restore — atomicity & corruption protection

Restore must be designed so a failed or interrupted restore **does not corrupt** the existing working database.

Required approach (conceptually):
1. Validate file header/version.
2. Decrypt and verify integrity **before** replacing live data.
3. Write restored content to a temporary database/file.
4. Verify temporary DB opens and passes basic integrity checks.
5. Atomically swap/replace the live DB (or equivalent transactional handoff supported on Android).
6. Only then mark restore successful and update restore timestamp.
7. If any step fails or the process is interrupted: keep the previous live DB; clean up temp files; show error.

Partial restore of business data into the live DB is **forbidden**.

### 17.5 Business CSV export / import

Authorized CSV export/import remains available for interoperability (members, memberships, attendance, follow-ups, trials, cancellations as supported).

CSV is **not** a substitute for encrypted full backup. UI must not label CSV export as “encrypted backup.”

Mock attendance source remains available for development/testing (explicitly labeled; not production default).

### 17.6 Backup status UI

Settings → Backup & Restore must show:
- Last successful backup date/time (or “Never”)
- Last restore time (if any)
- Current reminder interval setting
- Stale-backup warning when last backup is older than the configured interval (or never backed up)
- Primary actions: **Backup Now**, Share last backup (if path known), Restore, Export CSV, Import CSV
- Inline error state if the latest backup attempt failed (code + user message + Retry / Backup Now)

### 17.7 Backup Reminder feature

MVP must include Backup Reminder:

- Display last backup date/time on Backup screen and surface a dashboard/settings warning when stale.
- Configurable reminder interval (examples: 7 / 14 / 30 days; default documented in implementation, owner-changeable).
- When stale (or never backed up after first data exists): show warning + local notification per preferences.
- Warning CTA: **Backup Now** (opens create-backup flow).
- If backup creation fails from that CTA, show a clear error state with retry — never silent failure.
- Reminder state is local-only (no cloud scheduler).

### 17.8 Error requirements (backup/restore)

Must handle and surface at least:
- corrupted backup file
- invalid backup password
- incompatible backup version
- interrupted backup creation
- insufficient storage
- interrupted restore
- permission denied read/write
- integrity/authentication tag failure
- cancelled by user

Rules:
- Never report success on failure.
- Never leave plaintext sensitive payload files behind after a failed encrypted backup attempt.
- Never apply partial restore to the live DB.
- Failed restore must preserve the existing database.
- Successful restore must be transactional/atomic where technically possible (temp + verify + swap).

### 17.9 Future cloud sync

Any future cloud synchronization must remain behind `SyncPort` / repository abstractions and must **never** become a required dependency without explicit owner approval. Local encrypted backup remains the MVP durability path.
