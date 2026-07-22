// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_image_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProfileImageController)
const profileImageControllerProvider = ProfileImageControllerProvider._();

final class ProfileImageControllerProvider
    extends $AsyncNotifierProvider<ProfileImageController, void> {
  const ProfileImageControllerProvider._()
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
    r'641b85da832609daa4e0f8ccd2b9260427161e89';

abstract class _$ProfileImageController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
