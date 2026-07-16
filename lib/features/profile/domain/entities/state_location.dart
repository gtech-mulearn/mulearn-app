import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/domain/entities/country_location.dart';

part 'state_location.freezed.dart';

/// A `{id, name, country}` state reference nested inside [DistrictLocation] —
/// pure-Dart domain entity (rules.md §2).
@freezed
abstract class StateLocation with _$StateLocation {
  const factory StateLocation({
    required String id,
    required String name,
    required CountryLocation country,
  }) = _StateLocation;
}
