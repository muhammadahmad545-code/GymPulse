# GymPulse — Technology Notes

These notes reflect the current technology/policy checks used while preparing the specification.

## Locked stack (local-first)

- **Flutter** for Android-first mobile (iOS-capable later)
- **Dart** with feature-first architecture, repositories/services, MVVM-style organization
- **Riverpod** for state management
- **Drift + SQLite** for on-device persistence (no mandatory hosted DB)
- **User-created PIN/passcode** for local app protection (salted hash; lockout; backup/factory recovery)
- **Encrypted local Backup & Restore** (no plaintext sensitive full-backup files; KDF + authenticated encryption; Backup Reminder; atomic restore) + CSV export/import (separate from encrypted backup)
- **Local notifications** (no mandatory FCM)
- **External WhatsApp/share/dialer intents** (no paid WhatsApp Business API)
- **GitHub** for source + APK Releases only (not app runtime backend)
- Optional later: **.NET 10 LTS** Windows export connector (file/LAN; no paid cloud relay)

## Explicitly rejected as mandatory dependencies

- Supabase Cloud / hosted Postgres as required backend
- Firebase Auth / mandatory FCM for core features
- Paid WhatsApp Business API
- Any mandatory paid hosting, database, or cloud service for MVP/core use

## Policy snapshots

- Flutter stable line in use during planning included 3.44.x-class releases; re-check before each release.
- Google Play states that beginning August 31, 2026, new Android apps and updates must target Android 16/API 36 or higher.
- Biometric vendors expose different SDKs/exports; GymPulse uses adapters and never invents vendor APIs.
- .NET 10 remains an LTS option for optional Windows connector tooling.

## Cost rule

Before adding any dependency that needs accounts, hosting, or paid quotas, document:
1. why it is needed
2. whether a free local alternative exists
3. whether it can be optional
4. owner approval if it introduces recurring cost

Before production release, re-check vendor, Apple, Google Play, privacy, messaging and SDK requirements because external policies and versions can change.
