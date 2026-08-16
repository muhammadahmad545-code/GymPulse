/// English-first localization keys. Architecture is RTL/i18n ready.
class AppStrings {
  const AppStrings();

  String get appName => 'Mr. Gym';
  String get tagline => 'What does Mr. Gym need to handle today?';

  String get navHome => 'Home';
  String get navMembers => 'Members';
  String get navActions => 'Actions';
  String get navAnalytics => 'Analytics';
  String get navSettings => 'Settings';

  String get unlockTitle => 'Unlock Mr. Gym';
  String get unlockHint => 'Enter your app PIN';
  String get unlockAction => 'Unlock';
  String get incorrectPin => 'Incorrect PIN. Try again.';
  String get lockoutMessage => 'Too many attempts. Try again later.';
  String get lockApp => 'Lock app';

  String get setupPinTitle => 'Create your app PIN';
  String get setupPinSubtitle =>
      'Your data stays on this phone. Protect Mr. Gym with a PIN.';
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
      'If you forget this backup password, this backup cannot be recovered. Mr. Gym cannot reset it.';
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
      'This permanently deletes all Mr. Gym data on this phone. Type RESET to confirm. A backup cannot be recovered without its password.';
  String get factoryResetConfirmLabel => 'Type RESET to confirm';
  String get backupCreated => 'Encrypted backup created.';
  String get restoreSucceeded =>
      'Backup restored. Unlock with the PIN that was active when the backup was made.';
  String get interval7 => 'Every 7 days';
  String get interval14 => 'Every 14 days';
  String get interval30 => 'Every 30 days';

  String get setupGymTitle => 'Set up Mr. Gym';
  String get setupGymSubtitle =>
      'Country, timezone, and currency stay on this phone and can be changed later.';
  String get gymName => 'Gym name';
  String get locationName => 'Location name';
  String get fullName => 'Full name';
  String get whatsappNumber => 'WhatsApp contact number';
  String get joiningFeeDate => 'Joining Date / Fee Date';
  String get joiningFeeDateHelp =>
      'This date starts the monthly membership reminder cycle. The next fee is the same calendar day next month.';
  String get genderOptional => 'Gender (optional)';
  String get notesOptional => 'Notes (optional)';
  String get markAttendance => 'Mark Attendance';
  String get attendanceAlreadyMarked => 'Attendance already marked today.';
  String get recordAnotherVisit => 'Record another visit';
  String get todaysAttendance => "Today's attendance";
  String get feesDueToday => 'Fees due today';
  String get feesDueIn3Days => 'Fees due in 3 days';
  String get overdueMembers => 'Overdue / expired';
  String get recentAttendance => 'Recent attendance';
  String get notAttendedRecently => 'Have not attended recently';
  String get nextFeeDate => 'Next fee date';
  String get feeStatus => 'Fee status';
  String get reminderHistory => 'Reminder history';
  String get whatsappOpenedNotSent =>
      'WhatsApp opened. Mr. Gym cannot confirm that the message was sent.';
  String get searchEverything =>
      'Search members, phone, attendance, follow-ups';
  String get filterActive => 'Active';
  String get filterInactive => 'Inactive';
  String get filterDueSoon => 'Due soon';
  String get filterOverdue => 'Overdue';
  String get deactivateMember => 'Deactivate member';
  String get cancellationReasons => 'Cancellation reasons';
  String get exportMembers => 'Export members CSV';
  String get exportFeeReminders => 'Export fee reminders CSV';
  String get notifyFeeReminders => 'Fee reminders';
  String get addMembership => 'Add monthly membership';
  String get renewMembership => 'Renew one calendar month';
  String get country => 'Country';
  String get timezone => 'Timezone';
  String get currency => 'Currency';
  String get gymPhoneOptional => 'Gym phone (optional)';
  String get capacityOptional => 'Capacity (optional)';
  String get gymSettings => 'Gym settings';
  String get saved => 'Saved.';
  String get staleImportHours => 'Hours before attendance is stale';
  String get inactivityMonitor => 'Inactivity monitor (days)';
  String get inactivityFollowUp => 'Inactivity follow-up (days)';
  String get inactivityHighRisk => 'Inactivity high risk (days)';
  String get inactivityCritical => 'Inactivity critical (days)';

