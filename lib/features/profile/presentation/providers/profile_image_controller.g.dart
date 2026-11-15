// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_image_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Uploads the member's profile photo. Errors (too large, rejected by the
/// server) land in [state] for the screen to show.

@ProviderFor(ProfileImageController)
final profileImageControllerProvider = ProfileImageControllerProvider._();

/// Uploads the member's profile photo. Errors (too large, rejected by the
/// server) land in [state] for the screen to show.
final class ProfileImageControllerProvider
    extends $AsyncNotifierProvider<ProfileImageController, void> {
  /// Uploads the member's profile photo. Errors (too large, rejected by the
  /// server) land in [state] for the screen to show.
  ProfileImageControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileImageControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileImageControllerHash();

  @$internal
  @override
  ProfileImageController create() => ProfileImageController();
}

String _$profileImageControllerHash() =>
    r'0036c3e435b4e5a6782446e5e24691b2ea049b8a';

/// Uploads the member's profile photo. Errors (too large, rejected by the
/// server) land in [state] for the screen to show.

abstract class _$ProfileImageController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
