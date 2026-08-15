# GymPulse — DevOps & Release Specification

## Environments

- Local development
- CI (GitHub Actions)
- Physical device testing via GitHub Release APKs

There is **no mandatory hosted staging/production backend** for MVP.

Never commit real secrets.

## CI/CD

Pipeline:
1. Format
2. Static analysis
3. Unit tests
4. Drift/repository integration tests
5. Build Android APK
6. Security checks (secret scan, dependency audit)
7. Upload APK artifact
8. Create/update GitHub Release for the phase

Optional later: artifact signing improvements, Play Store track.

## Versioning

Use semantic versioning where appropriate:
- MAJOR
- MINOR
- PATCH

Mobile build numbers (`versionCode`) must always increase.

Android applicationId (permanent unless explicitly changed):
`com.gympulse.app`

## Secrets

Never commit:
- API keys
- database passwords
- signing keys
- connector secrets
- personal access tokens

Use environment configuration / CI secrets only when needed.

`.env.example` may contain placeholders only.

## Backups

Application responsibility:
- encrypted local backup export/restore
- owner-managed copies

No mandatory cloud database backup service.

## Observability

MVP:
- structured local logs
- audit log table
- import/integration health metrics in-app

Optional later (non-mandatory):
- opt-in crash reporting

Monitor in CI/device testing:
- test failures
- build failures
- APK install/update smoke results

## Integration alerts

In-app / local notifications when:
- import overdue/stale
- import failure rate spikes
- unmatched events spike

## Android release

As of the current Google Play policy, new Android apps and updates submitted from August 31, 2026 must target Android 16 / API 36 or higher. Build the release pipeline so the target SDK can be updated without architectural changes.

Play Store distribution is optional future work. GitHub Releases are the development/testing distribution channel.

## iOS release

Optional future. Validate with current Apple toolchain when pursued. Not required for the Android-first local MVP.

## App signing

Use a protected local/CI keystore for release APKs.
Never commit the keystore or passwords.

## Store readiness (future)

Prepare when targeting public stores:
- privacy policy
- terms
- data safety disclosures
- screenshots
- app icon
- support contact
- account/data deletion flow where required

## Rollout

Use:
- GitHub Release APKs for owner testing
- in-app update checks via GitHub Releases
- crash monitoring (local / optional later)
- rollback by retaining previous GitHub Release assets

## GitHub repository workflow

GitHub is the remote source of truth for **source code and APK artifacts**.

It is **not** an application runtime backend and must not host application business data APIs.

Phase workflow:

```text
implement phase
→ tests
→ error-handling verification
→ security checks
→ build APK
→ commit
→ push
→ GitHub Release (APK + notes + versionName/versionCode)
→ owner manual install/test on physical Android phone
→ wait for explicit owner approval
→ next phase
```

Do not begin Phase 0 (or any phase) until documentation/architecture for that step is explicitly approved.

The AI agent must:
1. Create/use the designated GitHub repository (`GymPulse`).
2. Configure the local project with the remote origin.
3. Keep secrets out of the repository.
4. Implement work phase-by-phase.
5. Run tests/static analysis before pushing.
6. Commit each completed phase with a meaningful commit message.
7. Push each completed phase to the remote repository.
8. Tag meaningful releases.
9. Publish the corresponding APK as a GitHub Release asset.
10. Keep a changelog/release note describing the update.

Do not hard-code personal GitHub usernames or repository URLs in application source. Configure release owner/repository through build configuration/environment.

Recommended commit style:

```text
feat(phase-01): establish local auth and multi-tenancy
feat(phase-02): add members and memberships
feat(phase-03): add attendance CSV ingestion
fix(attendance): prevent duplicate event processing
```

## Development environment

The developer workflow is **Cursor or VS Code**.

Android Studio is NOT required as the primary development environment.

The agent must provide command-line/build configurations so the project can be developed, tested and built from:
- Cursor
- VS Code
- terminal/CLI
- CI/CD

## APK build and GitHub distribution

After every completed implementation phase/update:

1. Build a release/test APK in CI or locally.
2. Verify installation/build integrity.
3. Use an incremented Android `versionCode`.
4. Update the user-visible version appropriately.
5. Publish the APK to the GitHub remote as a Release asset or equivalent downloadable GitHub artifact.
6. Link the APK to the corresponding source commit/tag.
7. Add release notes/changelog.
8. Do not overwrite an old release asset in a way that destroys reproducibility.

## Initial installation

The first installation is manual.

The owner:
1. downloads the APK from GitHub
2. installs it on the Android phone
3. unlocks/sets up locally
4. tests the current phase

## Subsequent in-app update workflow

```text
GitHub Release
      ↓
New version metadata
      ↓
GymPulse checks for update
      ↓
In-app "Update available"
      ↓
User taps Update
      ↓
Download/hand-off to supported Android installer
      ↓
Android shows required confirmation/permission
      ↓
User confirms
      ↓
New APK installed
      ↓
GymPulse restarts on new version
```

Critical Android constraint:

A normal Android application cannot silently replace its own installed APK. Never bypass Android security.

Abstract behind:

```text
AppUpdateService
    |
    +-- GitHubReleaseUpdateProvider
    +-- PlayStoreUpdateProvider (future)
```

## Release metadata

Publish machine-readable metadata such as:

```json
{
  "versionName": "0.4.0",
  "versionCode": 40,
  "minimumSupportedVersionCode": 1,
  "apkUrl": "https://github.com/<owner>/<repo>/releases/download/v0.4.0/app-release.apk",
  "sha256": "<sha256>",
  "releaseNotes": "Attendance dashboard and inactivity detection improvements."
}
```

## Important update limitation

GitHub-hosted APK updates are suitable for the owner's development/testing loop.

For a public production app distributed to many users, eventually support Google Play. Do not require paid backend services for that transition.

## Release verification

Before publishing an APK:
- build succeeds
- APK installs
- app launches
- package ID is `com.gympulse.app`
- versionCode increased
- migration path tested
- update metadata is correct
- SHA-256 is generated
- release asset is downloadable
- critical smoke tests pass
- source commit/tag matches the release
- core features do not require paid cloud services
