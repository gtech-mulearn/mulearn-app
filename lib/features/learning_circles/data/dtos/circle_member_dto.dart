import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/circle_member.dart';

part 'circle_member_dto.freezed.dart';
part 'circle_member_dto.g.dart';

@freezed
abstract class CircleMemberDto with _$CircleMemberDto {
  const factory CircleMemberDto({
    required String id,
    required String muid,
    String? fullName,
    String? profilePic,
    int? igKarma,
    @Default(false) bool isLeader,
  }) = _CircleMemberDto;

  const CircleMemberDto._();

  factory CircleMemberDto.fromJson(Map<String, dynamic> json) =>
      _$CircleMemberDtoFromJson(json);

  CircleMember toDomain() => CircleMember(
        id: id,
        fullName: fullName ?? muid,
        muid: muid,
        profilePicUrl: profilePic,
        igKarma: igKarma,
        isLeader: isLeader,
      );
}
