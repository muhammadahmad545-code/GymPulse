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

  static const applicationIdValue = 'com.mrgym.app';

  factory AppConfig.fromEnvironment() {
    return const AppConfig(
      githubUpdateOwner: String.fromEnvironment('GITHUB_UPDATE_OWNER'),
      githubUpdateRepo: String.fromEnvironment(
        'GITHUB_UPDATE_REPO',
        defaultValue: 'Mr-Gym',
      ),
      applicationId: applicationIdValue,
      versionName: '1.1.0',
      versionCode: 9,
    );
  }
}
