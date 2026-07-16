import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/domain/entities/interest_group_list_item.dart';

part 'interest_group_list_item_dto.freezed.dart';
part 'interest_group_list_item_dto.g.dart';

@freezed
abstract class InterestGroupListItemDto with _$InterestGroupListItemDto {
  const factory InterestGroupListItemDto({
    required String id,
    required String name,
    String? category,
  }) = _InterestGroupListItemDto;

  const InterestGroupListItemDto._();

  factory InterestGroupListItemDto.fromJson(Map<String, dynamic> json) =>
      _$InterestGroupListItemDtoFromJson(json);

  InterestGroupListItem toDomain() =>
      InterestGroupListItem(id: id, name: name, category: category);
}
