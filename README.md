# GymPulse Flutter App

Local-first gym retention platform. See [`docs/`](docs/) for the product source of truth.

## Stack

- Flutter + Riverpod
- Drift / SQLite (on-device system of record)
- No mandatory cloud backend

## Application ID

`com.gympulse.app`

## Develop

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
flutter build apk --release
```

## Configuration

Copy `.env.example` values into local/CI secrets as needed. Do not commit secrets.

GitHub owner/repo for APK update checks are supplied via `--dart-define` (never hard-code personal URLs in source as required values).
