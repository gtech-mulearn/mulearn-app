import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/data/dtos/interest_group_dto.dart';
import 'package:mulearn_app/features/profile/data/dtos/karma_distribution_entry_dto.dart';
import 'package:mulearn_app/features/profile/data/dtos/role_verification_dto.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_profile.dart';

part 'user_profile_dto.freezed.dart';
part 'user_profile_dto.g.dart';

/// Raw API shape of the `response` payload from
/// `GET /api/v1/dashboard/profile/user-profile/`.
///
/// Field types confirmed directly against a real response (rules.md §3/§9) —
/// `roles`/`interest_groups`/`role_verification`/`karma_distribution` are
/// arrays (`interest_groups` is an array of objects), and `karma`/`rank` are
/// numeric, not the nullable `String` guesses this project originally
/// shipped with (which crashed parsing for any account with an actual role
/// assigned). `karma`/`rank`/`percentile` are typed `num` — the reference
/// dashboard's own schema coerces these defensively (`z.coerce.number()`),
/// suggesting the backend isn't always strictly consistent about int vs
/// double.
@freezed
abstract class UserProfileDto with _$UserProfileDto {
  // Field names are auto-mapped to snake_case (see build.yaml).
  const factory UserProfileDto({
    required String id,
    required String fullName,
    required String muid,
    required String joined,
    String? email,
    String? mobile,
    String? gender,
    String? level,
    String? profilePic,
    String? coverPic,
    String? collegeCode,
    String? collegeId,
    String? departmentId,
    String? departmentName,
    String? orgDistrictId,
    bool? isPublic,
    num? karma,
    num? rank,
    num? percentile,
    @Default([]) List<String> roles,
    @Default([]) List<RoleVerificationDto> roleVerification,
    bool? isVerified,
    bool? leadEnablerVerified,
    @Default([]) List<InterestGroupDto> interestGroups,
    @Default([]) List<KarmaDistributionEntryDto> karmaDistribution,
  }) = _UserProfileDto;

  const UserProfileDto._();

  factory UserProfileDto.fromJson(Map<String, dynamic> json) =>
      _$UserProfileDtoFromJson(json);

  /// Maps to the domain entity. This mapper is the single place a backend
  /// field rename must be handled (rules.md §2) — the UI never sees this DTO.
  UserProfile toDomain() => UserProfile(
        id: id,
        fullName: fullName,
        muid: muid,
        joined: joined,
        email: email,
        mobile: mobile,
        gender: gender,
        karma: karma?.toInt() ?? 0,
        isPublic: isPublic ?? false,
        level: level,
        profilePicUrl: profilePic,
        coverPicUrl: coverPic,
        collegeCode: collegeCode,
        collegeId: collegeId,
        departmentId: departmentId,
        departmentName: departmentName,
        orgDistrictId: orgDistrictId,
        rank: rank?.toInt(),
        percentile: percentile?.toDouble(),
        roles: roles,
        roleVerification: roleVerification.map((r) => r.toDomain()).toList(),
        isVerified: isVerified,
        leadEnablerVerified: leadEnablerVerified,
        interestGroups: interestGroups
            .where((g) => g.selected ?? true)
            .map((g) => g.toDomain())
            .toList(),
        karmaDistribution:
            karmaDistribution.map((k) => k.toDomain()).toList(),
      );
}
