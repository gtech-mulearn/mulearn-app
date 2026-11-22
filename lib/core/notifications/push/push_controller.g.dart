// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The device side: Firebase in builds that have its config, a no-op
/// otherwise (the app works the same, just without pushes).

@ProviderFor(pushMessaging)
final pushMessagingProvider = PushMessagingProvider._();

/// The device side: Firebase in builds that have its config, a no-op
/// otherwise (the app works the same, just without pushes).

final class PushMessagingProvider
    extends $FunctionalProvider<PushMessaging, PushMessaging, PushMessaging>
    with $Provider<PushMessaging> {
  /// The device side: Firebase in builds that have its config, a no-op
  /// otherwise (the app works the same, just without pushes).
  PushMessagingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pushMessagingProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pushMessagingHash();

  @$internal
  @override
  $ProviderElement<PushMessaging> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PushMessaging create(Ref ref) {
    return pushMessaging(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PushMessaging value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PushMessaging>(value),
    );
  }
}

String _$pushMessagingHash() => r'ab1307899b2c1f104f3a7f259a4a37372e1c9eeb';

@ProviderFor(pushRemoteDataSource)
final pushRemoteDataSourceProvider = PushRemoteDataSourceProvider._();

final class PushRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          PushRemoteDataSource,
          PushRemoteDataSource,
          PushRemoteDataSource
        >
    with $Provider<PushRemoteDataSource> {
  PushRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pushRemoteDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pushRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<PushRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PushRemoteDataSource create(Ref ref) {
    return pushRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PushRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PushRemoteDataSource>(value),
    );
  }
}

String _$pushRemoteDataSourceHash() =>
    r'28c1cf22491a18531914598a95eab247c1e28b60';

/// Owns this device's push registration.
///
/// - Signed in with permission: registers the FCM token with the backend
///   once per app start, and again whenever FCM rotates it.
/// - Never asks for permission by itself: [requestPermission] runs from a
///   user action (the "Turn on notifications" tile).
/// - [unregisterForSignOut] runs before the session is cleared.

@ProviderFor(PushController)
final pushControllerProvider = PushControllerProvider._();

/// Owns this device's push registration.
///
/// - Signed in with permission: registers the FCM token with the backend
///   once per app start, and again whenever FCM rotates it.
/// - Never asks for permission by itself: [requestPermission] runs from a
///   user action (the "Turn on notifications" tile).
/// - [unregisterForSignOut] runs before the session is cleared.
final class PushControllerProvider
    extends $AsyncNotifierProvider<PushController, PushStatus> {
  /// Owns this device's push registration.
  ///
  /// - Signed in with permission: registers the FCM token with the backend
  ///   once per app start, and again whenever FCM rotates it.
  /// - Never asks for permission by itself: [requestPermission] runs from a
  ///   user action (the "Turn on notifications" tile).
  /// - [unregisterForSignOut] runs before the session is cleared.
  PushControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pushControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pushControllerHash();

  @$internal
  @override
  PushController create() => PushController();
}

String _$pushControllerHash() => r'de3ef41a2131c665a99a51ecdd040b13bc020bd5';

/// Owns this device's push registration.
///
/// - Signed in with permission: registers the FCM token with the backend
///   once per app start, and again whenever FCM rotates it.
/// - Never asks for permission by itself: [requestPermission] runs from a
///   user action (the "Turn on notifications" tile).
/// - [unregisterForSignOut] runs before the session is cleared.

abstract class _$PushController extends $AsyncNotifier<PushStatus> {
  FutureOr<PushStatus> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PushStatus>, PushStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PushStatus>, PushStatus>,
              AsyncValue<PushStatus>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
