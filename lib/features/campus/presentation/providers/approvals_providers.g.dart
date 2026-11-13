// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approvals_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(orgLinkRequests)
const orgLinkRequestsProvider = OrgLinkRequestsProvider._();

final class OrgLinkRequestsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<OrgLinkRequest>>,
          List<OrgLinkRequest>,
          FutureOr<List<OrgLinkRequest>>
        >
    with
        $FutureModifier<List<OrgLinkRequest>>,
        $FutureProvider<List<OrgLinkRequest>> {
  const OrgLinkRequestsProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'orgLinkRequestsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$orgLinkRequestsHash();

  @$internal
  @override
  $FutureProviderElement<List<OrgLinkRequest>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<OrgLinkRequest>> create(Ref ref) {
    return orgLinkRequests(ref);
  }
}

String _$orgLinkRequestsHash() => r'486b76b18c073525cc4cdcb039ce3bb1fcaf33d0';

@ProviderFor(pendingCampusEvents)
const pendingCampusEventsProvider = PendingCampusEventsProvider._();

final class PendingCampusEventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PendingCampusEvent>>,
          List<PendingCampusEvent>,
          FutureOr<List<PendingCampusEvent>>
        >
    with
        $FutureModifier<List<PendingCampusEvent>>,
        $FutureProvider<List<PendingCampusEvent>> {
  const PendingCampusEventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'pendingCampusEventsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pendingCampusEventsHash();

  @$internal
  @override
  $FutureProviderElement<List<PendingCampusEvent>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PendingCampusEvent>> create(Ref ref) {
    return pendingCampusEvents(ref);
  }
}

String _$pendingCampusEventsHash() =>
    r'58c436626704f29854c14eba642d6dbeaa93f1e5';

@ProviderFor(collabInvites)
const collabInvitesProvider = CollabInvitesProvider._();

final class CollabInvitesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CollabInvite>>,
          List<CollabInvite>,
          FutureOr<List<CollabInvite>>
        >
    with
        $FutureModifier<List<CollabInvite>>,
        $FutureProvider<List<CollabInvite>> {
  const CollabInvitesProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'collabInvitesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$collabInvitesHash();

  @$internal
  @override
  $FutureProviderElement<List<CollabInvite>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CollabInvite>> create(Ref ref) {
    return collabInvites(ref);
  }
}

String _$collabInvitesHash() => r'994be6a8076b46c700f0cb375da6a7994470a615';

/// Every decision reloads its list afterwards — after a refusal too, since
/// the usual cause is someone else having handled it already.

@ProviderFor(ApprovalActions)
const approvalActionsProvider = ApprovalActionsProvider._();

/// Every decision reloads its list afterwards — after a refusal too, since
/// the usual cause is someone else having handled it already.
final class ApprovalActionsProvider
    extends $NotifierProvider<ApprovalActions, void> {
  /// Every decision reloads its list afterwards — after a refusal too, since
  /// the usual cause is someone else having handled it already.
  const ApprovalActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'approvalActionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$approvalActionsHash();

  @$internal
  @override
  ApprovalActions create() => ApprovalActions();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$approvalActionsHash() => r'279356a40a82127ca7991b4e755e01073bd1212e';

/// Every decision reloads its list afterwards — after a refusal too, since
/// the usual cause is someone else having handled it already.

abstract class _$ApprovalActions extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
