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
const interestsControllerProvider = InterestsControllerProvider._();

/// Submits the pathway/endgoal selections from the post-registration
/// interests onboarding step. Exposes `AsyncValue<void>` for automatic
/// loading/error state (rules.md §4).
final class InterestsControllerProvider
    extends $AsyncNotifierProvider<InterestsController, void> {
  /// Submits the pathway/endgoal selections from the post-registration
  /// interests onboarding step. Exposes `AsyncValue<void>` for automatic
  /// loading/error state (rules.md §4).
  const InterestsControllerProvider._()
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
    r'349433975a229229b076d2a744deaef743804d0f';

/// Submits the pathway/endgoal selections from the post-registration
/// interests onboarding step. Exposes `AsyncValue<void>` for automatic
/// loading/error state (rules.md §4).

abstract class _$InterestsController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
