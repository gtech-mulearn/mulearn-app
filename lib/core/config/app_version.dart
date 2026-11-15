import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_version.g.dart';

/// The installed build, as the platform reports it. `pubspec.yaml`'s
/// `version: MAJOR.MINOR.PATCH+BUILD` is the source; CI stamps the channel
/// into the name (`1.0.0-dev.84`, `1.0.0-nightly.20261115`, plain `1.0.0`
/// for a release) and the build number is the Android versionCode. See
/// docs/CI-CD.md "Versioning".
class AppVersion {
  const AppVersion({required this.name, required this.build});

  /// versionName, e.g. `1.0.0` or `1.0.0-dev.84`.
  final String name;

  /// versionCode, e.g. `84`.
  final String build;

  /// What support needs: `1.0.0-dev.84 (84)`.
  String get label => build.isEmpty ? name : '$name ($build)';
}

/// Read once per launch.
@Riverpod(keepAlive: true)
Future<AppVersion> appVersion(Ref ref) async {
  final info = await PackageInfo.fromPlatform();
  return AppVersion(name: info.version, build: info.buildNumber);
}
