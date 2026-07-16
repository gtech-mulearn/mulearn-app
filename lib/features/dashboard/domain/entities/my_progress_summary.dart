import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_progress_summary.freezed.dart';

/// A minimal projection of the signed-in user's own progress, for the home
/// dashboard's summary card — pure-Dart domain entity (rules.md §2).
///
/// Deliberately separate from `features/profile`'s richer `UserProfile`:
/// `features/dashboard` and `features/profile` must not import each other
/// (rules.md §2), so this feature fetches its own minimal read model from
/// the same `GET /api/v1/dashboard/profile/user-profile/` endpoint rather
/// than reaching into the profile feature's domain/presentation layers.
@freezed
abstract class MyProgressSummary with _$MyProgressSummary {
  const factory MyProgressSummary({
    required String fullName,
    required String muid,
    required int karma,
    String? level,
    String? profilePicUrl,
    int? rank,
    double? percentile,
  }) = _MyProgressSummary;
}
