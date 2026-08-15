/// Stable, machine-readable application error codes (docs/17).
class AppErrorCodes {
  static const authInvalidPin = 'AUTH_INVALID_PIN';
  static const authUnlockFailed = 'AUTH_UNLOCK_FAILED';
  static const authLockoutActive = 'AUTH_LOCKOUT_ACTIVE';
  static const authForbidden = 'AUTH_FORBIDDEN';
  static const authPinMismatch = 'AUTH_PIN_MISMATCH';
  static const validationInvalidField = 'VALIDATION_INVALID_FIELD';
  static const backupPassphraseInvalid = 'BACKUP_PASSPHRASE_INVALID';
  static const backupCorrupt = 'BACKUP_CORRUPT';
  static const backupIncompatibleVersion = 'BACKUP_INCOMPATIBLE_VERSION';
  static const backupInsufficientStorage = 'BACKUP_INSUFFICIENT_STORAGE';
  static const backupInterrupted = 'BACKUP_INTERRUPTED';
  static const backupFailed = 'BACKUP_FAILED';
  static const backupPermissionDenied = 'BACKUP_PERMISSION_DENIED';
  static const restoreInterrupted = 'RESTORE_INTERRUPTED';
  static const restoreFailed = 'RESTORE_FAILED';
  static const restoreIntegrityFailed = 'RESTORE_INTEGRITY_FAILED';
  static const updateCheckFailed = 'UPDATE_CHECK_FAILED';
  static const updateDownloadFailed = 'UPDATE_DOWNLOAD_FAILED';
  static const dbCorruptionDetected = 'DB_CORRUPTION_DETECTED';
  static const internalUnexpected = 'INTERNAL_UNEXPECTED_ERROR';
  static const attendanceDataStale = 'ATTENDANCE_DATA_STALE';
  static const attendanceDataUnavailable = 'ATTENDANCE_DATA_UNAVAILABLE';
}

class AppException implements Exception {
  AppException({
    required this.code,
    required this.message,
    this.requestId,
    this.retryable = false,
    this.cause,
  });

  final String code;
  final String message;
  final String? requestId;
  final bool retryable;
  final Object? cause;

  Map<String, Object?> toJson() => {
    'error': {
      'code': code,
      'message': message,
      'requestId': requestId,
      'retryable': retryable,
    },
  };

  @override
  String toString() => 'AppException($code): $message';
}
