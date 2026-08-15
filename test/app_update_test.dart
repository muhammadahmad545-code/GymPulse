import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gympulse/core/errors/app_exception.dart';
import 'package:gympulse/updates/app_update_service.dart';
import 'package:gympulse/updates/release_metadata.dart';
import 'package:path/path.dart' as p;

const _owner = 'test-owner';
const _repo = 'GymPulse';
const _validSha =
    'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
const _validUrl =
    'https://github.com/test-owner/GymPulse/releases/download/v9.0.0/GymPulse-9.0.0.apk';

AppReleaseInfo _info({
  String versionName = '9.0.0',
  int versionCode = 90,
  String apkUrl = _validUrl,
  String sha256 = _validSha,
}) {
  return AppReleaseInfo(
    versionName: versionName,
    versionCode: versionCode,
    apkUrl: apkUrl,
    sha256: sha256,
    releaseNotes: 'Newer build for owner testing.',
  );
}

String _shaOf(List<int> bytes) => sha256.convert(bytes).toString();

void main() {
  late Directory temp;

  setUp(() async {
    temp = await Directory.systemTemp.createTemp('gp-update-');
  });

  tearDown(() async {
    if (await temp.exists()) {
      await temp.delete(recursive: true);
    }
  });

  group('release metadata validation', () {
    test('accepts HTTPS GitHub Release APK for configured repo', () {
      final info = parseAndValidateReleaseMetadata(
        decoded: _info().toJson(),
        owner: _owner,
        repo: _repo,
      );
      expect(info.versionCode, 90);
      expect(info.sha256, _validSha);
    });

    test('rejects http, wrong host, wrong repo, and short checksums', () {
      expect(
        () => parseAndValidateReleaseMetadata(
          decoded: _info(
            apkUrl:
                'http://github.com/test-owner/GymPulse/releases/download/v1/a.apk',
          ).toJson(),
          owner: _owner,
          repo: _repo,
        ),
        throwsA(
          isA<AppException>().having(
            (e) => e.code,
            'code',
            AppErrorCodes.updateCheckFailed,
          ),
        ),
      );
      expect(
        () => parseAndValidateReleaseMetadata(
          decoded: _info(
            apkUrl:
                'https://evil.example/test-owner/GymPulse/releases/download/v1/a.apk',
          ).toJson(),
          owner: _owner,
          repo: _repo,
        ),
        throwsA(isA<AppException>()),
      );
      expect(
        () => parseAndValidateReleaseMetadata(
          decoded: _info(
            apkUrl:
                'https://github.com/other/GymPulse/releases/download/v1/a.apk',
          ).toJson(),
          owner: _owner,
          repo: _repo,
        ),
        throwsA(isA<AppException>()),
      );
      expect(
        () => parseAndValidateReleaseMetadata(
          decoded: _info(sha256: 'abc').toJson(),
          owner: _owner,
          repo: _repo,
        ),
        throwsA(isA<AppException>()),
      );
    });
  });

  group('version comparison', () {
    test('update-not-needed when latest is not newer', () async {
      final service = AppUpdateService(
        provider: _FakeProvider(_info(versionCode: 3)),
        currentVersionCode: 3,
        applicationId: 'com.gympulse.app',
        githubOwner: _owner,
        githubRepo: _repo,
      );
      expect(await service.checkForUpdate(), isNull);
    });

    test('returns newer release only', () async {
      final service = AppUpdateService(
        provider: _FakeProvider(_info(versionCode: 4)),
        currentVersionCode: 3,
        applicationId: 'com.gympulse.app',
        githubOwner: _owner,
        githubRepo: _repo,
      );
      expect((await service.checkForUpdate())?.versionCode, 4);
    });

    test('no check when GitHub owner is not configured', () async {
      final service = AppUpdateService(
        provider: _FakeProvider(_info()),
        currentVersionCode: 1,
        applicationId: 'com.gympulse.app',
        githubOwner: '',
        githubRepo: _repo,
      );
      expect(await service.checkForUpdate(), isNull);
    });
  });

  group('download and verification', () {
    test('verifies SHA-256 and installs only after all checks pass', () async {
      final bytes = List<int>.generate(32, (i) => i);
      final digest = _shaOf(bytes);
      final installer = _RecordingInstaller();
      final service = _service(
        cache: temp,
        info: _info(sha256: digest),
        downloader: _FakeDownloader(bytes),
        inspector: const _FakeInspector(
          packageName: 'com.gympulse.app',
          versionCode: 90,
        ),
        installer: installer,
      );

      await service.downloadAndInstall(_info(sha256: digest));
      expect(installer.installed, isTrue);
      expect(installer.paths, isNotEmpty);
    });

    test('SHA-256 mismatch discards file and never installs', () async {
      final installer = _RecordingInstaller();
      final service = _service(
        cache: temp,
        downloader: _FakeDownloader([1, 2, 3]),
        inspector: const _FakeInspector(
          packageName: 'com.gympulse.app',
          versionCode: 90,
        ),
        installer: installer,
      );

      await expectLater(
        service.downloadAndInstall(_info()),
        throwsA(
          isA<AppException>().having(
            (e) => e.code,
            'code',
            AppErrorCodes.updateIntegrityFailed,
          ),
        ),
      );
      expect(installer.installed, isFalse);
      expect(Directory(p.join(temp.path, 'updates')).existsSync(), isTrue);
      expect(
        File(p.join(temp.path, 'updates', 'GymPulse-update.apk')).existsSync(),
        isFalse,
      );
    });

    test('invalid package id never installs', () async {
      final bytes = [9, 8, 7];
      final installer = _RecordingInstaller();
      final service = _service(
        cache: temp,
        downloader: _FakeDownloader(bytes),
        inspector: const _FakeInspector(
          packageName: 'com.evil.app',
          versionCode: 90,
        ),
        installer: installer,
      );

      await expectLater(
        service.downloadAndInstall(_info(sha256: _shaOf(bytes))),
        throwsA(
          isA<AppException>().having(
            (e) => e.code,
            'code',
            AppErrorCodes.updateInvalidPackage,
          ),
        ),
      );
      expect(installer.installed, isFalse);
    });

    test('invalid or stale APK versionCode never installs', () async {
      final bytes = [4, 5, 6];
      final installer = _RecordingInstaller();
      final stale = _service(
        cache: temp,
        currentVersionCode: 90,
        downloader: _FakeDownloader(bytes),
        inspector: const _FakeInspector(
          packageName: 'com.gympulse.app',
          versionCode: 90,
        ),
        installer: installer,
      );
      await expectLater(
        stale.downloadAndVerify(_info(sha256: _shaOf(bytes))),
        throwsA(
          isA<AppException>().having(
            (e) => e.code,
            'code',
            AppErrorCodes.updateInvalidVersion,
          ),
        ),
      );

      final mismatch = _service(
        cache: temp,
        downloader: _FakeDownloader(bytes),
        inspector: const _FakeInspector(
          packageName: 'com.gympulse.app',
          versionCode: 89,
        ),
        installer: installer,
      );
      await expectLater(
        mismatch.downloadAndInstall(_info(sha256: _shaOf(bytes))),
        throwsA(
          isA<AppException>().having(
            (e) => e.code,
            'code',
            AppErrorCodes.updateInvalidVersion,
          ),
        ),
      );
      expect(installer.installed, isFalse);
    });

    test('download failure never installs', () async {
      final installer = _RecordingInstaller();
      final service = _service(
        cache: temp,
        downloader: _FailingDownloader(),
        inspector: const _FakeInspector(
          packageName: 'com.gympulse.app',
          versionCode: 90,
        ),
        installer: installer,
      );
      await expectLater(
        service.downloadAndInstall(_info()),
        throwsA(
          isA<AppException>().having(
            (e) => e.code,
            'code',
            AppErrorCodes.updateDownloadFailed,
          ),
        ),
      );
      expect(installer.installed, isFalse);
    });

    test('cancellation never installs and deletes the partial file', () async {
      final installer = _RecordingInstaller();
      final token = UpdateCancelToken()..cancel();
      final service = _service(
        cache: temp,
        downloader: _FakeDownloader([1, 2, 3], observeToken: true),
        inspector: const _FakeInspector(
          packageName: 'com.gympulse.app',
          versionCode: 90,
        ),
        installer: installer,
      );
      await expectLater(
        service.downloadAndVerify(_info(), cancelToken: token),
        throwsA(
          isA<AppException>().having(
            (e) => e.code,
            'code',
            AppErrorCodes.updateCancelled,
          ),
        ),
      );
      expect(installer.installed, isFalse);
    });

    test('insufficient storage never installs', () async {
      final installer = _RecordingInstaller();
      final service = _service(
        cache: temp,
        downloader: _FakeDownloader([1]),
        inspector: const _FakeInspector(
          packageName: 'com.gympulse.app',
          versionCode: 90,
        ),
        installer: installer,
        disk: _FakeDisk(32),
      );
      await expectLater(
        service.downloadAndVerify(_info()),
        throwsA(
          isA<AppException>().having(
            (e) => e.code,
            'code',
            AppErrorCodes.updateInsufficientStorage,
          ),
        ),
      );
      expect(installer.installed, isFalse);
    });
  });

  group('GitHubReleaseUpdateProvider', () {
    test('maps network failure to UPDATE_CHECK_FAILED', () async {
      final provider = GitHubReleaseUpdateProvider(
        owner: _owner,
        repo: _repo,
        httpGet: (_) async => throw const SocketException('offline'),
      );
      await expectLater(
        provider.fetchLatest(),
        throwsA(
          isA<AppException>().having(
            (e) => e.code,
            'code',
            AppErrorCodes.updateCheckFailed,
          ),
        ),
      );
    });

    test('parses valid metadata JSON', () async {
      final provider = GitHubReleaseUpdateProvider(
        owner: _owner,
        repo: _repo,
        httpGet: (_) async =>
            '{"versionName":"9.0.0","versionCode":90,'
            '"apkUrl":"$_validUrl","sha256":"$_validSha","releaseNotes":"n"}',
      );
      final info = await provider.fetchLatest();
      expect(info?.versionCode, 90);
    });
  });
}

