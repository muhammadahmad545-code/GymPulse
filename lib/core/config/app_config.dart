/// Build-time configuration. GitHub values via --dart-define only.
class AppConfig {
  const AppConfig({
    required this.githubUpdateOwner,
    required this.githubUpdateRepo,
    required this.applicationId,
    required this.versionName,
    required this.versionCode,
  });

  final String githubUpdateOwner;
  final String githubUpdateRepo;
  final String applicationId;
  final String versionName;
  final int versionCode;

  bool get hasGithubUpdateSource =>
      githubUpdateOwner.isNotEmpty && githubUpdateRepo.isNotEmpty;

  static const applicationIdValue = 'com.gympulse.app';

  factory AppConfig.fromEnvironment() {
    return const AppConfig(
      githubUpdateOwner: String.fromEnvironment('GITHUB_UPDATE_OWNER'),
      githubUpdateRepo: String.fromEnvironment(
        'GITHUB_UPDATE_REPO',
        defaultValue: 'GymPulse',
      ),
      applicationId: applicationIdValue,
      versionName: '0.2.0',
      versionCode: 6,
    );
  }
}
