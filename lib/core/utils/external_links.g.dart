// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'external_links.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The app's way to open external links; tests override it.

@ProviderFor(openExternal)
const openExternalProvider = OpenExternalProvider._();

/// The app's way to open external links; tests override it.

final class OpenExternalProvider
    extends $FunctionalProvider<OpenExternal, OpenExternal, OpenExternal>
    with $Provider<OpenExternal> {
  /// The app's way to open external links; tests override it.
  const OpenExternalProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'openExternalProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$openExternalHash();

  @$internal
  @override
  $ProviderElement<OpenExternal> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  OpenExternal create(Ref ref) {
    return openExternal(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OpenExternal value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OpenExternal>(value),
    );
  }
}

String _$openExternalHash() => r'501533538aa21494e5f5c6c1cae10c42fd7067b8';
