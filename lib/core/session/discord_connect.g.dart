// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discord_connect.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Discord's OAuth authorize URL for this flavour (the dashboard's), or null
/// when not configured — every Connect Discord entry point hides then.

@ProviderFor(discordAuthUri)
const discordAuthUriProvider = DiscordAuthUriProvider._();

/// Discord's OAuth authorize URL for this flavour (the dashboard's), or null
/// when not configured — every Connect Discord entry point hides then.

final class DiscordAuthUriProvider extends $FunctionalProvider<Uri?, Uri?, Uri?>
    with $Provider<Uri?> {
  /// Discord's OAuth authorize URL for this flavour (the dashboard's), or null
  /// when not configured — every Connect Discord entry point hides then.
  const DiscordAuthUriProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'discordAuthUriProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$discordAuthUriHash();

  @$internal
  @override
  $ProviderElement<Uri?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Uri? create(Ref ref) {
    return discordAuthUri(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Uri? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Uri?>(value),
    );
  }
}

String _$discordAuthUriHash() => r'b2ae4158bb24f6af006e8c66a86711164188e029';

/// Exchanges the code Discord sent back (via the dashboard redirect App
/// Link) and re-reads the signed-in user, whose `exist_in_guild` drives
/// `needsDiscord`. Value: the backend's message once connected.

@ProviderFor(DiscordConnectController)
const discordConnectControllerProvider = DiscordConnectControllerProvider._();

/// Exchanges the code Discord sent back (via the dashboard redirect App
/// Link) and re-reads the signed-in user, whose `exist_in_guild` drives
/// `needsDiscord`. Value: the backend's message once connected.
final class DiscordConnectControllerProvider
    extends $AsyncNotifierProvider<DiscordConnectController, String?> {
  /// Exchanges the code Discord sent back (via the dashboard redirect App
  /// Link) and re-reads the signed-in user, whose `exist_in_guild` drives
  /// `needsDiscord`. Value: the backend's message once connected.
  const DiscordConnectControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'discordConnectControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$discordConnectControllerHash();

  @$internal
  @override
  DiscordConnectController create() => DiscordConnectController();
}

String _$discordConnectControllerHash() =>
    r'bde7b108f34415d0f3e25106a2dcf262c9693069';

/// Exchanges the code Discord sent back (via the dashboard redirect App
/// Link) and re-reads the signed-in user, whose `exist_in_guild` drives
/// `needsDiscord`. Value: the backend's message once connected.

abstract class _$DiscordConnectController extends $AsyncNotifier<String?> {
  FutureOr<String?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<String?>, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String?>, String?>,
              AsyncValue<String?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Starting the OAuth flow, and the one check after it: the first app
/// resume after the browser opened re-reads the user (the web page may have
/// completed the link). Ordinary resumes do nothing — no polling.

@ProviderFor(DiscordConnectFlow)
const discordConnectFlowProvider = DiscordConnectFlowProvider._();

/// Starting the OAuth flow, and the one check after it: the first app
/// resume after the browser opened re-reads the user (the web page may have
/// completed the link). Ordinary resumes do nothing — no polling.
final class DiscordConnectFlowProvider
    extends $NotifierProvider<DiscordConnectFlow, bool> {
  /// Starting the OAuth flow, and the one check after it: the first app
  /// resume after the browser opened re-reads the user (the web page may have
  /// completed the link). Ordinary resumes do nothing — no polling.
  const DiscordConnectFlowProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'discordConnectFlowProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$discordConnectFlowHash();

  @$internal
  @override
  DiscordConnectFlow create() => DiscordConnectFlow();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$discordConnectFlowHash() =>
    r'234a4b05601a09c1853d177fc0081a686d4b7a82';

/// Starting the OAuth flow, and the one check after it: the first app
/// resume after the browser opened re-reads the user (the web page may have
/// completed the link). Ordinary resumes do nothing — no polling.

abstract class _$DiscordConnectFlow extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
