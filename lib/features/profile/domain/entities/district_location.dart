import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/domain/entities/state_location.dart';

part 'district_location.freezed.dart';

/// The user's district, nested inside its state and country — pure-Dart
/// domain entity (rules.md §2), returned by the "editable profile" GET.
@freezed
abstract class DistrictLocation with _$DistrictLocation {
  const factory DistrictLocation({
    required String id,
    required String name,
    required StateLocation state,
  }) = _DistrictLocation;
}
