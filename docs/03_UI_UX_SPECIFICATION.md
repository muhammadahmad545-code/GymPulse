# GymPulse — UI/UX Specification

## 1. UX goal

The UI should feel like:

> A premium fitness command center.

It should NOT feel like:
- an old-school accounting system
- a spreadsheet
- a generic CRM
- a cluttered admin panel

The product is local-first. Core screens must work fully from on-device data. Network is only for optional concerns such as GitHub APK update checks.

## 2. Design personality

- Strong
- Premium
- Athletic
- Modern
- Trustworthy
- Data-driven
- Calm under pressure

Use gym visual language without making the product childish.

## 3. Primary navigation

Mobile:
- Home
- Members
- Actions
- Analytics
- Settings

Settings must include:
- Backup & Restore (last backup time, stale warning, reminder interval, Backup Now, share, restore, CSV export/import, last error)
- Security (PIN change, lock timeout, optional OS biometric convenience)
- Organization / locations / gym configuration
- Integrations / attendance import health
- Appearance / language

Backup create UI must:
- require password + confirmation
- show that a forgotten backup password cannot be recovered
- never present a successful state for a failed/interrupted backup
- never describe CSV export as an encrypted backup

Before Home is reachable, the app must pass Unlock (or first-launch PIN setup).

Desktop/web later:
- Dashboard
- Members
- Memberships
- Attendance
- Actions
- Trials
- Retention
- Analytics
- Locations
- Integrations
- Settings

## 4. Dashboard layout

Top:
Gym/location selector

Hero:
Health score

Then:
- urgent actions
- expiring memberships
- inactive members
- trials
- attendance summary
- peak time
- retention trend

Use progressive disclosure.

## 5. Member detail

Header:
Name + status

Summary:
- Membership
- Expiry
- Last visit
- Visits this month
- Typical visits/week
- Risk

Sections:
- Attendance timeline
- Membership timeline
- Follow-ups
- Notes
- Cancellation/trial history

Primary CTA:
Contact member

## 6. Actions screen

This must be optimized for fast decisions.

Cards should say:
- What happened
- Why it matters
- What action is recommended

Example:
> Ahmed has not visited for 18 days. His normal frequency is 4 visits/week.

CTA:
> Contact Ahmed

## 7. Empty states

Never show blank charts.

Examples:
> No attendance data yet.
> Connect an attendance source to unlock analytics.

Or:
> Not enough history.
> GymPulse needs 30 days of data for reliable trends.

## 8. Error states

Errors must be actionable.

Bad:
> Error 500

Good:
> Attendance sync is unavailable. Last successful sync: 12 minutes ago.

CTA:
> Retry

Attendance/analytics widgets must distinguish:
- live/fresh data
- stale data (show last successful import time)
- unavailable source/import

Never show “0 visits today” solely because the attendance source/import is unavailable or stale. Use an unavailable/stale state instead.

## 9. Loading

Use skeleton loading for dashboards and lists.

Do not block the entire app for one slow widget.

## 10. Accessibility

Must support:
- dynamic text sizing
- adequate contrast
- screen readers
- keyboard navigation on desktop
- touch targets
- reduced motion
- non-color-only status indicators

## 11. Localization

Do not concatenate translated strings.

Use translation keys.

Support:
- RTL
- locale-aware dates
- locale-aware numbers
- currency formatting
- timezone-aware timestamps

## 12. UX rule

Every screen must have one obvious primary action.

## 13. Interaction principle

The app should progressively answer:

1. What happened?
2. Why does it matter?
3. Who is affected?
4. What should I do?
5. What happened after I acted?
