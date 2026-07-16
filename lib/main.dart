import 'package:mulearn_app/bootstrap.dart';
import 'package:mulearn_app/core/config/flavor_config.dart';

/// Default entrypoint — defaults to the dev flavor for IDE "run" convenience.
///
/// Prefer the flavor-specific entrypoints in real workflows:
///   flutter run --flavor dev  -t lib/main_dev.dart
///   flutter run --flavor prod -t lib/main_prod.dart
void main() => bootstrap(Flavor.dev);
