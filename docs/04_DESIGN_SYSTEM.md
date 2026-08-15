# GymPulse — Design System

## Brand direction

Working name: GymPulse

Concept:
- Pulse = gym activity + business pulse
- Strong, energetic, professional

## Color strategy

Use a dark premium base with a restrained high-energy accent.

Suggested semantic palette:
- Background: deep charcoal/near-black
- Surface: dark graphite
- Primary accent: electric lime/green
- Secondary accent: cool cyan or blue
- Success: green
- Warning: amber
- Danger: red
- Text primary: near-white
- Text secondary: muted gray

Important:
- Do not use red/green alone to communicate status.
- Pair color with icon, label and text.

## Typography

Use a modern sans-serif system font stack.
Prefer:
- Inter or platform-native equivalent
- Strong numeric typography for dashboards
- Tabular numerals for analytics

## Shape

- Medium rounded cards
- Strong but not excessive corner radius
- Consistent spacing scale
- Clear hierarchy

## Components

Create reusable:
- AppBar
- BottomNavigation
- MetricCard
- HealthScoreCard
- RiskBadge
- StatusBadge
- MemberCard
- ActionCard
- ChartCard
- FilterBar
- DateRangePicker
- LocationSelector
- EmptyState
- ErrorState
- Skeleton
- BottomSheet
- ConfirmationDialog
- Snackbar/Toast
- DataTable for larger screens

## Charts

Prefer:
- Line chart for trends
- Bar chart for daily/hourly attendance
- Donut only for simple composition
- Heatmap for weekly/hourly gym traffic

Avoid decorative 3D charts.

## Icons

Use one coherent icon family.
Icons must have labels/tooltips where meaning is not obvious.

## Motion

Use subtle motion:
- card entrance
- score transition
- state change
- navigation

Avoid excessive animation.

## Dark/light mode

Dark mode is the primary gym-themed experience.

Support light mode for accessibility and user preference.

## Branding

Gym owners should be able to add:
- gym name
- logo
- accent color within safe limits

The core UX remains GymPulse-branded to preserve consistency.

## Design QA

Every screen must be checked at:
- small Android phone
- large Android phone
- iPhone
- tablet
- desktop/web if implemented

Check:
- overflow
- localization
- font scaling
- dark/light
- empty/loading/error states
