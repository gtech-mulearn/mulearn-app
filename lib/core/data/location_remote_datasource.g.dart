// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_remote_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(locationRemoteDataSource)
const locationRemoteDataSourceProvider = LocationRemoteDataSourceProvider._();

final class LocationRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          LocationRemoteDataSource,
          LocationRemoteDataSource,
          LocationRemoteDataSource
        >
    with $Provider<LocationRemoteDataSource> {
  const LocationRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$locationRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<LocationRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocationRemoteDataSource create(Ref ref) {
    return locationRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocationRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocationRemoteDataSource>(value),
    );
  }
}

String _$locationRemoteDataSourceHash() =>
    r'4a64f4565c9d35d0df1593b230ac5fb30eae5d67';
