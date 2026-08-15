import '../core/errors/app_exception.dart';
import 'app_release_info.dart';

final _sha256Hex = RegExp(r'^[a-fA-F0-9]{64}$');

/// Parses GitHub release metadata and rejects anything that is not an HTTPS
/// GitHub Release APK for the configured owner/repo.
AppReleaseInfo parseAndValidateReleaseMetadata({
  required Object? decoded,
  required String owner,
  required String repo,
}) {
  if (owner.isEmpty || repo.isEmpty) {
    throw AppException(
      code: AppErrorCodes.updateCheckFailed,
      message: 'Update source is not configured.',
    );
  }
  if (decoded is! Map) {
    throw AppException(
      code: AppErrorCodes.updateCheckFailed,
      message: 'Update metadata is missing or unreadable.',
    );
  }

  final info = AppReleaseInfo.fromJson(Map<String, dynamic>.from(decoded));
  if (info.versionName.trim().isEmpty || info.versionCode < 1) {
    throw AppException(
      code: AppErrorCodes.updateCheckFailed,
      message: 'Update metadata is missing a valid version.',
    );
  }

  final sha = info.sha256.trim().toLowerCase();
  if (!_sha256Hex.hasMatch(sha)) {
    throw AppException(
      code: AppErrorCodes.updateCheckFailed,
      message: 'Update metadata is missing a valid SHA-256 checksum.',
    );
  }

  final uri = Uri.tryParse(info.apkUrl.trim());
  if (uri == null ||
      uri.scheme.toLowerCase() != 'https' ||
      uri.host.toLowerCase() != 'github.com') {
    throw AppException(
      code: AppErrorCodes.updateCheckFailed,
      message: 'Update metadata has an invalid download address.',
    );
  }

  final pathPattern = RegExp(
    '^/${RegExp.escape(owner)}/${RegExp.escape(repo)}/releases/download/[^/]+/[^/]+\\.apk\$',
    caseSensitive: false,
  );
  if (!pathPattern.hasMatch(uri.path)) {
    throw AppException(
      code: AppErrorCodes.updateCheckFailed,
      message: 'Update metadata does not point at this app\'s GitHub Release.',
    );
  }

  return AppReleaseInfo(
    versionName: info.versionName.trim(),
    versionCode: info.versionCode,
    apkUrl: uri.toString(),
    sha256: sha,
    releaseNotes: info.releaseNotes.trim(),
    minimumSupportedVersionCode: info.minimumSupportedVersionCode,
  );
}

bool isNewerVersion({required int latest, required int current}) =>
    latest > current;

bool sha256Matches({required String expected, required String actual}) =>
    expected.trim().toLowerCase() == actual.trim().toLowerCase();
