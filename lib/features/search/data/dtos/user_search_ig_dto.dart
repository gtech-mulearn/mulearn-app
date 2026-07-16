import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_search_ig_dto.freezed.dart';
part 'user_search_ig_dto.g.dart';

/// Raw `{id, name}` interest-group shape nested in a search result —
/// confirmed live (rules.md §3/§9).
@freezed
abstract class UserSearchIgDto with _$UserSearchIgDto {
  const factory UserSearchIgDto({
    required String id,
    required String name,
  }) = _UserSearchIgDto;

  factory UserSearchIgDto.fromJson(Map<String, dynamic> json) =>
      _$UserSearchIgDtoFromJson(json);
}
