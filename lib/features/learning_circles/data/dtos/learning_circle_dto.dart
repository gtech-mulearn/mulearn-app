import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/learning_circle.dart';

part 'learning_circle_dto.freezed.dart';
part 'learning_circle_dto.g.dart';

/// `ig`/`title` are nullable despite always being populated in the sampled
/// catalog rows: this parses every row in a list eagerly, so one record
/// with a null field (e.g. a circle whose backing interest group was
/// deleted) would otherwise throw and take down the whole list — this was
/// confirmed live as the actual cause of "My Circles" showing "Something
/// went wrong" (rules.md §3/§9).
///
/// `id` needs the `circle_id`-vs-`id` normalization below: confirmed live,
/// `/learningcircle/list/`'s rows key the identifier `id`, but
/// `/user-circles/`'s rows key it `circle_id` instead — same entity, two
/// endpoints, two different field names for the same value (rules.md §3:
/// "spec is not always literal"). Without this, every `/user-circles/` row
/// parsed with a null `id` and silently vanished from "My Circles" via
/// [LearningCirclesRepositoryImpl._parseSkippingErrors]'s defensive skip.
@freezed
abstract class LearningCircleDto with _$LearningCircleDto {
  const factory LearningCircleDto({
    required String id,
    String? ig,
    String? title,
    int? totalMembers,
    String? org,
  }) = _LearningCircleDto;

  const LearningCircleDto._();

  factory LearningCircleDto.fromJson(Map<String, dynamic> json) =>
      _$LearningCircleDtoFromJson({
        ...json,
        'id': json['id'] ?? json['circle_id'],
      });

  LearningCircle toDomain() => LearningCircle(
        id: id,
        ig: ig ?? 'Unknown',
        title: title ?? '(untitled circle)',
        totalMembers: totalMembers ?? 0,
        org: org,
      );
}
