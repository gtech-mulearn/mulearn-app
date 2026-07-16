import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/my_progress_summary.dart';

part 'my_progress_summary_dto.freezed.dart';
part 'my_progress_summary_dto.g.dart';

/// Raw shape of `GET /api/v1/dashboard/profile/user-profile/`'s `response`,
/// projected down to the fields the home summary card needs. `karma`/`rank`/
/// `percentile` are typed `num` — confirmed live as numeric, matching
/// `features/profile`'s `UserProfileDto` (rules.md §3/§9).
@freezed
abstract class MyProgressSummaryDto with _$MyProgressSummaryDto {
  const factory MyProgressSummaryDto({
    required String fullName,
    required String muid,
    num? karma,
    String? level,
    String? profilePic,
    num? rank,
    num? percentile,
  }) = _MyProgressSummaryDto;

  const MyProgressSummaryDto._();

  factory MyProgressSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$MyProgressSummaryDtoFromJson(json);

  MyProgressSummary toDomain() => MyProgressSummary(
        fullName: fullName,
        muid: muid,
        karma: karma?.toInt() ?? 0,
        level: level,
        profilePicUrl: profilePic,
        rank: rank?.toInt(),
        percentile: percentile?.toDouble(),
      );
}
