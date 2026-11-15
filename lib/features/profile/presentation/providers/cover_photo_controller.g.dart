// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cover_photo_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CoverPhotoController)
final coverPhotoControllerProvider = CoverPhotoControllerProvider._();

final class CoverPhotoControllerProvider
    extends $AsyncNotifierProvider<CoverPhotoController, void> {
  CoverPhotoControllerProvider._()
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
    r'86e59b816f37603570bad49ab9b44c8e3f03e99e';

abstract class _$CoverPhotoController extends $AsyncNotifier<void> {
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
