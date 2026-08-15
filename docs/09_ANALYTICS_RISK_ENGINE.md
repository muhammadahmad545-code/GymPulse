# GymPulse — Analytics & Risk Engine Specification

## 1. Principle

Analytics must be:
- explainable
- confidence-aware
- tenant-specific
- timezone-aware
- robust to missing data
- computed **on-device** from local SQLite data for MVP
- free of mandatory cloud/AI services

Do not use opaque AI scoring when deterministic analytics are sufficient.

## 2. Inactivity engine

Inputs:
- last visit
- historical visit frequency
- membership status
- membership expiry
- gym closure dates
- trial status
- attendance data freshness

Output:
- days since visit
- inactivity level
- recommended action

## 3. Attendance decline

Compare recent attendance to personal baseline.

Example:
Baseline: 4.0 visits/week
Recent: 1.0 visits/week

Decline:
75%

This is stronger evidence than a universal "14 days" rule.

## 4. Member risk score

Start with an explainable weighted model.

Example conceptual weights:
- attendance decline: 30%
- days since last visit: 25%
- membership expiry proximity: 20%
- historical engagement: 15%
- previous inactivity/renewal behavior: 10%

Weights must be configurable and validated.

Do not call it an AI prediction unless the system has been trained/validated as such.

Levels:
- 0–29: Low
- 30–59: Moderate
- 60–79: High
- 80–100: Critical

Always show factors.

## 5. Confidence

Confidence depends on data quality:
- amount of attendance history
- integration freshness
- member history
- membership completeness

If confidence is low:
> Low confidence — more data needed.

## 6. Gym Health Score

Suggested components:
- retention
- attendance
- renewal
- trial conversion
- engagement
- data quality

Score should be normalized.

Example:
`overall = weighted_average(component_scores)`

Do not display a score with fake precision.

Use:
> 82
rather than
> 82.3741

## 7. Peak-hour engine

Group check-ins by local:
- day of week
- hour
- configurable interval

Calculate:
- average
- percentile
- max
- rolling average

Crowding requires:
- configured capacity OR
- configured attendance threshold

Otherwise label:
> High attendance

rather than:
> Crowded

## 8. Trial conversion

Formula:
`converted eligible trials / eligible trials`

Define:
- conversion window
- eligible trial status
- duplicate trial behavior

## 9. Cancellation analytics

Calculate:
- count by reason
- percentage by reason
- month-over-month trend
- location comparison

Suppress or aggregate extremely small groups where privacy rules require it.

## 10. Data quality score

Track:
- attendance freshness
- unmatched events
- missing membership dates
- duplicate events
- failed syncs

A gym health score should be reduced/flagged if data quality is poor.

## 11. Future ML

Only after sufficient anonymized/consented data exists consider:
- churn prediction
- renewal probability
- optimal follow-up timing

ML must be evaluated against deterministic baselines and monitored for drift.

## 12. No harmful automation

Do not automatically:
- deny membership
- change prices
- accuse members
- label members as bad/fraudulent
- make consequential decisions without human review
