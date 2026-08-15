import 'dart:io';

class UpdateCancelToken {
  bool _cancelled = false;

  bool get isCancelled => _cancelled;

  void cancel() => _cancelled = true;
}

class DownloadProgress {
  const DownloadProgress({required this.receivedBytes, this.totalBytes});

  final int receivedBytes;
  final int? totalBytes;

  double? get fraction {
    final total = totalBytes;
    if (total == null || total <= 0) return null;
    return (receivedBytes / total).clamp(0, 1);
  }
}

class ApkIdentity {
  const ApkIdentity({
    required this.packageName,
    required this.versionCode,
    this.versionName,
  });

  final String packageName;
  final int versionCode;
  final String? versionName;
}

abstract class ApkDownloader {
  Future<File> download({
    required Uri uri,
    required File destination,
    required UpdateCancelToken cancelToken,
    void Function(DownloadProgress progress)? onProgress,
  });
}

abstract class ApkInspector {
  Future<ApkIdentity> inspect(String path);
}

abstract class ApkInstaller {
  Future<bool> canRequestInstalls();
  Future<void> openInstallPermissionSettings();
  Future<void> install(String path);
}

abstract class DiskSpace {
  Future<int> freeBytes(String directoryPath);
}
