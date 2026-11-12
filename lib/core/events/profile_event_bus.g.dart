// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_event_bus.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(profileEventBus)
const profileEventBusProvider = ProfileEventBusProvider._();

final class ProfileEventBusProvider
    extends
        $FunctionalProvider<ProfileEventBus, ProfileEventBus, ProfileEventBus>
    with $Provider<ProfileEventBus> {
  const ProfileEventBusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileEventBusProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileEventBusHash();

  @$internal
  @override
  $ProviderElement<ProfileEventBus> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ProfileEventBus create(Ref ref) {
    return profileEventBus(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfileEventBus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfileEventBus>(value),
    );
  }
}

String _$profileEventBusHash() => r'6ae33be674fae5c3fcf43a523ea575e0221bb93e';
