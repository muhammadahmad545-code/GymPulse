# GymPulse — Security, Privacy & Compliance Specification

## 1. Security baseline (local-first)

- Local SQLite (Drift) as system of record for MVP
- **Mandatory user-created app PIN/passcode** (salted one-way hash; never plaintext)
- Progressive unlock rate limiting / lockout
- Encrypt backup files at rest (passphrase-based)
- Use platform secure storage for unlock material / keys where appropriate
- Least privilege for local roles
- Input validation on all imports and forms
- Output encoding in UI
- Dependency scanning in CI
- In-app backup status + reminders (owner-managed file copies)
- No mandatory cloud attack surface for core features
- GitHub used only for source/APK distribution — never as a runtime backend

When optional network features are used (GitHub update checks, future sync, optional remote adapters):
- TLS everywhere
- certificate validation
- bounded retries
- no secrets in source control

## 1.1 PIN protection requirements

- First-launch PIN create + confirm before business data access
- Unlock required after cold start, manual lock, and idle/background timeout
- Progressive cool-downs after consecutive failures
- PIN change requires current PIN
- Recovery: encrypted backup restore (preferred) or destructive factory reset
- No cloud forgot-password flow in MVP
- Optional OS biometric convenience unlock must not store gym biometric templates and must not remove the PIN requirement

## 1.2 Backup security

- Full GymPulse backup files must **never** contain plain-text sensitive business data; payload must be encrypted with authenticated encryption.
- Backup password is distinct from app PIN; confirmed by re-entry at creation.
- Clear warning: forgotten backup password cannot be recovered by GymPulse.
- Derive keys via KDF; never store backup passwords or encryption keys in plaintext (disk, logs, Git, analytics).
- Use Android Keystore / platform secure storage where applicable for PIN material and any ephemeral key-handling aids; do not permanently store the user backup password.
- Integrity verification before restore; atomic temp→verify→swap restore; failed/interrupted restore must not corrupt the live DB.
- Never upload backups to GitHub Releases or any cloud by default.
- CSV exports are separate plain-text interoperability artifacts and must not be presented as encrypted backups.

## 2. Multi-tenant / multi-organization security

Every operation must resolve:
- active local profile
- organization
- allowed locations
- role

Never trust UI-supplied organization/location identifiers.

Enforce isolation in repository/service queries even when all data is on one device.

## 3. Biometric privacy

GymPulse must **not** store fingerprint templates, fingerprint images, or biometric credentials for gym members.

Preferred model:
> biometric device verifies identity locally → GymPulse receives attendance event + member identifier (via CSV/adapter).

Phone OS biometric unlock (fingerprint/face) may be offered only as **optional convenience to unlock the app after a PIN exists**. It uses OS secure APIs and must not store gym member fingerprint templates/images/credentials.

If gym biometric data ever becomes part of the product, treat it as highly sensitive and require a dedicated legal/security review for each target jurisdiction, plus explicit owner approval.

## 4. Personal data minimization

Collect only what is needed.

Phone/email should be optional unless required for a configured communication workflow.

Data remains on device by default.

## 5. Communications

WhatsApp/SMS contact uses:
- external app intents / share sheets
- editable templates
- owner-initiated sending

Respect consent and applicable messaging laws. Do not use a paid WhatsApp Business API for MVP.

Never mark a message as successfully delivered solely because an external app was opened.

## 6. Data deletion

Provide:
- member deletion workflow
- organization deletion workflow
- retention policy guidance
- export before deletion where appropriate

Deletion must account for:
- primary local data
- derived analytics
- audit/legal retention settings
- backup copies the owner may hold outside the app

## 7. Data residency

Local-first inherently keeps data on the owner's device/region by default.

Any future optional cloud sync must support regional choices and remain optional.

## 8. Privacy UX

Provide:
- privacy explanation (local storage model)
- communication preferences
- export/delete request path
- clear backup ownership messaging

## 9. Compliance targets

Depending on deployment:
- GDPR
- UK GDPR
- CCPA/CPRA
- local privacy laws
- applicable messaging rules

Do not claim legal compliance automatically. The product must support compliance requirements, with legal review before launch in each jurisdiction.

## 10. AI privacy

If external AI services are ever used:
- minimize data sent
- avoid sending raw member data when unnecessary
- use pseudonymous IDs
- document processors
- configure retention controls
- provide opt-out
- never make paid AI a mandatory dependency

MVP analytics are deterministic and on-device.

## 11. Security incident handling

Define:
- detection (local integrity failures, unexpected unlock attempts)
- containment
- investigation
- owner notification guidance
- recovery via backup
- postmortem notes

## 12. Threat model

Threats:
- device theft / unauthorized unlock
- local profile privilege abuse
- malicious CSV imports
- unauthorized exports
- APK update supply-chain abuse
- future sync credential theft (if sync is added)
- message abuse via templates

Mitigations:
- app PIN / device lock
- role checks
- import validation + audit
- export authorization
- HTTPS + package/version/SHA-256 verification for GitHub APK updates
- no silent installs
- no fingerprint template storage

## 13. Cost-related security rule

Do not introduce a mandatory paid security SaaS. Prefer platform OS features, local encryption, and free CI checks.
