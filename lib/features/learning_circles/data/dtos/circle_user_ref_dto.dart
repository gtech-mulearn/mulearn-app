import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/circle_user_ref.dart';

part 'circle_user_ref_dto.freezed.dart';
part 'circle_user_ref_dto.g.dart';

@freezed
abstract class CircleUserRefDto with _$CircleUserRefDto {
  const factory CircleUserRefDto({
    String? fullName,
    String? id,
    String? muid,
    String? profilePic,
  }) = _CircleUserRefDto;

  const CircleUserRefDto._();

  factory CircleUserRefDto.fromJson(Map<String, dynamic> json) =>
      _$CircleUserRefDtoFromJson(json);

  CircleUserRef toDomain() => CircleUserRef(
        fullName: fullName ?? muid ?? 'Unknown',
        id: id,
        muid: muid,
        profilePicUrl: profilePic,
      );
}
