import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_search_org_dto.freezed.dart';
part 'user_search_org_dto.g.dart';

/// Raw `{id, title, code, org_type}` organization shape nested in a search
/// result — confirmed live (rules.md §3/§9).
@freezed
abstract class UserSearchOrgDto with _$UserSearchOrgDto {
  const factory UserSearchOrgDto({
    required String id,
    required String title,
    String? code,
    String? orgType,
  }) = _UserSearchOrgDto;

  factory UserSearchOrgDto.fromJson(Map<String, dynamic> json) =>
      _$UserSearchOrgDtoFromJson(json);
}
