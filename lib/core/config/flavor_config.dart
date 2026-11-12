import 'package:mulearn_app/core/config/env.dart';

/// Build flavors. Wired to the Dart entrypoints (`main_dev.dart`/`main_prod.dart`)
/// and the Android product flavors of the same name.
enum Flavor { dev, prod }

/// Immutable, globally-readable description of the running flavor.
///
/// Set exactly once during bootstrap via [FlavorConfig.initialize]. Everything
/// downstream (Dio base URL, logging verbosity, etc.) reads from here rather
/// than referencing [Flavor] directly, so there's a single source of truth.
class FlavorConfig {
  const FlavorConfig._({
    required this.flavor,
    required this.apiBaseUrl,
    required this.googleServerClientId,
  });

  final Flavor flavor;
  final String apiBaseUrl;

  /// Google OAuth web client id for Android's `serverClientId`; may be empty.
  final String googleServerClientId;

  static FlavorConfig? _instance;

  static FlavorConfig get instance {
    final instance = _instance;
    if (instance == null) {
      throw StateError(
        'FlavorConfig.initialize() must be called before accessing instance. '
        'This normally happens in bootstrap().',
      );
    }
    return instance;
  }

  static bool get isInitialized => _instance != null;

  static FlavorConfig initialize(Flavor flavor) {
    final config = FlavorConfig._(
      flavor: flavor,
      apiBaseUrl: switch (flavor) {
        Flavor.dev => EnvDev.apiBaseUrl,
        Flavor.prod => EnvProd.apiBaseUrl,
      },
      googleServerClientId: switch (flavor) {
        Flavor.dev => EnvDev.googleServerClientId,
        Flavor.prod => EnvProd.googleServerClientId,
      },
    );
    return _instance = config;
  }

  bool get isDev => flavor == Flavor.dev;
  bool get isProd => flavor == Flavor.prod;
}
