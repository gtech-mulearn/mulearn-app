import 'package:dio/dio.dart';
import 'package:mulearn_app/core/data/location_remote_datasource.dart';
import 'package:mulearn_app/core/models/location_option.dart';
import 'package:mulearn_app/core/models/reference_option.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:mulearn_app/features/profile/data/dtos/badges_data_dto.dart';
import 'package:mulearn_app/features/profile/data/dtos/editable_profile_dto.dart';
import 'package:mulearn_app/features/profile/data/dtos/interest_group_list_item_dto.dart';
import 'package:mulearn_app/features/profile/data/dtos/issued_vc_dto.dart';
import 'package:mulearn_app/features/profile/data/dtos/socials_dto.dart';
import 'package:mulearn_app/features/profile/data/dtos/user_achievement_dto.dart';
import 'package:mulearn_app/features/profile/data/dtos/user_level_dto.dart';
import 'package:mulearn_app/features/profile/data/dtos/user_log_entry_dto.dart';
import 'package:mulearn_app/features/profile/data/dtos/user_preferences_dto.dart';
import 'package:mulearn_app/features/profile/data/dtos/user_profile_dto.dart';
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
import 'package:mulearn_app/features/profile/domain/entities/vc_credential_type.dart';
import 'package:mulearn_app/features/profile/domain/entities/vc_subject_info.dart';
import 'package:mulearn_app/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl({
    required ProfileRemoteDataSource remote,
    required LocationRemoteDataSource locationRemote,
  })  : _remote = remote,
        _locationRemote = locationRemote;

  final ProfileRemoteDataSource _remote;
  final LocationRemoteDataSource _locationRemote;

  @override
  Future<UserProfile> getCurrentUserProfile() => _guard(() async {
        final json = await _remote.fetchCurrentUserProfile();
        return UserProfileDto.fromJson(json).toDomain();
      });

  @override
  Future<UserProfile> getPublicUserProfile(String muid) => _guard(() async {
        final json = await _remote.fetchPublicUserProfile(muid);
        return UserProfileDto.fromJson(json).toDomain();
      });

  @override
  Future<List<UserLogEntry>> getPublicUserLog(String muid) => _guard(() async {
        final items = await _remote.fetchPublicUserLog(muid);
        return items
            .cast<Map<String, dynamic>>()
            .map((json) => UserLogEntryDto.fromJson(json).toDomain())
            .toList();
      });

  @override
  Future<List<UserLevel>> getPublicUserLevels(String muid) => _guard(() async {
        final items = await _remote.fetchPublicUserLevels(muid);
        return items
            .cast<Map<String, dynamic>>()
            .map((json) => UserLevelDto.fromJson(json).toDomain())
            .toList();
      });

  @override
  Future<Socials> getPublicSocials(String muid) => _guard(() async {
        final json = await _remote.fetchPublicSocials(muid);
        return SocialsDto.fromJson(json).toDomain();
      });

  @override
  Future<EditableProfile> getEditableProfile() => _guard(() async {
        final json = await _remote.fetchEditableProfile();
        return EditableProfileDto.fromJson(json).toDomain();
      });

  @override
  Future<void> updateProfile({
    String? fullName,
    String? email,
    String? mobile,
    String? gender,
    String? dob,
    String? districtId,
    List<String>? communities,
  }) =>
      _guard(() => _remote.updateProfile({
            if (fullName != null) 'full_name': fullName,
            if (email != null) 'email': email,
            if (mobile != null) 'mobile': mobile,
            if (gender != null) 'gender': gender,
            if (dob != null) 'dob': dob,
            if (districtId != null) 'district_id': districtId,
            if (communities != null) 'communities': communities,
          }));

  @override
  Future<List<UserLogEntry>> getUserLog() => _guard(() async {
        final items = await _remote.fetchUserLog();
        return items
            .cast<Map<String, dynamic>>()
            .map((json) => UserLogEntryDto.fromJson(json).toDomain())
            .toList();
      });

  @override
  Future<List<UserLevel>> getUserLevels() => _guard(() async {
        final items = await _remote.fetchUserLevels();
        return items
            .cast<Map<String, dynamic>>()
            .map((json) => UserLevelDto.fromJson(json).toDomain())
            .toList();
      });

  @override
  Future<Socials> getSocials() => _guard(() async {
        final json = await _remote.fetchSocials();
        return SocialsDto.fromJson(json).toDomain();
      });

  @override
  Future<void> updateSocials(Socials socials) => _guard(() => _remote.updateSocials({
        'github': socials.github,
        'facebook': socials.facebook,
        'instagram': socials.instagram,
        'linkedin': socials.linkedin,
        'dribble': socials.dribble,
        'behance': socials.behance,
        'stackoverflow': socials.stackoverflow,
        'medium': socials.medium,
        'hackerrank': socials.hackerrank,
      }));

  @override
  Future<UserPreferences> getUserPreferences() => _guard(() async {
        final json = await _remote.fetchUserPreferences();
        return UserPreferencesDto.fromJson(json).toDomain();
      });

  @override
  Future<void> updateUserPreferences({
    List<String>? domains,
    List<String>? endgoals,
    bool? interestedInWork,
    bool? interestedInGigWork,
  }) =>
      _guard(() => _remote.updateUserPreferences({
            if (domains != null) 'domains': domains,
            if (endgoals != null) 'endgoals': endgoals,
            if (interestedInWork != null)
              'interested_in_work': interestedInWork,
            if (interestedInGigWork != null)
              'interested_in_gig_work': interestedInGigWork,
          }));

  @override
  Future<List<InterestGroupListItem>> getInterestGroupsList() =>
      _guard(() async {
        final items = await _remote.fetchInterestGroupsList();
        return items
            .cast<Map<String, dynamic>>()
            .map((json) => InterestGroupListItemDto.fromJson(json).toDomain())
            .toList();
      });

  @override
  Future<void> updateInterestGroups(List<String> groupIds) =>
      _guard(() => _remote.updateInterestGroups(groupIds));

  @override
  Future<void> togglePublicProfile({required bool isPublic}) =>
      _guard(() => _remote.togglePublicProfile(isPublic: isPublic));

  @override
  Future<String?> getCoverPic() => _guard(_remote.fetchCoverPic);

  @override
  Future<String?> uploadCoverPic(List<int> bytes, String filename) =>
      _guard(() => _remote.uploadCoverPic(bytes, filename));

  @override
  Future<void> deleteCoverPic() => _guard(_remote.deleteCoverPic);

  @override
  Future<void> updateProfileImage({
    required List<int> bytes,
    required String filename,
    required String userId,
  }) =>
      _guard(() => _remote.updateProfileImage(
            bytes: bytes,
            filename: filename,
            userId: userId,
          ));

  @override
  Future<BadgesData> getBadges(String muid) => _guard(() async {
        final json = await _remote.fetchBadges(muid);
        return BadgesDataDto.fromJson(json).toDomain();
      });

  @override
  Future<List<UserAchievement>> getUserAchievements(String muid) =>
      _guard(() async {
        final items = await _remote.fetchUserAchievements(muid);
        return items
            .cast<Map<String, dynamic>>()
            .map((json) => UserAchievementDto.fromJson(json).toDomain())
            .toList();
      });

  @override
  Future<List<String>> getConnectedDids(String muid) => _guard(() async {
        final items = await _remote.fetchConnectedDids(muid);
        return items.cast<String>();
      });

  @override
  Future<List<IssuedVc>> issueVc({
    required VcSubjectInfo subjectInfo,
    required VcCredentialInfo credentialInfo,
    required String templateId,
  }) =>
      _guard(() async {
        final items = await _remote.issueVc({
          'subject_info': {
            'type': subjectInfo.type.apiValue,
            'did': subjectInfo.did,
            'name': subjectInfo.name,
            if (subjectInfo.email != null) 'email': subjectInfo.email,
          },
          'credential_info': {
            'course_name': credentialInfo.courseName,
            'name': credentialInfo.name,
            'tags': credentialInfo.tags,
            'description': credentialInfo.description,
          },
          'template_id': templateId,
          'send_email': true,
        });
        return items
            .cast<Map<String, dynamic>>()
            .map((json) => IssuedVcDto.fromJson(json).toDomain())
            .toList();
      });

  @override
  Future<void> saveIssuedVcUrl({
    required String achievementId,
    required String vcUrl,
  }) =>
      _guard(() => _remote.saveIssuedVcUrl(
            achievementId: achievementId,
            vcUrl: vcUrl,
          ));

  @override
  Future<List<LocationOption>> getCountries() =>
      _guard(_locationRemote.fetchCountries);

  @override
  Future<List<LocationOption>> getStates(String countryId) =>
      _guard(() => _locationRemote.fetchStates(countryId));

  @override
  Future<List<LocationOption>> getDistricts(String stateId) =>
      _guard(() => _locationRemote.fetchDistricts(stateId));

  @override
  Future<
      ({
        List<ReferenceOption> organizations,
        List<ReferenceOption> departments,
      })> getOrganizationsAndDepartments(String districtId) =>
      _guard(() async {
        final collegesResult =
            await _locationRemote.fetchCollegesByDistrict(districtId);
        final schools =
            await _locationRemote.fetchSchoolsByDistrict(districtId);
        return (
          organizations: [...collegesResult.colleges, ...schools],
          departments: collegesResult.departments,
        );
      });

  @override
  Future<void> changeCollege({
    required String orgId,
    required String departmentId,
  }) =>
      _guard(() => _remote.changeCollege(
            orgId: orgId,
            departmentId: departmentId,
          ));

  @override
  Future<List<ReferenceOption>> getCommunities() =>
      _guard(_locationRemote.fetchCommunities);

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
