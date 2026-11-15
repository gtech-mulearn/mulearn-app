// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campus_groups_controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The campus's circles for a search, page by page.

@ProviderFor(CampusCirclesController)
final campusCirclesControllerProvider = CampusCirclesControllerFamily._();

/// The campus's circles for a search, page by page.
final class CampusCirclesControllerProvider
    extends
        $AsyncNotifierProvider<
          CampusCirclesController,
          PagedState<CampusCircle>
        > {
  /// The campus's circles for a search, page by page.
  CampusCirclesControllerProvider._({
    required CampusCirclesControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: noRetry,
         name: r'campusCirclesControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$campusCirclesControllerHash();

  @override
  String toString() {
    return r'campusCirclesControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CampusCirclesController create() => CampusCirclesController();

  @override
  bool operator ==(Object other) {
    return other is CampusCirclesControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$campusCirclesControllerHash() =>
    r'8f4aa4ca0eb2e9a11a7e3e7f705717c1b2140aca';

/// The campus's circles for a search, page by page.

final class CampusCirclesControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          CampusCirclesController,
          AsyncValue<PagedState<CampusCircle>>,
          PagedState<CampusCircle>,
          FutureOr<PagedState<CampusCircle>>,
          String
        > {
  CampusCirclesControllerFamily._()
    : super(
        retry: noRetry,
        name: r'campusCirclesControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The campus's circles for a search, page by page.

  CampusCirclesControllerProvider call(String search) =>
      CampusCirclesControllerProvider._(argument: search, from: this);

  @override
  String toString() => r'campusCirclesControllerProvider';
}

/// The campus's circles for a search, page by page.

abstract class _$CampusCirclesController
    extends $AsyncNotifier<PagedState<CampusCircle>> {
  late final _$args = ref.$arg as String;
  String get search => _$args;

  FutureOr<PagedState<CampusCircle>> build(String search);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<PagedState<CampusCircle>>,
              PagedState<CampusCircle>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<PagedState<CampusCircle>>,
                PagedState<CampusCircle>
              >,
              AsyncValue<PagedState<CampusCircle>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
