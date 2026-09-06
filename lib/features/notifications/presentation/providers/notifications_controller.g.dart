// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_controller.dart';

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
    r'0de0f0f293229433b0a2cdef8570a0bd1da82ec6';

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

/// The notification inbox, plus its own mutations (mirrors
/// `CircleActionsController`'s single-notifier-per-feature pattern) — mark
/// all read (repository round-trip, then a self-refresh) and mark-one-read
/// (an optimistic local update, since there's no backend to persist
/// per-item read-state to yet either).

@ProviderFor(NotificationsController)
const notificationsControllerProvider = NotificationsControllerProvider._();

/// The notification inbox, plus its own mutations (mirrors
/// `CircleActionsController`'s single-notifier-per-feature pattern) — mark
/// all read (repository round-trip, then a self-refresh) and mark-one-read
/// (an optimistic local update, since there's no backend to persist
/// per-item read-state to yet either).
final class NotificationsControllerProvider
    extends
        $AsyncNotifierProvider<NotificationsController, List<AppNotification>> {
  /// The notification inbox, plus its own mutations (mirrors
  /// `CircleActionsController`'s single-notifier-per-feature pattern) — mark
  /// all read (repository round-trip, then a self-refresh) and mark-one-read
  /// (an optimistic local update, since there's no backend to persist
  /// per-item read-state to yet either).
  const NotificationsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationsControllerHash();

  @$internal
  @override
  NotificationsController create() => NotificationsController();
}

String _$notificationsControllerHash() =>
    r'2954eab93cc4f958771887a0643d22c6215b466b';

/// The notification inbox, plus its own mutations (mirrors
/// `CircleActionsController`'s single-notifier-per-feature pattern) — mark
/// all read (repository round-trip, then a self-refresh) and mark-one-read
/// (an optimistic local update, since there's no backend to persist
/// per-item read-state to yet either).

abstract class _$NotificationsController
    extends $AsyncNotifier<List<AppNotification>> {
  FutureOr<List<AppNotification>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<List<AppNotification>>, List<AppNotification>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<AppNotification>>,
                List<AppNotification>
              >,
              AsyncValue<List<AppNotification>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
