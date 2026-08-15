import 'dart:convert';

import 'package:equatable/equatable.dart';

class AppReleaseInfo extends Equatable {
  const AppReleaseInfo({
    required this.versionName,
    required this.versionCode,
    required this.apkUrl,
    required this.sha256,
    required this.releaseNotes,
    this.minimumSupportedVersionCode = 1,
  });

  final String versionName;
  final int versionCode;
  final String apkUrl;
  final String sha256;
  final String releaseNotes;
  final int minimumSupportedVersionCode;

  factory AppReleaseInfo.fromJson(Map<String, dynamic> json) {
    return AppReleaseInfo(
      versionName: json['versionName']?.toString() ?? '',
      versionCode: int.tryParse('${json['versionCode']}') ?? 0,
      apkUrl: json['apkUrl']?.toString() ?? '',
      sha256: json['sha256']?.toString() ?? '',
      releaseNotes: json['releaseNotes']?.toString() ?? '',
      minimumSupportedVersionCode:
          int.tryParse('${json['minimumSupportedVersionCode']}') ?? 1,
    );
  }

  Map<String, Object?> toJson() => {
    'versionName': versionName,
    'versionCode': versionCode,
    'minimumSupportedVersionCode': minimumSupportedVersionCode,
    'apkUrl': apkUrl,
    'sha256': sha256,
    'releaseNotes': releaseNotes,
  };

  @override
  List<Object?> get props => [
    versionName,
    versionCode,
    apkUrl,
    sha256,
    releaseNotes,
  ];
}

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
    final body = await httpGet(uri);
    final decoded = jsonDecode(body);
    if (decoded is! Map<String, dynamic>) return null;
    return AppReleaseInfo.fromJson(decoded);
  }
}

class AppUpdateService {
  AppUpdateService({
    required this.provider,
    required this.currentVersionCode,
    required this.applicationId,
  });

  final AppUpdateProvider provider;
  final int currentVersionCode;
  final String applicationId;

  Future<AppReleaseInfo?> checkForUpdate() async {
    final latest = await provider.fetchLatest();
    if (latest == null) return null;
    if (latest.versionCode <= currentVersionCode) return null;
    return latest;
  }
}