  String get needsAttention => 'Needs attention today';
  String get noAttention => 'No expiry or inactivity actions right now.';
  String get peakHours => 'Peak hours';
  String get noPeakHours => 'Not enough attendance history to show peak hours.';
  String get visits => 'visits';
  String get activeMembers => 'Active members';
  String get openActions => 'Open actions';
  String get unmatched => 'Unmatched';
  String get healthScore => 'Health score';
  String get attendance => 'Attendance';
  String get lastImport => 'Last import';
  String get trials => 'Trials';
  String get cancellations => 'Cancellations';
  String get phase2Analytics => 'basic capture only in this phase';
  String get riskScore => 'Risk score';
  String get riskFactors => 'Risk factors';
  String get lowConfidence => 'Low confidence — more data needed.';
  String get attendanceDecline => 'Attendance decline';
  String get memberTimeline => 'Timeline';
  String get noTimeline => 'No timeline events yet.';
  String get startTrial => 'Start trial';
  String get convertTrial => 'Convert trial to membership';
  String get recordCancellation => 'Record cancellation';
  String get cancellationReason => 'Cancellation reason';
  String get renewalAnalytics => 'Renewal';
  String get trialConversion => 'Trial conversion';
  String get highRiskMembers => 'High-risk members';
  String get noHighRisk => 'No high-risk members right now.';
  String get riskWeights => 'Risk score weights';
  String get trialDefaultDays => 'Default trial length (days)';
  String get notAnAiScore =>
      'Explainable weighted score. Not an AI prediction.';
  String get capacityUtilization => 'Capacity utilization';
  String get peakWindows => 'Peak windows';
  String get locations => 'Locations';
  String get addLocation => 'Add location';
  String get switchLocation => 'Switch location';
  String get currentLocation => 'Current location';
  String get peakHighAttendance => 'High-attendance threshold';
  String get operationsReport => 'Operations report';
  String get exportReports => 'Export reports';
  String get exportAttendance => 'Export attendance CSV';
  String get exportFollowUps => 'Export follow-ups CSV';
  String get exportTrials => 'Export trials CSV';
  String get exportCancellations => 'Export cancellations CSV';
  String get reconcileAttendance => 'Reconcile attendance';
  String get expectedCount => 'Expected source count';
  String get adapters => 'Attendance adapters';
  String get importJson => 'Import attendance JSON';
  String get dailySummary => 'Daily operations summary';
  String get notificationPrefs => 'Local notifications';
  String get notifyDailySummary => 'Daily summary';
  String get notifyImportStale => 'Stale import';
  String get notifyHighRisk => 'High-risk members';
  String get notifyExpiryQueue => 'Expiry queue';
  String get addAnotherLocation =>
      'Add another location to compare. Data stays on this phone.';
  String get windowsConnectorHelp =>
      'Optional free Windows tool: drop official CSV/JSON exports into a folder and it writes a GymPulse attendance file. No paid cloud relay.';

  String get searchMembers => 'Search members';
  String get noMembers => 'No members yet. Add a member to get started.';
  String get addMember => 'Add member';
  String get editMember => 'Edit member';
  String get firstName => 'First name';
  String get lastName => 'Last name';
  String get phoneOptional => 'Phone (optional)';
  String get emailOptional => 'Email (optional)';
  String get externalMemberId => 'External member ID';
  String get status => 'Status';
  String get membership => 'Membership';
  String get noMembership => 'No membership on file.';
  String get contactMember => 'Contact member';
  String get whatsapp => 'WhatsApp';
  String get call => 'Call';
  String get copyMessage => 'Copy message';
  String get noActions => 'No open follow-ups.';
  String get priority => 'Priority';
  String get markContacted => 'Mark contacted';
  String get snooze => 'Snooze';
  String get resolve => 'Resolve';

  String get importAttendance => 'Attendance import';
  String get importCsv => 'Import attendance CSV';
  String get loadMockAttendance => 'Load mock attendance (test only)';
  String get csvFormatHelp =>
      'CSV columns: external_event_id, external_member_id, occurred_at, event_type. Missing members stay unmatched and are never discarded.';
  String get imported => 'Imported';
  String get skipped => 'Skipped';
  String get errors => 'Errors';
  String get attendanceUnavailable =>
      'Attendance is unavailable. This is not shown as zero visits.';
  String get exportCsv => 'Export CSV (not encrypted)';
  String get importMembersCsv => 'Import members CSV';
  String get csvNotBackup =>
      'CSV is for interoperability only. It is not an encrypted backup.';

  String expiresInDays(int days) =>
      days < 0 ? 'Expired ${-days} day(s) ago' : 'Expires in $days day(s)';
  String inactiveForDays(int days) => 'No visit for $days day(s)';

  String get retry => 'Retry';
  String get cancel => 'Cancel';
  String get save => 'Save';
  String get somethingWentWrong => 'Something went wrong. Try again.';
  String get updateAvailable => 'Update available';
  String get updateNow => 'Update now';
  String get later => 'Later';
  String get checkForUpdates => 'Check for updates';
  String get checkingForUpdates => 'Checking for updates…';
  String get upToDate => 'You are on the latest version.';
  String get downloadingUpdate => 'Downloading update…';
  String get installerLaunched =>
      'Android will ask you to confirm installation. If you cancel, Mr. Gym stays on this version.';
  String get updateCancelled => 'Update download cancelled.';
  String get updateCheckFailed =>
      'Could not check for updates. Check your connection and try again.';
  String get updatesNeedNetwork =>
      'Checking for updates needs a network connection. Mr. Gym still works offline.';

  String lockoutCooldown(int seconds) =>
      'Too many attempts. Try again in ${seconds}s.';
}
