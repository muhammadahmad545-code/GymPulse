# GymPulse — Database / Data Model (Local SQLite via Drift)

## Persistence platform

- Engine: **SQLite on device**
- ORM / access layer: **Drift**
- Migrations: Drift schema versioning
- Authoritative timestamps: UTC
- Presentation/analytics timezone: location timezone

There is **no mandatory hosted Postgres/Supabase database**.

An optional future cloud sync adapter may map these tables to a remote store, but local SQLite remains the MVP system of record.

## Core tables

### organizations
- id UUID PK
- name
- country_code
- default_currency
- created_at
- updated_at

### locations
- id UUID PK
- organization_id FK
- name
- timezone
- country_code
- currency_code
- address fields
- capacity
- created_at
- updated_at

### users (local profiles)
- id UUID PK
- display_name
- role_default nullable
- pin_hash nullable
- created_at
- updated_at

Note: `auth_user_id` from cloud auth providers is **not** required for MVP. A nullable `external_auth_id` may be reserved for future optional sync.

### organization_members
- organization_id
- user_id
- role
- status
- created_at

### location_access (optional grants)
- organization_id
- location_id
- user_id
- created_at

### members
- id UUID PK
- organization_id
- location_id
- external_member_id
- first_name
- last_name
- phone
- email
- status
- created_at
- updated_at

Unique constraint:
- organization_id + external_member_id where external ID exists

### memberships
- id UUID PK
- organization_id
- location_id
- member_id
- plan_id
- start_at
- end_at
- status
- price_amount
- currency_code
- created_at
- updated_at

### membership_plans
- id
- organization_id
- location_id nullable
- name
- duration_days
- price_amount
- currency_code
- active

### attendance_sources
- id
- organization_id
- location_id
- type
- vendor
- external_source_id
- status
- last_success_at
- last_attempt_at
- metadata_json

### attendance_events
- id UUID
- organization_id
- location_id
- member_id nullable
- external_member_id
- source_id
- occurred_at_utc
- occurred_at_local
- event_type
- external_event_id
- raw_payload_json
- ingested_at

Unique:
- source_id + external_event_id where available

### trials
- id
- organization_id
- location_id
- member_id
- started_at
- ends_at
- converted_at nullable
- status
- source

### follow_ups
- id
- organization_id
- location_id
- member_id
- type
- priority
- reason
- status
- due_at
- assigned_to
- contact_channel
- message_template_id nullable
- resolution_note
- created_at
- updated_at

### message_templates
- id
- organization_id
- location_id nullable
- key
- body
- channel
- active
- created_at
- updated_at

### cancellation_events
- id
- organization_id
- location_id
- member_id
- occurred_at
- reason_code
- reason_text nullable
- source
- created_at

### risk_scores
- id
- organization_id
- location_id
- member_id
- score
- risk_level
- confidence
- calculated_at
- factors_json

### daily_member_metrics
- organization_id
- location_id
- member_id
- date
- visits
- days_since_last_visit
- rolling_7d_visits
- rolling_30d_visits
- attendance_change
- membership_days_remaining

### gym_daily_metrics
- organization_id
- location_id
- date
- active_members
- visits
- unique_visitors
- trials
- trial_conversions
- renewals
- cancellations

### integration_sync_runs
- id
- organization_id
- location_id
- source_id
- started_at
- completed_at
- status
- records_read
- records_created
- records_updated
- records_skipped
- error_count
- error_summary

### notification_preferences
- organization_id
- user_id
- key
- enabled
- updated_at

### audit_logs
- id
- organization_id
- user_id
- action
- entity_type
- entity_id
- occurred_at
- metadata_json

### app_meta
- key
- value
- updated_at

Used for schema/app metadata such as last aggregate run, data freshness markers, and local settings not covered elsewhere.

### security_state
- id (singleton row or key)
- pin_hash
- pin_salt
- pin_algo
- failed_attempts
- lockout_until_utc nullable
- biometric_unlock_enabled
- auto_lock_seconds
- updated_at

Never store plaintext PIN.

### backup_runs
- id
- organization_id nullable
- created_at
- completed_at nullable
- direction (export|restore)
- status (success|failed|interrupted|cancelled)
- file_name nullable
- format_version nullable
- checksum nullable
- app_version
- error_code nullable
- error_summary nullable
- created_by_user_id nullable

Never store backup passwords or encryption keys in this table.

### backup_reminder_settings
- organization_id
- interval_days
- enabled
- last_reminded_at nullable
- updated_at

## Rules

1. Use UUIDs for public identifiers.
2. Store timestamps in UTC.
3. Convert to location timezone at presentation/analytics boundaries.
4. Never rely on device local time as authoritative for event occurrence times from imports (parse source timestamps carefully).
5. Use decimal/numeric affinity for monetary amounts.
6. Use ISO country/currency codes.
7. Soft-delete where audit/history requires retention.
8. Index tenant + location + date fields.
9. Enforce organization isolation in repository/service queries.
10. Do not store fingerprint templates, fingerprint images, or biometric credentials.
11. Support encrypted backup export/restore without a cloud database; track last backup/restore via `backup_runs`.
12. Keep schema sync-friendly (stable IDs, updated_at) for a future optional sync adapter — without requiring one.
