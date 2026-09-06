// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_user_college.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The signed-in user's own college — just `{id, code}`, not a full profile.
///
/// Lives in `core/` (rules.md §2) for the same reason [currentUserMuid]
/// does: "which college am I in" is needed by more than one feature (e.g.
/// `learning_circles` defaulting a new circle's college to the creator's
/// own, no picker) without any of them importing `features/profile`'s
/// domain layer. This is a thin, independent hit to the same real
/// `user-profile` endpoint `features/profile` also calls — mirroring the
/// dashboard/profile precedent of keeping separate minimal projections off
/// one endpoint rather than cross-importing it.
///
/// `id` is confirmed to be in the same id space `learningcircle/create/`'s
/// `org` field expects — it's set via the college-change flow's `org_id`,
/// which is itself sourced from `/api/v1/register/college/list/`, the same
/// namespace `learningcircle/create/` validates against (rules.md §3/§9).

@ProviderFor(currentUserCollege)
const currentUserCollegeProvider = CurrentUserCollegeProvider._();

/// The signed-in user's own college — just `{id, code}`, not a full profile.
///
/// Lives in `core/` (rules.md §2) for the same reason [currentUserMuid]
/// does: "which college am I in" is needed by more than one feature (e.g.
/// `learning_circles` defaulting a new circle's college to the creator's
/// own, no picker) without any of them importing `features/profile`'s
/// domain layer. This is a thin, independent hit to the same real
/// `user-profile` endpoint `features/profile` also calls — mirroring the
/// dashboard/profile precedent of keeping separate minimal projections off
/// one endpoint rather than cross-importing it.
///
/// `id` is confirmed to be in the same id space `learningcircle/create/`'s
/// `org` field expects — it's set via the college-change flow's `org_id`,
/// which is itself sourced from `/api/v1/register/college/list/`, the same
/// namespace `learningcircle/create/` validates against (rules.md §3/§9).

final class CurrentUserCollegeProvider
    extends
        $FunctionalProvider<
          AsyncValue<({String? code, String? id})>,
          ({String? code, String? id}),
          FutureOr<({String? code, String? id})>
        >
    with
        $FutureModifier<({String? code, String? id})>,
        $FutureProvider<({String? code, String? id})> {
  /// The signed-in user's own college — just `{id, code}`, not a full profile.
  ///
  /// Lives in `core/` (rules.md §2) for the same reason [currentUserMuid]
  /// does: "which college am I in" is needed by more than one feature (e.g.
  /// `learning_circles` defaulting a new circle's college to the creator's
  /// own, no picker) without any of them importing `features/profile`'s
  /// domain layer. This is a thin, independent hit to the same real
  /// `user-profile` endpoint `features/profile` also calls — mirroring the
  /// dashboard/profile precedent of keeping separate minimal projections off
  /// one endpoint rather than cross-importing it.
  ///
  /// `id` is confirmed to be in the same id space `learningcircle/create/`'s
  /// `org` field expects — it's set via the college-change flow's `org_id`,
  /// which is itself sourced from `/api/v1/register/college/list/`, the same
  /// namespace `learningcircle/create/` validates against (rules.md §3/§9).
  const CurrentUserCollegeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserCollegeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserCollegeHash();

  @$internal
  @override
  $FutureProviderElement<({String? code, String? id})> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<({String? code, String? id})> create(Ref ref) {
    return currentUserCollege(ref);
  }
}

String _$currentUserCollegeHash() =>
    r'69c27dc5152e85e8f8e06c7f9301fb7f9fa3ea5d';
