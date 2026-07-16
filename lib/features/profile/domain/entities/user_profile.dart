import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/domain/entities/interest_group.dart';
import 'package:mulearn_app/features/profile/domain/entities/karma_distribution_entry.dart';
import 'package:mulearn_app/features/profile/domain/entities/role_verification.dart';

part 'user_profile.freezed.dart';

/// User profile — pure-Dart domain entity (rules.md §2).
///
/// Field shapes confirmed directly against a real
/// `GET /api/v1/dashboard/profile/user-profile/` response (rules.md §3/§9):
/// `roles`/`interest_groups`/`karma_distribution` are arrays (`interest_groups`
/// is an array of objects, not strings), `rank`/`karma`/`percentile` are
/// numeric.
@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    required String fullName,
    required String muid,
    required int karma,
    required bool isPublic,
    required String joined,
    String? email,
    String? mobile,
    String? gender,
    String? level,
    String? profilePicUrl,
    String? coverPicUrl,
    String? collegeCode,
    String? collegeId,
    String? departmentId,
    String? departmentName,
    String? orgDistrictId,
    int? rank,
    double? percentile,
    @Default([]) List<String> roles,
    @Default([]) List<RoleVerification> roleVerification,
    bool? isVerified,
    bool? leadEnablerVerified,
    @Default([]) List<InterestGroup> interestGroups,
    @Default([]) List<KarmaDistributionEntry> karmaDistribution,
  }) = _UserProfile;
}
