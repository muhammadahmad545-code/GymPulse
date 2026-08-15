# GymPulse — AI Agent Documentation Package

## Purpose

This package is the source of truth for building GymPulse, a globally deployable gym-owner intelligence and retention platform.

GymPulse is **not** intended to replace biometric attendance hardware. It connects to existing gym attendance systems and turns attendance + membership + trial + cancellation data into actionable retention and business insights.

## Product promise

> Know which members you are about to lose — before you lose them.

## Critical cost constraint (non-negotiable)

GymPulse MVP and ongoing product use must work with **zero mandatory paid backend, hosting, database, cloud service, subscription, or recurring infrastructure cost**.

- The application is **local-first**.
- Primary architecture: **Flutter + Riverpod + Drift/SQLite** as the local system of record.
- Mandatory **user-created PIN/passcode** protection and **Local Backup & Restore** in MVP.
- No mandatory Supabase, Firebase, hosted Postgres, or other paid cloud dependency.
- Optional cloud synchronization may be designed later behind `SyncPort`/repository abstractions, but must never be required for core features without explicit owner approval.
- **GitHub is source-code and APK distribution only.** GitHub must **not** become a runtime backend.

## Phase workflow (non-negotiable)

```text
implement phase
→ tests
→ error-handling verification
→ security checks
→ build APK
→ commit
→ push
→ GitHub Release (APK + notes)
→ owner manual install/test
→ wait for explicit owner approval
→ next phase
```

Do not start Phase 0 or any later phase until the owner explicitly approves the current documentation/architecture state for that step.

## Documents

1. `01_PRODUCT_REQUIREMENTS.md` — product vision, scope, personas, requirements
2. `02_FEATURE_SPECIFICATION.md` — detailed functional specifications
3. `03_UI_UX_SPECIFICATION.md` — UX principles, screens, flows, states
4. `04_DESIGN_SYSTEM.md` — gym-themed visual system and components
5. `05_TECHNICAL_ARCHITECTURE.md` — architecture and technology decisions
6. `06_DATABASE_DATA_MODEL.md` — local multi-tenant SQLite/Drift model
7. `07_API_SPECIFICATION.md` — application service contracts (local; future sync-ready)
8. `08_ATTENDANCE_INTEGRATION.md` — biometric/device integration strategy
9. `09_ANALYTICS_RISK_ENGINE.md` — health score, inactivity, risk and analytics
10. `10_SECURITY_PRIVACY_COMPLIANCE.md` — security, privacy, internationalization and compliance
11. `11_TESTING_QA.md` — testing strategy and acceptance criteria
12. `12_DEVOPS_RELEASE.md` — environments, CI/CD, observability and release
13. `13_ROADMAP.md` — MVP through global scale
14. `14_AI_AGENT_MASTER_PROMPT.md` — master instruction to give to the coding AI agent
15. `15_REQUIREMENTS_TRACEABILITY.md` — requirements coverage matrix
16. `16_TECHNOLOGY_NOTES.md` — technology/policy notes
17. `17_ERROR_HANDLING_SPECIFICATION.md` — error handling and resilience

## Source-of-truth rule

If documents conflict, use this priority:

1. Product requirements
2. Feature specification
3. Technical architecture
4. API/data model
5. UI/UX and design system
6. Other implementation documents

The AI agent must not silently change product requirements. It must surface conflicts before making architectural changes.

## Critical product constraint — biometric hardware

Attendance hardware is heterogeneous. GymPulse must use an **adapter/integration layer** rather than assuming one biometric vendor, one database schema, or one protocol.

Supported integration modes should be designed as independent adapters:

- CSV/Excel import (MVP primary path)
- Manual import fallback
- REST/API (optional; when a free/local source exists)
- Webhook (optional future; not required for MVP)
- Vendor SDK (only with official docs; never invented)
- Local database reader (via optional free Windows connector export path)
- Windows/local connector that produces importable files or optional LAN transfer — **no paid cloud relay**

Never require a gym to replace its existing fingerprint device just to use GymPulse.

## Development / testing workflow

The project is developed in **Cursor or VS Code**, not Android Studio.

The remote GitHub repository is the central source of truth for source code and APK artifacts. The AI agent must:
- create/configure the GitHub remote repository
- implement one phase at a time
- run tests/build checks
- commit with a meaningful message
- push after every completed phase/update
- publish the generated Android APK as a GitHub Release asset (or an equivalent downloadable GitHub artifact)
- keep the APK version/build number synchronized with the source revision

The owner will initially download and install the APK manually on a physical Android phone. After that, every subsequent release should support an **in-app update notification**. Tapping the notification should take the user through a safe update flow. Android does not permit a normal app to silently replace itself; the implementation must use a supported package-install/update mechanism and obtain the required user confirmation/permission when the device requires it.

Do not hard-code personal GitHub usernames or repository URLs in application source. Use configuration/environment variables.

## Error-handling requirement

Error handling is a first-class product and engineering requirement. It is specified in:
- `17_ERROR_HANDLING_SPECIFICATION.md`
- `11_TESTING_QA.md`
- `12_DEVOPS_RELEASE.md`
- `14_AI_AGENT_MASTER_PROMPT.md`

Every feature must define expected failures, user-facing messages, recovery actions, logging, retry behavior, and telemetry. Errors must never be silently swallowed or exposed as raw stack traces.
