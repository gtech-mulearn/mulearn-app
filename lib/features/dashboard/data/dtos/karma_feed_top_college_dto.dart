import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/karma_feed_top_college.dart';

part 'karma_feed_top_college_dto.freezed.dart';
part 'karma_feed_top_college_dto.g.dart';

@freezed
abstract class KarmaFeedTopCollegeDto with _$KarmaFeedTopCollegeDto {
  const factory KarmaFeedTopCollegeDto({
    required String name,
    required num karma,
  }) = _KarmaFeedTopCollegeDto;

  const KarmaFeedTopCollegeDto._();

  factory KarmaFeedTopCollegeDto.fromJson(Map<String, dynamic> json) =>
      _$KarmaFeedTopCollegeDtoFromJson(json);

  KarmaFeedTopCollege toDomain() =>
      KarmaFeedTopCollege(name: name, karma: karma);
}
