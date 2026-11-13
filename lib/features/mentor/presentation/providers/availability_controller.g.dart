// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'availability_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The mentor's weekly slots, Monday first, earliest first. Errors from the
/// actions are rethrown for the screen to show.

@ProviderFor(AvailabilityController)
const availabilityControllerProvider = AvailabilityControllerProvider._();

/// The mentor's weekly slots, Monday first, earliest first. Errors from the
/// actions are rethrown for the screen to show.
final class AvailabilityControllerProvider
    extends
        $AsyncNotifierProvider<AvailabilityController, List<AvailabilitySlot>> {
  /// The mentor's weekly slots, Monday first, earliest first. Errors from the
  /// actions are rethrown for the screen to show.
  const AvailabilityControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'availabilityControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$availabilityControllerHash();

  @$internal
  @override
  AvailabilityController create() => AvailabilityController();
}

String _$availabilityControllerHash() =>
    r'df813c71f9e48fe70291eb39164e4b3ffd2a8d62';

/// The mentor's weekly slots, Monday first, earliest first. Errors from the
/// actions are rethrown for the screen to show.

abstract class _$AvailabilityController
    extends $AsyncNotifier<List<AvailabilitySlot>> {
  FutureOr<List<AvailabilitySlot>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<List<AvailabilitySlot>>, List<AvailabilitySlot>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<AvailabilitySlot>>,
                List<AvailabilitySlot>
              >,
              AsyncValue<List<AvailabilitySlot>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
