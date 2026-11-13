import 'package:freezed_annotation/freezed_annotation.dart';

part 'mentor_profile_completion.freezed.dart';

/// `GET mentor/profile/completion/`: a percentage and which parts are done
/// (`about`, `expertise`, `linkedin`, `preferred_igs`).
@freezed
abstract class MentorProfileCompletion with _$MentorProfileCompletion {
  const factory MentorProfileCompletion({
    required int percentage,
    required Map<String, bool> checklist,
  }) = _MentorProfileCompletion;
}
