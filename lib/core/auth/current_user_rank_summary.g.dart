// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_user_rank_summary.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The signed-in user's own leaderboard standing — just `{rank, karma,
/// percentile}`, not a full profile. Lives in `core/` (rules.md §2) for the
/// same reason [currentUserCollege] does: `leaderboard`'s once-a-day rank
/// popup needs "what's my rank" without importing `features/profile`'s
/// domain layer. Thin, independent hit to the same real `user-profile`
/// endpoint `features/profile` also calls — `rank`/`karma`/`percentile` are
/// confirmed numeric top-level fields there (see `UserProfile`'s own doc
/// comment, rules.md §3/§9).

@ProviderFor(currentUserRankSummary)
const currentUserRankSummaryProvider = CurrentUserRankSummaryProvider._();

/// The signed-in user's own leaderboard standing — just `{rank, karma,
/// percentile}`, not a full profile. Lives in `core/` (rules.md §2) for the
/// same reason [currentUserCollege] does: `leaderboard`'s once-a-day rank
/// popup needs "what's my rank" without importing `features/profile`'s
/// domain layer. Thin, independent hit to the same real `user-profile`
/// endpoint `features/profile` also calls — `rank`/`karma`/`percentile` are
/// confirmed numeric top-level fields there (see `UserProfile`'s own doc
/// comment, rules.md §3/§9).

final class CurrentUserRankSummaryProvider
    extends
        $FunctionalProvider<
          AsyncValue<({int karma, double? percentile, int? rank})>,
          ({int karma, double? percentile, int? rank}),
          FutureOr<({int karma, double? percentile, int? rank})>
        >
    with
        $FutureModifier<({int karma, double? percentile, int? rank})>,
        $FutureProvider<({int karma, double? percentile, int? rank})> {
  /// The signed-in user's own leaderboard standing — just `{rank, karma,
  /// percentile}`, not a full profile. Lives in `core/` (rules.md §2) for the
  /// same reason [currentUserCollege] does: `leaderboard`'s once-a-day rank
  /// popup needs "what's my rank" without importing `features/profile`'s
  /// domain layer. Thin, independent hit to the same real `user-profile`
  /// endpoint `features/profile` also calls — `rank`/`karma`/`percentile` are
  /// confirmed numeric top-level fields there (see `UserProfile`'s own doc
  /// comment, rules.md §3/§9).
  const CurrentUserRankSummaryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserRankSummaryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserRankSummaryHash();

  @$internal
  @override
  $FutureProviderElement<({int karma, double? percentile, int? rank})>
  $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<({int karma, double? percentile, int? rank})> create(Ref ref) {
    return currentUserRankSummary(ref);
  }
}

String _$currentUserRankSummaryHash() =>
    r'009b4fcfcbdf5e2b57fd58c2b02b8078cfcaa293';
