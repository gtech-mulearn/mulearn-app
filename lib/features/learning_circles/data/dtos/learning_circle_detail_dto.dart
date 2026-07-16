import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/learning_circles/data/dtos/circle_user_ref_dto.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/learning_circle_detail.dart';

part 'learning_circle_detail_dto.freezed.dart';
part 'learning_circle_detail_dto.g.dart';

/// `next_meetup` is either `null`, or an object whose only fields this app
/// reads are `is_scheduled`/`meet_time` — the backend passes through extra
/// meeting fields when `is_scheduled` is true, which this app doesn't need
/// (the meeting itself is fetched in full via the meetings list instead).
@freezed
abstract class LearningCircleDetailDto with _$LearningCircleDetailDto {
  const factory LearningCircleDetailDto({
    required String id,
    required String ig,
    required String title,
    required CircleUserRefDto createdBy,
    @Default('') String description,
    String? org,
    @Default(false) bool isRecurring,
    int? rank,
    int? totalKarma,
    int? totalMembers,
    Map<String, dynamic>? nextMeetup,
  }) = _LearningCircleDetailDto;

  const LearningCircleDetailDto._();

  factory LearningCircleDetailDto.fromJson(Map<String, dynamic> json) =>
      _$LearningCircleDetailDtoFromJson(json);

  LearningCircleDetail toDomain() => LearningCircleDetail(
        id: id,
        ig: ig,
        title: title,
        description: description,
        createdBy: createdBy.toDomain(),
        org: org,
        isRecurring: isRecurring,
        rank: rank,
        totalKarma: totalKarma,
        totalMembers: totalMembers,
        nextMeetupScheduled: nextMeetup?['is_scheduled'] as bool?,
        nextMeetupTime: nextMeetup?['meet_time'] as String?,
      );
}
