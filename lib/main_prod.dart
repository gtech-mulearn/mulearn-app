import 'package:mulearn_app/bootstrap.dart';
import 'package:mulearn_app/core/config/flavor_config.dart';

/// Prod flavor entrypoint: `flutter run --flavor prod -t lib/main_prod.dart`.
void main() => bootstrap(Flavor.prod);
