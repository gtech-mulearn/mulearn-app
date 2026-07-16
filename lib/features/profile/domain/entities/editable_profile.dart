import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/domain/entities/district_location.dart';

part 'editable_profile.freezed.dart';

/// The pre-fill data for the edit-profile form — pure-Dart domain entity
/// (rules.md §2), returned by `GET /api/v1/dashboard/profile/` (the same
/// path used for the PATCH update, different verb).
@freezed
abstract class EditableProfile with _$EditableProfile {
  const factory EditableProfile({
    required String fullName,
    required String email,
    required String mobile,
    required String gender,
    required String dob,
    DistrictLocation? district,
    @Default([]) List<String> communities,
  }) = _EditableProfile;
}
