> **SUPERSEDED.** The current product is **Mr. Gym**. See [00_README.md](00_README.md) and [19_MR_GYM_FINAL.md](19_MR_GYM_FINAL.md). Multi-gym SaaS, cloud, AI, and biometric attendance are not part of the product.

# GymPulse — Product Requirements Document (PRD)

## 1. Product overview

GymPulse is a globally deployable B2B mobile-first platform for gym owners and managers.

It is **local-first**: the MVP runs entirely on the owner's device with **zero mandatory paid backend, hosting, database, or cloud service**.

It ingests gym operational data, especially existing biometric attendance events (via import/adapters), and transforms that data into:

- Membership expiry intelligence
- Member inactivity detection
- Retention-risk detection
- Follow-up queues
- Gym health scoring
- Attendance/peak-hour analytics
- Trial conversion analytics
- Cancellation-reason intelligence

## 2. Problem

Gym owners often have the data but not the intelligence.

A biometric machine may know that a member entered the gym, while the gym owner still has to manually discover:

- who has stopped attending
- whose membership expires soon
- which trial users did not convert
- which hours are overcrowded
- why members are leaving
- which members need attention today

GymPulse closes that gap **without requiring paid cloud infrastructure**.

## 3. Target users

### Primary
- Independent gym owners
- Gym managers
- Fitness-center managers
- Multi-location gym operators (on one or more devices)

### Secondary
- Front-desk staff (local profiles on a shared device where appropriate)
- Membership/reception staff
- Regional managers

## 4. Global requirements

The product must support:

- Multiple countries
- Multiple currencies
- Multiple time zones
- Multiple date/number formats
- Multiple languages (English first; localization architecture from day one)
- Different membership models
- Different attendance systems
- Multiple locations under one organization
- Role-based access (local profiles)
- Local privacy requirements
- Fully offline operation for core features
- Data export and portability

Do not hardcode Pakistan-specific assumptions.

## 5. Cost & deployment constraints

1. **Zero mandatory recurring cloud cost** for MVP and core ongoing use — no mandatory paid backend, hosting, subscription, or recurring infrastructure.
2. No mandatory Supabase, Firebase, hosted database, or paid messaging API.
3. Primary architecture: **Flutter + Riverpod + Drift/SQLite** (local system of record).
4. Mandatory local PIN/passcode protection + Local Backup & Restore in MVP.
5. Optional future cloud sync must stay behind `SyncPort`/repository abstractions and never become required without explicit approval.
6. GitHub may be used for free source hosting and APK distribution/testing only — **not** an application runtime backend.
7. WhatsApp contact flows use external WhatsApp/share intents only (no paid Business API).

## 5.1 MVP feature coverage (must remain supported local-first)

- Membership expiry detection
- Inactive member detection
- Follow-up queue
- WhatsApp/external messaging intents
- Gym health score
- Attendance analytics
- Peak hours
- Trial conversion tracking
- Cancellation reasons
- CSV attendance import
- Biometric adapter architecture
- Mock attendance source for development/testing
- Local encrypted backup/restore + Backup Reminder + CSV business export/import (CSV ≠ encrypted backup)
- Stale/unavailable attendance UI (never treat missing source as zero)

## 6. Product principles

1. Action over information.
2. The owner should know what to do today within 10 seconds.
3. Do not replace existing biometric hardware.
4. Never lock the system to one biometric vendor.
5. Every important metric must be explainable.
6. Do not fabricate insights from insufficient data.
7. Privacy by design (data stays on device by default).
8. Tenant/organization isolation is mandatory even on a single device.
9. Offline-first is the default, not an enhancement.
10. Accessibility and localization are first-class requirements.
11. Prefer the simplest production-quality architecture that satisfies requirements.

## 7. Core modules

### A. Dashboard / Gym Health
Shows:
- Health score
- Active members
- At-risk members
- Inactive members
- Expiring memberships
- Trials requiring follow-up
- Renewal/retention trends
- Attendance trend
- Peak hours
- Important alerts

### B. Member Retention
Detect:
- Inactivity
- Attendance decline
- Membership expiry
- Unusual attendance changes
- Potential churn risk

### C. Follow-Up Center
A prioritized queue:
- Membership expiry
- Inactivity
- Trial expiry
- Risk escalation
- Manual follow-up

Actions:
- Call
- Open WhatsApp if available (external intent)
- Copy message
- Mark contacted
- Snooze
- Resolve

### D. Attendance Intelligence
Consumes attendance events from existing systems via adapters (CSV primary for MVP).

Reports:
- Daily attendance
- Weekly/monthly attendance
- Unique visitors
- Visit frequency
- Peak hours
- Peak days
- Average visits/member
- Attendance trends

### E. Membership Intelligence
Tracks:
- Active
- Expiring
- Expired
- Renewed
- Cancelled
- Renewal rate
- Revenue-related metrics when financial data exists

### F. Trial Conversion
Tracks:
- Trial starts
- Trial duration
- Trial expiry
- Conversion
- Conversion rate
- Conversion by trial duration/source/location

### G. Cancellation Intelligence
Tracks:
- Cancellation events
- Cancellation reasons
- Reason distribution
- Trends
- Location comparisons

### H. Organization / Locations
Supports:
- One owner → many locations
- Location-level data
- Organization-level analytics
- Location permissions (local roles)

## 8. Non-goals for MVP

Do not build:
- Biometric hardware itself
- Full POS
- Payroll
- Inventory management
- Workout plans
- Diet plans
- Member fitness tracking
- Trainer marketplace
- Social network
- Medical advice
- Automated financial accounting
- Mandatory cloud backend / multi-device realtime sync
- Paid WhatsApp Business API messaging
- Paid push-notification cloud dependency

## 9. Success metrics

Product:
- Daily active gym accounts (device)
- Weekly active gym accounts
- 30-day retention of the app habit
- Number of members monitored
- Follow-up completion rate
- At-risk members contacted
- Renewal rate improvement
- Trial conversion improvement
- Attendance-data import/sync success

Technical:
- Crash-free sessions
- Local DB integrity
- Import latency/reliability
- Integration success rate
- Data processing failure rate
- Zero mandatory cloud cost for core operation

## 10. Key product philosophy

The primary dashboard should answer:

> "What needs my attention today?"

Not:

> "Here are 40 charts."
