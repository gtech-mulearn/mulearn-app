// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaigns_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Push campaigns, newest first. Loads on open and on pull-to-refresh. While
/// any campaign is `sending` it refreshes every 5 s, because the backend
/// sends in the background; it stops as soon as none is sending, and when
/// the last screen closes.

@ProviderFor(CampaignsController)
final campaignsControllerProvider = CampaignsControllerProvider._();

/// Push campaigns, newest first. Loads on open and on pull-to-refresh. While
/// any campaign is `sending` it refreshes every 5 s, because the backend
/// sends in the background; it stops as soon as none is sending, and when
/// the last screen closes.
final class CampaignsControllerProvider
    extends $AsyncNotifierProvider<CampaignsController, List<PushCampaign>> {
  /// Push campaigns, newest first. Loads on open and on pull-to-refresh. While
  /// any campaign is `sending` it refreshes every 5 s, because the backend
  /// sends in the background; it stops as soon as none is sending, and when
  /// the last screen closes.
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
    r'97e0fac8617283afa69f96b4a3d529477db8823e';

/// Push campaigns, newest first. Loads on open and on pull-to-refresh. While
/// any campaign is `sending` it refreshes every 5 s, because the backend
/// sends in the background; it stops as soon as none is sending, and when
/// the last screen closes.

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
