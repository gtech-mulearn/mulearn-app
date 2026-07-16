import 'package:mulearn_app/core/models/location_option.dart';
import 'package:mulearn_app/core/models/reference_option.dart';
import 'package:mulearn_app/features/profile/domain/entities/badges_data.dart';
import 'package:mulearn_app/features/profile/domain/entities/editable_profile.dart';
import 'package:mulearn_app/features/profile/domain/entities/interest_group_list_item.dart';
import 'package:mulearn_app/features/profile/domain/entities/issued_vc.dart';
import 'package:mulearn_app/features/profile/domain/entities/socials.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_achievement.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_level.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_log_entry.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_preferences.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_profile.dart';
import 'package:mulearn_app/features/profile/domain/entities/vc_credential_info.dart';
import 'package:mulearn_app/features/profile/domain/entities/vc_subject_info.dart';

/// Profile repository contract (rules.md §2/§5). Every method throws
/// [ApiException] on failure.
abstract interface class ProfileRepository {
  /// `GET /api/v1/dashboard/profile/user-profile/`.
  Future<UserProfile> getCurrentUserProfile();

  /// `GET /api/v1/dashboard/profile/user-profile/{muid}/`.
  Future<UserProfile> getPublicUserProfile(String muid);

  /// `GET /api/v1/dashboard/profile/user-log/{muid}/`.
  Future<List<UserLogEntry>> getPublicUserLog(String muid);

  /// `GET /api/v1/dashboard/profile/get-user-levels/{muid}/`.
  Future<List<UserLevel>> getPublicUserLevels(String muid);

  /// `GET /api/v1/dashboard/profile/socials/{muid}/`.
  Future<Socials> getPublicSocials(String muid);

  /// `GET /api/v1/dashboard/profile/` — pre-fill payload for the edit form.
  Future<EditableProfile> getEditableProfile();

  /// `PATCH /api/v1/dashboard/profile/` — partial update; only non-null
  /// fields are sent.
  Future<void> updateProfile({
    String? fullName,
    String? email,
    String? mobile,
    String? gender,
    String? dob,
    String? districtId,
    List<String>? communities,
  });

  /// `GET /api/v1/dashboard/profile/user-log/`.
  Future<List<UserLogEntry>> getUserLog();

  /// `GET /api/v1/dashboard/profile/get-user-levels/`.
  Future<List<UserLevel>> getUserLevels();

  /// `GET /api/v1/dashboard/profile/socials/`.
  Future<Socials> getSocials();

  /// `PUT /api/v1/dashboard/profile/socials/edit/` — full replace.
  Future<void> updateSocials(Socials socials);

  /// `GET /api/v1/dashboard/user/preferences/`.
  Future<UserPreferences> getUserPreferences();

  /// `PATCH /api/v1/dashboard/user/preferences/`.
  Future<void> updateUserPreferences({
    List<String>? domains,
    List<String>? endgoals,
    bool? interestedInWork,
    bool? interestedInGigWork,
  });

  /// `GET /api/v1/dashboard/ig/list/` — the full interest-group catalog.
  Future<List<InterestGroupListItem>> getInterestGroupsList();

  /// `PATCH /api/v1/dashboard/profile/ig-edit/` `{"interest_group": ids}`.
  Future<void> updateInterestGroups(List<String> groupIds);

  /// `PUT /api/v1/dashboard/profile/share-user-profile/` `{"is_public"}`.
  Future<void> togglePublicProfile({required bool isPublic});

  /// `GET /api/v1/dashboard/profile/cover-pic/` — null if none uploaded.
  Future<String?> getCoverPic();

  /// `POST /api/v1/dashboard/profile/cover-pic/` (multipart, field `cover`).
  /// Returns the new cover URL.
  Future<String?> uploadCoverPic(List<int> bytes, String filename);

  /// `DELETE /api/v1/dashboard/profile/cover-pic/`.
  Future<void> deleteCoverPic();

  /// `POST /api/v1/dashboard/user/profile/update/` (multipart, fields
  /// `profile` + `user_id`).
  Future<void> updateProfileImage({
    required List<int> bytes,
    required String filename,
    required String userId,
  });

  /// `GET /api/v1/dashboard/profile/badges/{muid}`.
  Future<BadgesData> getBadges(String muid);

  /// `GET /api/v1/dashboard/achievement/list/user/{muid}/`.
  Future<List<UserAchievement>> getUserAchievements(String muid);

  /// `GET` connected QSeverse DIDs for [muid].
  Future<List<String>> getConnectedDids(String muid);

  /// `POST` the external QSeverse issuance call.
  Future<List<IssuedVc>> issueVc({
    required VcSubjectInfo subjectInfo,
    required VcCredentialInfo credentialInfo,
    required String templateId,
  });

  /// `POST /api/v1/dashboard/achievement/issue-vc/` — persists the VC URL
  /// against the achievement after [issueVc] succeeds.
  Future<void> saveIssuedVcUrl({
    required String achievementId,
    required String vcUrl,
  });

  // --- College change (country/state/district/college/department pickers)
  // ---

  /// `GET /api/v1/register/country/list/`.
  Future<List<LocationOption>> getCountries();

  /// `POST /api/v1/register/state/list/` `{"country"}`.
  Future<List<LocationOption>> getStates(String countryId);

  /// `POST /api/v1/register/district/list/` `{"state"}`.
  Future<List<LocationOption>> getDistricts(String stateId);

  /// `POST /api/v1/register/college/list/` + `.../schools/list/` `{"district"}`
  /// merged — colleges and schools share one dropdown in the reference UI.
  Future<
      ({
        List<ReferenceOption> organizations,
        List<ReferenceOption> departments,
      })> getOrganizationsAndDepartments(String districtId);

  /// `PATCH /api/v1/dashboard/college/change-college/` `{"org_id",
  /// "department_id"}`.
  Future<void> changeCollege({
    required String orgId,
    required String departmentId,
  });

  /// `GET /api/v1/register/community/list/`.
  Future<List<ReferenceOption>> getCommunities();
}
