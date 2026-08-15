/// English-first localization keys. Architecture is RTL/i18n ready.
class AppStrings {
  const AppStrings();

  String get appName => 'GymPulse';
  String get tagline =>
      'Know who you are about to lose — before you lose them.';

  String get navHome => 'Home';
  String get navMembers => 'Members';
  String get navActions => 'Actions';
  String get navAnalytics => 'Analytics';
  String get navSettings => 'Settings';

  String get unlockTitle => 'Unlock GymPulse';
  String get unlockHint => 'Enter your app PIN';
  String get unlockAction => 'Unlock';
  String get incorrectPin => 'Incorrect PIN. Try again.';
  String get lockoutMessage => 'Too many attempts. Try again later.';
  String get lockApp => 'Lock app';

  String get setupPinTitle => 'Create your app PIN';
  String get setupPinSubtitle =>
      'Your data stays on this phone. Protect GymPulse with a PIN.';
  String get pinLabel => 'PIN (min 6 digits)';
  String get pinConfirmLabel => 'Confirm PIN';
  String get pinMismatch => 'PINs do not match.';
  String get pinTooShort => 'PIN must be at least 6 digits.';
  String get continueAction => 'Continue';

  String get backupEducation =>
      'Your data stays on this phone. Create encrypted backups regularly.';

  String get settingsTitle => 'Settings';
  String get securityTitle => 'Security';
  String get changePin => 'Change PIN';
  String get backupRestore => 'Backup & Restore';
  String get lastBackup => 'Last backup';
  String get neverBackedUp => 'Never';
  String get backupNow => 'Backup Now';
  String get backupReminder => 'Backup reminder';
  String get backupStaleWarning =>
      'Your backup is stale. Create an encrypted backup now.';
  String get forgottenBackupPasswordWarning =>
      'If you forget this backup password, this backup cannot be recovered. GymPulse cannot reset it.';
  String get restoreBackup => 'Restore backup';
  String get restoreBackupSubtitle =>
      'Replace local data with an encrypted backup. Failed restore will not change existing data.';
  String get shareBackup => 'Share last backup';
  String get noBackupToShare => 'No backup file is available to share yet.';
  String get backupPasswordLabel => 'Backup password';
  String get backupPasswordConfirmLabel => 'Confirm backup password';
  String get forgotPin => 'Forgot PIN?';
  String get factoryReset => 'Factory reset';
  String get factoryResetWarning =>
      'This permanently deletes all GymPulse data on this phone. Type RESET to confirm. A backup cannot be recovered without its password.';
  String get factoryResetConfirmLabel => 'Type RESET to confirm';
  String get backupCreated => 'Encrypted backup created.';
  String get restoreSucceeded =>
      'Backup restored. Unlock with the PIN that was active when the backup was made.';
  String get interval7 => 'Every 7 days';
  String get interval14 => 'Every 14 days';
  String get interval30 => 'Every 30 days';

  String get phase0HomeTitle => 'Foundation ready';
  String get phase0HomeBody =>
      'Phase 0 is installed. Core screens and local security are online. Membership workflows arrive in Phase 1.';

  String get retry => 'Retry';
  String get cancel => 'Cancel';
  String get save => 'Save';
  String get somethingWentWrong => 'Something went wrong. Try again.';
  String get updateAvailable => 'Update available';
  String get updateNow => 'Update now';
  String get later => 'Later';

  String lockoutCooldown(int seconds) =>
      'Too many attempts. Try again in ${seconds}s.';
}
