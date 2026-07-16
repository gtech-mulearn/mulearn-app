// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interest_groups_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The full interest-group catalog for the group picker — distinct from the
/// user's own membership list embedded in [UserProfile].

@ProviderFor(interestGroupsList)
const interestGroupsListProvider = InterestGroupsListProvider._();

/// The full interest-group catalog for the group picker — distinct from the
/// user's own membership list embedded in [UserProfile].

final class InterestGroupsListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<InterestGroupListItem>>,
          List<InterestGroupListItem>,
          FutureOr<List<InterestGroupListItem>>
        >
    with
        $FutureModifier<List<InterestGroupListItem>>,
        $FutureProvider<List<InterestGroupListItem>> {
  /// The full interest-group catalog for the group picker — distinct from the
  /// user's own membership list embedded in [UserProfile].
  const InterestGroupsListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'interestGroupsListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$interestGroupsListHash();

  @$internal
  @override
  $FutureProviderElement<List<InterestGroupListItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<InterestGroupListItem>> create(Ref ref) {
    return interestGroupsList(ref);
  }
}

String _$interestGroupsListHash() =>
    r'1cfbd32870b90f6a53438b01884d86796d36aa46';

/// Saves the user's chosen interest groups, then refreshes the main profile
/// so the sidebar reflects the change.

@ProviderFor(InterestGroupsEditController)
const interestGroupsEditControllerProvider =
    InterestGroupsEditControllerProvider._();

/// Saves the user's chosen interest groups, then refreshes the main profile
/// so the sidebar reflects the change.
final class InterestGroupsEditControllerProvider
    extends $AsyncNotifierProvider<InterestGroupsEditController, void> {
  /// Saves the user's chosen interest groups, then refreshes the main profile
  /// so the sidebar reflects the change.
  const InterestGroupsEditControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'interestGroupsEditControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$interestGroupsEditControllerHash();

  @$internal
  @override
  InterestGroupsEditController create() => InterestGroupsEditController();
}

String _$interestGroupsEditControllerHash() =>
    r'e6de279cd33d553fca6cb4d1df79e7ce9cceb315';

/// Saves the user's chosen interest groups, then refreshes the main profile
/// so the sidebar reflects the change.

abstract class _$InterestGroupsEditController extends $AsyncNotifier<void> {
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
