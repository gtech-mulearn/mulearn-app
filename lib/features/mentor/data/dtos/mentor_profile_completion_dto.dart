import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_profile_completion.dart';

part 'mentor_profile_completion_dto.freezed.dart';
part 'mentor_profile_completion_dto.g.dart';

/// `GET mentor/profile/completion/` (`MentorProfileCompletionAPI`).
@freezed
abstract class MentorProfileCompletionDto with _$MentorProfileCompletionDto {
  const factory MentorProfileCompletionDto({
    @Default(0) int percentage,
    @Default(<String, dynamic>{}) Map<String, dynamic> checklist,
  }) = _MentorProfileCompletionDto;

  const MentorProfileCompletionDto._();

  factory MentorProfileCompletionDto.fromJson(Map<String, dynamic> json) =>
      _$MentorProfileCompletionDtoFromJson(json);

  MentorProfileCompletion toDomain() => MentorProfileCompletion(
        percentage: percentage,
        checklist: {
          for (final e in checklist.entries)
            if (e.value is bool) e.key: e.value as bool,
        },
      );
}
