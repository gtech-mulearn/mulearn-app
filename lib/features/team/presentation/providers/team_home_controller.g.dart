// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_home_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The team home's one action: a test push to the signed-in account's own
/// phones. Loading while the request runs; the backend's message (or its
/// error) goes back to the screen, which shows it as a toast.

@ProviderFor(TeamHomeController)
final teamHomeControllerProvider = TeamHomeControllerProvider._();

/// The team home's one action: a test push to the signed-in account's own
/// phones. Loading while the request runs; the backend's message (or its
/// error) goes back to the screen, which shows it as a toast.
final class TeamHomeControllerProvider
    extends $AsyncNotifierProvider<TeamHomeController, void> {
  /// The team home's one action: a test push to the signed-in account's own
  /// phones. Loading while the request runs; the backend's message (or its
  /// error) goes back to the screen, which shows it as a toast.
  TeamHomeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'teamHomeControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$teamHomeControllerHash();

  @$internal
  @override
  TeamHomeController create() => TeamHomeController();
}

String _$teamHomeControllerHash() =>
    r'876e1cc0ca83c4ef2ab09d75d7715eff7d3a70f7';

/// The team home's one action: a test push to the signed-in account's own
/// phones. Loading while the request runs; the backend's message (or its
/// error) goes back to the screen, which shows it as a toast.

abstract class _$TeamHomeController extends $AsyncNotifier<void> {
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
