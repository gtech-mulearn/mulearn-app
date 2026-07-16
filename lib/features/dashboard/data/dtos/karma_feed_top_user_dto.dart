import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/karma_feed_top_user.dart';

part 'karma_feed_top_user_dto.freezed.dart';
part 'karma_feed_top_user_dto.g.dart';

@freezed
abstract class KarmaFeedTopUserDto with _$KarmaFeedTopUserDto {
  const factory KarmaFeedTopUserDto({
    required String fullName,
    required String muid,
    required num karma,
  }) = _KarmaFeedTopUserDto;

  const KarmaFeedTopUserDto._();

  factory KarmaFeedTopUserDto.fromJson(Map<String, dynamic> json) =>
      _$KarmaFeedTopUserDtoFromJson(json);

  KarmaFeedTopUser toDomain() =>
      KarmaFeedTopUser(fullName: fullName, muid: muid, karma: karma);
}