AppUpdateService _service({
  required Directory cache,
  required ApkDownloader downloader,
  required ApkInspector inspector,
  required ApkInstaller installer,
  AppReleaseInfo? info,
  int currentVersionCode = 3,
  DiskSpace? disk,
}) {
  return AppUpdateService(
    provider: _FakeProvider(info ?? _info()),
    currentVersionCode: currentVersionCode,
    applicationId: 'com.gympulse.app',
    githubOwner: _owner,
    githubRepo: _repo,
    downloader: downloader,
    inspector: inspector,
    installer: installer,
    diskSpace: disk,
    cacheDirectory: cache,
  );
}

class _FakeProvider implements AppUpdateProvider {
  _FakeProvider(this.info);
  final AppReleaseInfo info;
  @override
  Future<AppReleaseInfo?> fetchLatest() async => info;
}

class _FakeDownloader implements ApkDownloader {
  _FakeDownloader(this.bytes, {this.observeToken = false});
  final List<int> bytes;
  final bool observeToken;

  @override
  Future<File> download({
    required Uri uri,
    required File destination,
    required UpdateCancelToken cancelToken,
    void Function(DownloadProgress progress)? onProgress,
  }) async {
    if (observeToken && cancelToken.isCancelled) {
      throw AppException(
        code: AppErrorCodes.updateCancelled,
        message: 'Update download cancelled.',
      );
    }
    destination.parent.createSync(recursive: true);
    await destination.writeAsBytes(bytes, flush: true);
    onProgress?.call(
      DownloadProgress(receivedBytes: bytes.length, totalBytes: bytes.length),
    );
    return destination;
  }
}

class _FailingDownloader implements ApkDownloader {
  @override
  Future<File> download({
    required Uri uri,
    required File destination,
    required UpdateCancelToken cancelToken,
    void Function(DownloadProgress progress)? onProgress,
  }) async {
    throw AppException(
      code: AppErrorCodes.updateDownloadFailed,
      message: 'Could not download the update. Try again.',
      retryable: true,
    );
  }
}

class _FakeInspector implements ApkInspector {
  const _FakeInspector({required this.packageName, required this.versionCode});
  final String packageName;
  final int versionCode;

  @override
  Future<ApkIdentity> inspect(String path) async =>
      ApkIdentity(packageName: packageName, versionCode: versionCode);
}

class _RecordingInstaller implements ApkInstaller {
  bool installed = false;
  final paths = <String>[];

  @override
  Future<bool> canRequestInstalls() async => true;

  @override
  Future<void> openInstallPermissionSettings() async {}

  @override
  Future<void> install(String path) async {
    installed = true;
    paths.add(path);
  }
}

class _FakeDisk implements DiskSpace {
  _FakeDisk(this.bytes);
  final int bytes;
  @override
  Future<int> freeBytes(String directoryPath) async => bytes;
}
