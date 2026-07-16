// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cover_photo_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CoverPhotoController)
const coverPhotoControllerProvider = CoverPhotoControllerProvider._();

final class CoverPhotoControllerProvider
    extends $AsyncNotifierProvider<CoverPhotoController, void> {
  const CoverPhotoControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'coverPhotoControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$coverPhotoControllerHash();

  @$internal
  @override
  CoverPhotoController create() => CoverPhotoController();
}

String _$coverPhotoControllerHash() =>
    r'7681f8db7ea450c50c51ca7196743ceb208d5f5d';

abstract class _$CoverPhotoController extends $AsyncNotifier<void> {
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
