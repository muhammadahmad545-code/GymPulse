# GymPulse Windows connector

Optional free offline tool. It does **not** talk to a GymPulse cloud and does **not** invent vendor APIs.

Use it on a reception PC when the gym software can export attendance as CSV or JSON.

## What it does

1. Reads every `.csv`, `.txt`, and `.json` file in an input folder.
2. Normalizes rows to GymPulse columns:
   `external_event_id,external_member_id,occurred_at,event_type`
3. Writes one attendance file you can copy to the phone and import in GymPulse.

Vendor REST/SDK/database readers stay **pending official documentation**.

## Build

Requires [.NET 10 SDK](https://dotnet.microsoft.com/download).

```powershell
dotnet build
```

## Run

```powershell
mkdir in, out
# Copy official exports into .\in
dotnet run -- --in in --out out\gympulse-attendance.csv
```

Copy `out\gympulse-attendance.csv` to the phone. In GymPulse: Settings → Attendance import → Import attendance CSV.

## JSON shape

```json
{
  "events": [
    {
      "external_event_id": "e1",
      "external_member_id": "M-DECLINE",
      "occurred_at": "2026-08-16T18:10:00+05:00",
      "event_type": "check_in"
    }
  ]
}
```

A raw event array is also accepted.
