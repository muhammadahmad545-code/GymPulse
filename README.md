# Mr. Gym

Offline gym management for one gym: **Mr. Gym**.

The app runs entirely on the phone. There is no cloud backend, no AI, and no biometric hardware.

## Daily use

- Create members (name, WhatsApp number, joining/fee date)
- Search a member and tap **Mark Attendance**
- Track monthly fees with calendar-month dates
- Open WhatsApp with a prefilled reminder (you press Send in WhatsApp)
- Encrypted local backup and restore
- Dark, light, or system theme (Settings → Appearance)

## Stack

Flutter + Riverpod + Drift / SQLite

Internet is optional and only used to open WhatsApp or download an app update from GitHub.

## Android package

`com.mrgym.app`

If you installed an older build that used a different package ID, uninstall it once before installing this release.

## Develop

```bash
flutter pub get
dart run build_runner build
flutter analyze
flutter test
flutter build apk --release \
  --dart-define=GITHUB_UPDATE_OWNER=YOUR_GITHUB_USER \
  --dart-define=GITHUB_UPDATE_REPO=Mr-Gym
```

Do not commit secrets, keystores, or `.env` files.

## GitHub

Repository: [Mr-Gym](https://github.com/muhammadahmad545-code/Mr-Gym)
