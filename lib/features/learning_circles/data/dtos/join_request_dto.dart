import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/join_request.dart';

part 'join_request_dto.freezed.dart';
part 'join_request_dto.g.dart';

@freezed
abstract class JoinRequestDto with _$JoinRequestDto {
  const factory JoinRequestDto({
    required String linkId,
    required String userId,
    required String fullName,
    required String muid,
    String? profilePic,
    String? requestedAt,
  }) = _JoinRequestDto;

  const JoinRequestDto._();

  factory JoinRequestDto.fromJson(Map<String, dynamic> json) =>
      _$JoinRequestDtoFromJson(json);

  JoinRequest toDomain() => JoinRequest(
        linkId: linkId,
        userId: userId,
        fullName: fullName,
        muid: muid,
        profilePicUrl: profilePic,
        requestedAt: requestedAt,
      );
}
