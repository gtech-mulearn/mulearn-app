import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/core/models/reference_option_dto.dart';
import 'package:mulearn_app/features/profile/data/dtos/district_location_dto.dart';
import 'package:mulearn_app/features/profile/domain/entities/editable_profile.dart';

part 'editable_profile_dto.freezed.dart';
part 'editable_profile_dto.g.dart';

/// Raw API shape confirmed against a real `GET /api/v1/dashboard/profile/`
/// response (rules.md §3/§9) — the same path used for the PATCH update, a
/// different verb. `department` is `{id, title}` from the user's college
/// link, or null; this is the only profile endpoint that returns it.
@freezed
abstract class EditableProfileDto with _$EditableProfileDto {
  const factory EditableProfileDto({
    String? fullName,
    String? email,
    String? mobile,
    String? gender,
    String? dob,
    DistrictLocationDto? district,
    @Default([]) List<String> communities,
    ReferenceOptionDto? department,
  }) = _EditableProfileDto;

  const EditableProfileDto._();

  factory EditableProfileDto.fromJson(Map<String, dynamic> json) =>
      _$EditableProfileDtoFromJson(json);

  EditableProfile toDomain() => EditableProfile(
        fullName: fullName ?? '',
        email: email ?? '',
        mobile: mobile ?? '',
        gender: gender ?? '',
        dob: dob ?? '',
        district: district?.toDomain(),
        communities: communities,
        department: department?.toDomain(),
      );
}
