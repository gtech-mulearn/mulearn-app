import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/learning_circles/data/dtos/circle_member_dto.dart';
import 'package:mulearn_app/features/learning_circles/data/dtos/circle_user_ref_dto.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/circle_members.dart';

part 'circle_members_dto.freezed.dart';
part 'circle_members_dto.g.dart';

@freezed
abstract class CircleMembersDto with _$CircleMembersDto {
  const factory CircleMembersDto({
    List<CircleMemberDto>? members,
    CircleUserRefDto? owner,
  }) = _CircleMembersDto;

  const CircleMembersDto._();

  factory CircleMembersDto.fromJson(Map<String, dynamic> json) =>
      _$CircleMembersDtoFromJson(json);

  CircleMembers toDomain() => CircleMembers(
        members: (members ?? const []).map((m) => m.toDomain()).toList(),
        owner: owner?.toDomain(),
      );
}
