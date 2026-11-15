// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_version.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Read once per launch.

@ProviderFor(appVersion)
final appVersionProvider = AppVersionProvider._();

/// Read once per launch.

final class AppVersionProvider
    extends
        $FunctionalProvider<
          AsyncValue<AppVersion>,
          AppVersion,
          FutureOr<AppVersion>
        >
    with $FutureModifier<AppVersion>, $FutureProvider<AppVersion> {
  /// Read once per launch.
  AppVersionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appVersionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appVersionHash();

  @$internal
  @override
  $FutureProviderElement<AppVersion> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<AppVersion> create(Ref ref) {
    return appVersion(ref);
  }
}

String _$appVersionHash() => r'2cde87e53365d946bb19adbea62396d84e8e5adf';
