// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaigns_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Push campaigns, newest first. Loads on open and on pull-to-refresh, and
/// after the user's own create, send or cancel. Nothing polls.

@ProviderFor(CampaignsController)
final campaignsControllerProvider = CampaignsControllerProvider._();

/// Push campaigns, newest first. Loads on open and on pull-to-refresh, and
/// after the user's own create, send or cancel. Nothing polls.
final class CampaignsControllerProvider
    extends $AsyncNotifierProvider<CampaignsController, List<PushCampaign>> {
  /// Push campaigns, newest first. Loads on open and on pull-to-refresh, and
  /// after the user's own create, send or cancel. Nothing polls.
  CampaignsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'campaignsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$campaignsControllerHash();

  @$internal
  @override
  CampaignsController create() => CampaignsController();
}

String _$campaignsControllerHash() =>
    r'2efbe5909ab6d54f4658db5807a50df0458a545c';

/// Push campaigns, newest first. Loads on open and on pull-to-refresh, and
/// after the user's own create, send or cancel. Nothing polls.

abstract class _$CampaignsController
    extends $AsyncNotifier<List<PushCampaign>> {
  FutureOr<List<PushCampaign>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<PushCampaign>>, List<PushCampaign>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<PushCampaign>>, List<PushCampaign>>,
              AsyncValue<List<PushCampaign>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
