# Phase 2 test data

Use these files on the phone with **GymPulse v0.2.0**. Dates are built for **16 Aug 2026**. If you test much later, ask for a refreshed set.

## Files

- `phase2_members.csv` — 8 members
- `phase2_attendance.csv` — 172 check-ins, plus 2 unmatched ghost rows

## Import order

1. Unlock GymPulse. Finish org setup if this is a fresh install.
2. **Members first:** Settings → Backup & restore → **Import members CSV** → pick `phase2_members.csv`.
   Expect: `Imported: 8`.
3. **Attendance second:** Settings → Attendance import → **Import attendance CSV** → pick `phase2_attendance.csv`.
   Expect: imported around 172, unmatched `2` (`M-GHOST` has no member — that is correct).
4. Open **Home** or **Actions** once so risk scores refresh.

Do **not** use **Load mock attendance** for this test. That only adds one fake check-in.

## Add a 30-day membership (one tap)

Open each of these members → **Add membership**:

- Sara Khan
- Omar Ali
- Nadia Hussain
- Fatima Noor
- Usman Tariq
- Zainab Iqbal

Leave **Bilal Ahmed** and **Ayesha Malik** without a membership at first.

## What you should see

| Member | What to check |
|---|---|
| **Sara Khan** | High/critical risk, attendance decline vs her own baseline, factors listed, “Not an AI prediction”. After Home/Actions refresh she should appear in high-risk and get a risk follow-up. |
| **Omar Ali** | Low/moderate risk, little or no decline, recent visits on the timeline. |
| **Nadia Hussain** | High inactivity (last visit ~22 days ago). |
| **Bilal Ahmed** | Low confidence — more data needed. Then **Start trial**. |
| **Ayesha Malik** | **Start trial**, then **Convert trial to membership**. Analytics trial conversion should move off empty. |
| **Usman Tariq** | **Record cancellation** (pick a reason). Analytics should show that reason. |
| **Zainab Iqbal** | **Renew membership**. Timeline should show the old row as renewed and a new 30-day membership. |
| **Fatima Noor** | Normal regular attendee after you add a membership. |

Also confirm:

- Home high-risk list includes Sara (and maybe Nadia).
- Actions shows a risk follow-up after you open Actions.
- Analytics shows renewal / trial conversion / cancellation reasons (after the in-app steps above).
- App still works with airplane mode on.
- Settings still shows `v0.2.0 (6)`.

## Get the files onto the phone

From this PC: copy `testdata\phase2_members.csv` and `testdata\phase2_attendance.csv` via USB, Drive, WhatsApp, or email.

Or download them from the v0.2.0 GitHub Release assets.
