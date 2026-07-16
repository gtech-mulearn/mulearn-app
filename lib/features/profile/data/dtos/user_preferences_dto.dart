import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/data/dtos/org_ref_dto.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_preferences.dart';

part 'user_preferences_dto.freezed.dart';
part 'user_preferences_dto.g.dart';

/// Raw API shape confirmed against a real
/// `GET /api/v1/dashboard/user/preferences/` response (rules.md §3/§9):
/// `domains`/`endgoals`/`orgs` are absent (not empty arrays) for accounts
/// that haven't set them.
@freezed
abstract class UserPreferencesDto with _$UserPreferencesDto {
  const factory UserPreferencesDto({
    required bool interestedInWork,
    required bool interestedInGigWork,
    List<String>? domains,
    List<String>? endgoals,
    List<OrgRefDto>? orgs,
  }) = _UserPreferencesDto;

  const UserPreferencesDto._();

  factory UserPreferencesDto.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesDtoFromJson(json);

  UserPreferences toDomain() => UserPreferences(
        interestedInWork: interestedInWork,
        interestedInGigWork: interestedInGigWork,
        domains: domains,
        endgoals: endgoals,
        orgs: orgs?.map((o) => o.toDomain()).toList(),
      );
}
