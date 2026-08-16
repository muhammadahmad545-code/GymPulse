> **SUPERSEDED.** Attendance is marked in-app. Biometric hardware and attendance import are not part of Mr. Gym. See [19_MR_GYM_FINAL.md](19_MR_GYM_FINAL.md).

# GymPulse — Biometric Attendance Integration Specification

## 1. Critical principle

GymPulse does NOT replace existing fingerprint/biometric attendance machines.

The machine remains the source of physical attendance capture.

GymPulse consumes attendance records.

## 2. Cost constraint

Attendance integration must not require a paid cloud relay, hosted ingestion API, or mandatory SaaS connector.

MVP primary path: **CSV/Excel import on the phone**.

## 3. Why an adapter architecture is mandatory

Different gyms use different:
- hardware vendors
- models
- firmware
- network configurations
- desktop software
- databases
- APIs
- SDKs

Therefore no single integration path may be assumed.

## 4. Supported integration modes

### Mode A — CSV/Excel import (MVP primary)
Owner exports attendance from existing gym software/device software and imports into GymPulse.

### Mode B — Manual import fallback
Guided manual entry/correction for unmatched or missing rows when needed.

### Mode C — REST/API adapter (optional)
Only when a gym system exposes a free/local API the owner can reach without a paid GymPulse cloud.

### Mode D — Vendor SDK adapter
Use vendor-supported SDK where legally and technically appropriate, and only with official documentation. Never invent vendor APIs.

### Mode E — Local database adapter via Windows connector export
A free local Windows connector may read a supported local DB/export and write normalized CSV/JSON for phone import (USB/share folder) or optional LAN transfer.

Requirements:
- read-only against vendor DB where possible
- no direct writes to attendance hardware
- transaction-safe incremental reads
- checkpointing
- duplicate detection
- **no paid cloud upload required**

### Mode F — Webhook (future optional)
Not required for MVP. If added later, must not depend on paid GymPulse hosting unless explicitly approved as optional paid product.

## 5. Normalized attendance event

```json
{
  "externalEventId": "device-123-456",
  "externalMemberId": "M-10023",
  "sourceId": "source-uuid",
  "occurredAt": "2026-08-15T14:32:00+05:00",
  "eventType": "check_in"
}
```

App converts to canonical UTC in local SQLite.

## 6. Member matching

Priority:
1. Stable external member ID
2. Explicit mapping
3. Verified phone/email mapping where appropriate
4. Manual review queue

Never match members only by name when ambiguity exists.

## 7. Missing-member events

If an attendance event references an unknown member:
- store raw event
- mark unmatched
- do not discard
- show integration issue
- allow mapping

## 8. Duplicate handling

Use source + external event ID when available.

If no event ID:
- source
- external member ID
- timestamp
- event type
- bounded deduplication window

## 9. Sync / import health

Show:
- Connected / Ready
- Delayed / Stale
- Error
- Disabled

And:
- last successful import
- last attempt
- backlog size (connector)
- error count

## 10. Security

Connector / import:
- least privilege
- no fingerprint templates stored
- validate files before import
- preserve audit of imports
- Windows connector: outbound-only if any network used; prefer offline file export

## 11. Vendor integration policy

Do not reverse-engineer proprietary protocols if prohibited by license/terms.

Prefer official:
- export
- API
- SDK
- documented database access

Do not invent vendor credentials, schemas, or protocols.

## 12. Testing

Every adapter must have:
- fixture input
- normalization tests
- duplicate tests
- clock/timezone tests
- malformed data tests
- retry tests (where applicable)
- offline queue tests (connector)
- reconciliation tests

## 13. Reconciliation

Provide a tool:

> Compare source attendance count vs GymPulse count for date range.

The owner/integration admin must be able to detect missing events after import.
