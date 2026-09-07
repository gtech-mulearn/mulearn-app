import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_paths.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_user_rank_summary.g.dart';

/// The signed-in user's own leaderboard standing — just `{rank, karma,
/// percentile}`, not a full profile. Lives in `core/` (rules.md §2) for the
/// same reason [currentUserCollege] does: `leaderboard`'s once-a-day rank
/// popup needs "what's my rank" without importing `features/profile`'s
/// domain layer. Thin, independent hit to the same real `user-profile`
/// endpoint `features/profile` also calls — `rank`/`karma`/`percentile` are
/// confirmed numeric top-level fields there (see `UserProfile`'s own doc
/// comment, rules.md §3/§9).
@riverpod
Future<({int? rank, int karma, double? percentile})> currentUserRankSummary(
  Ref ref,
) async {
  final response =
      await ref.watch(dioProvider).get<dynamic>(ApiPaths.userProfile);
  final json = ApiEnvelope.unwrapObject(response);
  return (
    rank: json['rank'] as int?,
    karma: (json['karma'] as num?)?.toInt() ?? 0,
    percentile: (json['percentile'] as num?)?.toDouble(),
  );
}
