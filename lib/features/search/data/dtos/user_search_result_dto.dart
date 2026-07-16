import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/search/data/dtos/user_search_ig_dto.dart';
import 'package:mulearn_app/features/search/data/dtos/user_search_org_dto.dart';
import 'package:mulearn_app/features/search/domain/entities/user_search_result.dart';

part 'user_search_result_dto.freezed.dart';
part 'user_search_result_dto.g.dart';

/// Raw shape of a `GET /api/v1/dashboard/user/search/` result item —
/// confirmed live (rules.md §3/§9). `karma` is a **string** on the wire,
/// unlike every other karma field in this app (which are numeric) — kept
/// as `String?` here and parsed defensively in [toDomain].
@freezed
abstract class UserSearchResultDto with _$UserSearchResultDto {
  const factory UserSearchResultDto({
    required String id,
    required String muid,
    required String fullName,
    String? karma,
    String? profilePic,
    @Default([]) List<UserSearchIgDto> interestGroups,
    @Default([]) List<UserSearchOrgDto> organizations,
  }) = _UserSearchResultDto;

  const UserSearchResultDto._();

  factory UserSearchResultDto.fromJson(Map<String, dynamic> json) =>
      _$UserSearchResultDtoFromJson(json);

  UserSearchResult toDomain() => UserSearchResult(
        id: id,
        muid: muid,
        fullName: fullName,
        karma: int.tryParse(karma ?? '') ?? 0,
        profilePicUrl: profilePic,
        organization: organizations.firstOrNull?.title,
        interestGroupNames: interestGroups.map((g) => g.name).toList(),
      );
}
