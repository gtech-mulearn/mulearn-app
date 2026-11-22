import 'package:envied/envied.dart';

part 'env.g.dart';

/// Build-time environment values, baked in via envied code-gen (rules.md §1).
///
/// There is one [Envied] class per flavor, each reading a different `.env.*`
/// file. Do not read `.env` files at runtime — that's what this replaces.
/// [FlavorConfig] selects the right one based on the active flavor.
@Envied(path: '.env.dev', name: 'EnvDev')
abstract class EnvDev {
  @EnviedField(varName: 'API_BASE_URL')
  static const String apiBaseUrl = _EnvDev.apiBaseUrl;

  /// Google OAuth *web* client id used as `serverClientId` on Android, so the
  /// native SDK returns an ID token. Empty until it is issued; Google sign-in
  /// is hidden on Android while it is empty.
  @EnviedField(varName: 'GOOGLE_SERVER_CLIENT_ID', defaultValue: '')
  static const String googleServerClientId = _EnvDev.googleServerClientId;

  /// The μLearn web dashboard, for flows the app hands off (company sign-up).
  @EnviedField(varName: 'DASHBOARD_URL')
  static const String dashboardUrl = _EnvDev.dashboardUrl;

  /// Discord OAuth authorize URL (the dashboard's `NEXT_PUBLIC_DISCORD_AUTH_URL`).
  /// Empty hides Connect Discord.
  @EnviedField(varName: 'DISCORD_AUTH_URL', defaultValue: '')
  static const String discordAuthUrl = _EnvDev.discordAuthUrl;

  /// Firebase client config for push notifications (Firebase console →
  /// Project settings → the Android app `org.mulearn.muapp.dev`). Not secret.
  /// Any empty value turns push off in this flavor; the app still runs.
  @EnviedField(varName: 'FIREBASE_API_KEY', defaultValue: '')
  static const String firebaseApiKey = _EnvDev.firebaseApiKey;
  @EnviedField(varName: 'FIREBASE_APP_ID', defaultValue: '')
  static const String firebaseAppId = _EnvDev.firebaseAppId;
  @EnviedField(varName: 'FIREBASE_MESSAGING_SENDER_ID', defaultValue: '')
  static const String firebaseSenderId = _EnvDev.firebaseSenderId;
  @EnviedField(varName: 'FIREBASE_PROJECT_ID', defaultValue: '')
  static const String firebaseProjectId = _EnvDev.firebaseProjectId;
}

@Envied(path: '.env.prod', name: 'EnvProd')
abstract class EnvProd {
  @EnviedField(varName: 'API_BASE_URL')
  static const String apiBaseUrl = _EnvProd.apiBaseUrl;

  /// See [EnvDev.googleServerClientId].
  @EnviedField(varName: 'GOOGLE_SERVER_CLIENT_ID', defaultValue: '')
  static const String googleServerClientId = _EnvProd.googleServerClientId;

  /// See [EnvDev.dashboardUrl]. Defaults to the production dashboard.
  @EnviedField(
    varName: 'DASHBOARD_URL',
    defaultValue: 'https://app.mulearn.org',
  )
  static const String dashboardUrl = _EnvProd.dashboardUrl;

  /// See [EnvDev.discordAuthUrl]. Empty until the production value is set.
  @EnviedField(varName: 'DISCORD_AUTH_URL', defaultValue: '')
  static const String discordAuthUrl = _EnvProd.discordAuthUrl;

  /// See [EnvDev.firebaseApiKey] (the Android app `org.mulearn.muapp`).
  @EnviedField(varName: 'FIREBASE_API_KEY', defaultValue: '')
  static const String firebaseApiKey = _EnvProd.firebaseApiKey;
  @EnviedField(varName: 'FIREBASE_APP_ID', defaultValue: '')
  static const String firebaseAppId = _EnvProd.firebaseAppId;
  @EnviedField(varName: 'FIREBASE_MESSAGING_SENDER_ID', defaultValue: '')
  static const String firebaseSenderId = _EnvProd.firebaseSenderId;
  @EnviedField(varName: 'FIREBASE_PROJECT_ID', defaultValue: '')
  static const String firebaseProjectId = _EnvProd.firebaseProjectId;
}
