import 'package:flutter/services.dart';

import '../core/errors/app_exception.dart';
import 'update_contracts.dart';

const updateMethodChannel = MethodChannel('com.mrgym.app/updates');

class AndroidUpdatePlatform implements ApkInspector, ApkInstaller, DiskSpace {
  AndroidUpdatePlatform({MethodChannel? channel})
    : _channel = channel ?? updateMethodChannel;

  final MethodChannel _channel;

  @override
  Future<ApkIdentity> inspect(String path) async {
    try {
      final raw = await _channel.invokeMapMethod<String, Object?>(
        'inspectApk',
        {'path': path},
      );
      if (raw == null) {
        throw AppException(
          code: AppErrorCodes.updateIntegrityFailed,
          message: 'The downloaded file is not a readable Android package.',
        );
      }
      final packageName = raw['packageName']?.toString() ?? '';
      final versionCode = int.tryParse('${raw['versionCode']}') ?? 0;
      if (packageName.isEmpty || versionCode < 1) {
        throw AppException(
          code: AppErrorCodes.updateIntegrityFailed,
          message: 'The downloaded file is not a readable Android package.',
        );
      }
      return ApkIdentity(
        packageName: packageName,
        versionCode: versionCode,
        versionName: raw['versionName']?.toString(),
      );
    } on AppException {
      rethrow;
    } on PlatformException catch (error) {
      throw AppException(
        code: AppErrorCodes.updateIntegrityFailed,
        message: 'The downloaded file is not a readable Android package.',
        cause: error,
      );
    }
  }

  @override
  Future<bool> canRequestInstalls() async {
    try {
      return await _channel.invokeMethod<bool>('canRequestInstalls') ?? false;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<void> openInstallPermissionSettings() async {
    try {
      await _channel.invokeMethod<void>('openInstallPermissionSettings');
    } on PlatformException catch (error) {
      throw AppException(
        code: AppErrorCodes.updateInstallFailed,
        message: 'Could not open Android install permission settings.',
        cause: error,
      );
    }
  }

  @override
  Future<void> install(String path) async {
    try {
      await _channel.invokeMethod<void>('installApk', {'path': path});
    } on PlatformException catch (error) {
      if (error.code == AppErrorCodes.updatePermissionRequired) {
        throw AppException(
          code: AppErrorCodes.updatePermissionRequired,
          message: 'Allow Mr. Gym to install updates, then tap Update again.',
          cause: error,
        );
      }
      throw AppException(
        code: AppErrorCodes.updateInstallFailed,
        message: 'Android could not start the package installer.',
        cause: error,
      );
    }
  }

  @override
  Future<int> freeBytes(String directoryPath) async {
    try {
      final value = await _channel.invokeMethod<int>('freeBytes', {
        'path': directoryPath,
      });
      return value ?? 0;
    } catch (_) {
      return 0;
    }
  }
}
