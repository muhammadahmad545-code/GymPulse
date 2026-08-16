import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as p;

import '../core/errors/app_exception.dart';
import 'app_release_info.dart';
import 'release_metadata.dart';
import 'update_contracts.dart';

export 'app_release_info.dart';
export 'update_contracts.dart';

abstract class AppUpdateProvider {
  Future<AppReleaseInfo?> fetchLatest();
}

/// Future Play Store provider — architecture placeholder only.
class PlayStoreUpdateProvider implements AppUpdateProvider {
  @override
  Future<AppReleaseInfo?> fetchLatest() async => null;
}

class GitHubReleaseUpdateProvider implements AppUpdateProvider {
  GitHubReleaseUpdateProvider({
    required this.owner,
    required this.repo,
    required this.httpGet,
  });

  final String owner;
  final String repo;
  final Future<String> Function(Uri uri) httpGet;

  @override
  Future<AppReleaseInfo?> fetchLatest() async {
    if (owner.isEmpty || repo.isEmpty) return null;
    final uri = Uri.parse(
      'https://github.com/$owner/$repo/releases/latest/download/release-metadata.json',
    );
    try {
      final body = await httpGet(uri);
      return parseAndValidateReleaseMetadata(
        decoded: jsonDecode(body),
        owner: owner,
        repo: repo,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (error) {
      throw AppException(
        code: AppErrorCodes.updateCheckFailed,
        message: 'Update metadata is missing or unreadable.',
        cause: error,
      );
    } catch (error) {
      throw AppException(
        code: AppErrorCodes.updateCheckFailed,
        message:
            'Could not check for updates. Check your connection and try again.',
        retryable: true,
        cause: error,
      );
    }
  }
}

class PreparedUpdate {
  const PreparedUpdate({
    required this.file,
    required this.info,
    required this.sha256,
    required this.identity,
  });

  final File file;
  final AppReleaseInfo info;
  final String sha256;
  final ApkIdentity identity;
}

class AppUpdateService {
  AppUpdateService({
    required this.provider,
    required this.currentVersionCode,
    required this.applicationId,
    required this.githubOwner,
    required this.githubRepo,
    this.downloader,
    this.inspector,
    this.installer,
    this.diskSpace,
    this.hashFile = sha256File,
    Directory? cacheDirectory,
    this.resolveCacheDirectory,
  }) : _cacheDirectory = cacheDirectory;

  final AppUpdateProvider provider;
  final int currentVersionCode;
  final String applicationId;
  final String githubOwner;
  final String githubRepo;
  final ApkDownloader? downloader;
  final ApkInspector? inspector;
  final ApkInstaller? installer;
  final DiskSpace? diskSpace;
  final Future<String> Function(File file) hashFile;
  final Directory? _cacheDirectory;
  final Future<Directory> Function()? resolveCacheDirectory;

  bool get hasUpdateSource => githubOwner.isNotEmpty && githubRepo.isNotEmpty;

  Future<AppReleaseInfo?> checkForUpdate() async {
    if (!hasUpdateSource) return null;
    final latest = await provider.fetchLatest();
    if (latest == null) return null;
    final validated = parseAndValidateReleaseMetadata(
      decoded: latest.toJson(),
      owner: githubOwner,
      repo: githubRepo,
    );
    if (!isNewerVersion(
      latest: validated.versionCode,
      current: currentVersionCode,
    )) {
      return null;
    }
    return validated;
  }

  Future<PreparedUpdate> downloadAndVerify(
    AppReleaseInfo info, {
    UpdateCancelToken? cancelToken,
    void Function(DownloadProgress progress)? onProgress,
  }) async {
    final token = cancelToken ?? UpdateCancelToken();
    final validated = parseAndValidateReleaseMetadata(
      decoded: info.toJson(),
      owner: githubOwner,
      repo: githubRepo,
    );
    if (!isNewerVersion(
      latest: validated.versionCode,
      current: currentVersionCode,
    )) {
      throw AppException(
        code: AppErrorCodes.updateInvalidVersion,
        message: 'This update is not newer than the installed version.',
      );
    }

    final loader = downloader;
    final inspect = inspector;
    if (loader == null || inspect == null) {
      throw AppException(
        code: AppErrorCodes.updateDownloadFailed,
        message: 'Update download is not available on this device.',
      );
    }

    final destination = await _destinationFile();
    await _ensureStorage(destination.parent, reservedBytes: 2 * 1024 * 1024);

    File? file;
    try {
      file = await loader.download(
        uri: Uri.parse(validated.apkUrl),
        destination: destination,
        cancelToken: token,
        onProgress: onProgress,
      );
      if (token.isCancelled) {
        throw AppException(
          code: AppErrorCodes.updateCancelled,
          message: 'Update download cancelled.',
        );
      }

      final digest = await hashFile(file);
      if (!sha256Matches(expected: validated.sha256, actual: digest)) {
        throw AppException(
          code: AppErrorCodes.updateIntegrityFailed,
          message:
              'The downloaded update failed integrity checks and was discarded.',
        );
      }

      final identity = await inspect.inspect(file.path);
      if (identity.packageName != applicationId) {
        throw AppException(
          code: AppErrorCodes.updateInvalidPackage,
          message: 'This update is not a Mr. Gym package and was discarded.',
        );
      }
      if (identity.versionCode != validated.versionCode ||
          !isNewerVersion(
            latest: identity.versionCode,
            current: currentVersionCode,
          )) {
        throw AppException(
          code: AppErrorCodes.updateInvalidVersion,
          message:
              'The downloaded update version is not valid and was discarded.',
        );
      }

      return PreparedUpdate(
        file: file,
        info: validated,
        sha256: digest,
        identity: identity,
      );
    } catch (error) {
      if (file != null) {
        try {
          if (await file.exists()) await file.delete();
        } catch (_) {}
      }
      if (error is AppException) rethrow;
      throw AppException(
        code: AppErrorCodes.updateDownloadFailed,
        message: 'Could not download the update. Try again.',
        retryable: true,
        cause: error,
      );
    }
  }

  Future<void> installPrepared(PreparedUpdate prepared) async {
    final install = installer;
    final inspect = inspector;
    if (install == null || inspect == null) {
      throw AppException(
        code: AppErrorCodes.updateInstallFailed,
        message: 'Update installation is not available on this device.',
      );
    }
    if (!await prepared.file.exists()) {
      throw AppException(
        code: AppErrorCodes.updateIntegrityFailed,
        message:
            'The downloaded update is no longer available. Download again.',
      );
    }

    final digest = await hashFile(prepared.file);
    if (!sha256Matches(expected: prepared.info.sha256, actual: digest)) {
      await _deleteQuietly(prepared.file);
      throw AppException(
        code: AppErrorCodes.updateIntegrityFailed,
        message:
            'The downloaded update failed integrity checks and was discarded.',
      );
    }

    final identity = await inspect.inspect(prepared.file.path);
    if (identity.packageName != applicationId) {
      await _deleteQuietly(prepared.file);
      throw AppException(
        code: AppErrorCodes.updateInvalidPackage,
        message: 'This update is not a Mr. Gym package and was discarded.',
      );
    }
    if (identity.versionCode != prepared.info.versionCode ||
        !isNewerVersion(
          latest: identity.versionCode,
          current: currentVersionCode,
        )) {
      await _deleteQuietly(prepared.file);
      throw AppException(
        code: AppErrorCodes.updateInvalidVersion,
        message:
            'The downloaded update version is not valid and was discarded.',
      );
    }

    if (!await install.canRequestInstalls()) {
      await install.openInstallPermissionSettings();
      throw AppException(
        code: AppErrorCodes.updatePermissionRequired,
        message: 'Allow Mr. Gym to install updates, then tap Update again.',
      );
    }

    await install.install(prepared.file.path);
  }

  Future<PreparedUpdate> downloadAndInstall(
    AppReleaseInfo info, {
    UpdateCancelToken? cancelToken,
    void Function(DownloadProgress progress)? onProgress,
  }) async {
    final prepared = await downloadAndVerify(
      info,
      cancelToken: cancelToken,
      onProgress: onProgress,
    );
    await installPrepared(prepared);
    return prepared;
  }

  Future<void> _ensureStorage(
    Directory directory, {
    required int reservedBytes,
  }) async {
    final disk = diskSpace;
    if (disk == null) return;
    directory.createSync(recursive: true);
    final free = await disk.freeBytes(directory.path);
    if (free > 0 && free < reservedBytes) {
      throw AppException(
        code: AppErrorCodes.updateInsufficientStorage,
        message: 'Not enough storage to download this update.',
      );
    }
  }

  Future<File> _destinationFile() async {
    final dir = resolveCacheDirectory != null
        ? await resolveCacheDirectory!()
        : (_cacheDirectory ?? Directory.systemTemp);
    final updates = Directory(p.join(dir.path, 'updates'));
    updates.createSync(recursive: true);
    return File(p.join(updates.path, 'Mr-Gym-update.apk'));
  }

  Future<void> _deleteQuietly(File file) async {
    try {
      if (await file.exists()) await file.delete();
    } catch (_) {}
  }
}

Future<String> sha256File(File file) async {
  final digest = await sha256.bind(file.openRead()).first;
  return digest.toString();
}
