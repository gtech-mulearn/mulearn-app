// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationsRemoteDataSource)
const notificationsRemoteDataSourceProvider =
    NotificationsRemoteDataSourceProvider._();

final class NotificationsRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          NotificationsRemoteDataSource,
          NotificationsRemoteDataSource,
          NotificationsRemoteDataSource
        >
    with $Provider<NotificationsRemoteDataSource> {
  const NotificationsRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationsRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationsRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<NotificationsRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationsRemoteDataSource create(Ref ref) {
    return notificationsRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationsRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationsRemoteDataSource>(
        value,
      ),
    );
  }
}

String _$notificationsRemoteDataSourceHash() =>
    r'e4d14884b638fb7d17dac86a17b6d480ca08e259';

/// Presentation depends on the [NotificationsRepository] contract
/// (rules.md §2/§5).

@ProviderFor(notificationsRepository)
const notificationsRepositoryProvider = NotificationsRepositoryProvider._();

/// Presentation depends on the [NotificationsRepository] contract
/// (rules.md §2/§5).

final class NotificationsRepositoryProvider
    extends
        $FunctionalProvider<
          NotificationsRepository,
          NotificationsRepository,
          NotificationsRepository
        >
    with $Provider<NotificationsRepository> {
  /// Presentation depends on the [NotificationsRepository] contract
  /// (rules.md §2/§5).
  const NotificationsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationsRepositoryHash();

  @$internal
  @override
  $ProviderElement<NotificationsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationsRepository create(Ref ref) {
    return notificationsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationsRepository>(value),
    );
  }
}

String _$notificationsRepositoryHash() =>
    r'724efde7e1b70c5e9da0f80d74043eb100da265f';
