import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/dashboard/data/dtos/karma_feed_top_college_dto.dart';
import 'package:mulearn_app/features/dashboard/data/dtos/karma_feed_top_user_dto.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/karma_feed.dart';

part 'karma_feed_dto.freezed.dart';
part 'karma_feed_dto.g.dart';

@freezed
abstract class KarmaFeedDto with _$KarmaFeedDto {
  const factory KarmaFeedDto({
    KarmaFeedTopUserDto? topUser,
    KarmaFeedTopCollegeDto? topCollege,
  }) = _KarmaFeedDto;

  const KarmaFeedDto._();

  factory KarmaFeedDto.fromJson(Map<String, dynamic> json) =>
      _$KarmaFeedDtoFromJson(json);

  KarmaFeed toDomain() => KarmaFeed(
        topUser: topUser?.toDomain(),
        topCollege: topCollege?.toDomain(),
      );
}
