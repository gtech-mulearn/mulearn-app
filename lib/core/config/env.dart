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
}

@Envied(path: '.env.prod', name: 'EnvProd')
abstract class EnvProd {
  @EnviedField(varName: 'API_BASE_URL')
  static const String apiBaseUrl = _EnvProd.apiBaseUrl;
}
