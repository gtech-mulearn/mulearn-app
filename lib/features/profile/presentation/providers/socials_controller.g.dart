// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'socials_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SocialsController)
const socialsControllerProvider = SocialsControllerProvider._();

final class SocialsControllerProvider
    extends $AsyncNotifierProvider<SocialsController, Socials> {
  const SocialsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'socialsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$socialsControllerHash();

  @$internal
  @override
  SocialsController create() => SocialsController();
}

String _$socialsControllerHash() => r'adfea31e93eb20c234db9448e27732f95d1e0a26';

abstract class _$SocialsController extends $AsyncNotifier<Socials> {
  FutureOr<Socials> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Socials>, Socials>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Socials>, Socials>,
              AsyncValue<Socials>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
