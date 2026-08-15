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
    minimumSupportedVersionCode,
  ];
}
