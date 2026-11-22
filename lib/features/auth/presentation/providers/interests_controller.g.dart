// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interests_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Submits the pathway/endgoal selections from the post-registration
/// interests onboarding step. Exposes `AsyncValue<void>` for automatic
/// loading/error state (rules.md §4).

@ProviderFor(InterestsController)
final interestsControllerProvider = InterestsControllerProvider._();

/// Submits the pathway/endgoal selections from the post-registration
/// interests onboarding step. Exposes `AsyncValue<void>` for automatic
/// loading/error state (rules.md §4).
final class InterestsControllerProvider
    extends $AsyncNotifierProvider<InterestsController, void> {
  /// Submits the pathway/endgoal selections from the post-registration
  /// interests onboarding step. Exposes `AsyncValue<void>` for automatic
  /// loading/error state (rules.md §4).
  InterestsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'interestsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$interestsControllerHash();

  @$internal
  @override
  InterestsController create() => InterestsController();
}

String _$interestsControllerHash() =>
    r'3ea527fde8fa70bbde7c7e02e896d01ab7fb0528';

/// Submits the pathway/endgoal selections from the post-registration
/// interests onboarding step. Exposes `AsyncValue<void>` for automatic
/// loading/error state (rules.md §4).

abstract class _$InterestsController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
