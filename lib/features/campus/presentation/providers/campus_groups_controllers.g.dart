// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campus_groups_controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The campus's circles for a search, page by page.

@ProviderFor(CampusCirclesController)
const campusCirclesControllerProvider = CampusCirclesControllerFamily._();

/// The campus's circles for a search, page by page.
final class CampusCirclesControllerProvider
    extends
        $AsyncNotifierProvider<
          CampusCirclesController,
          PagedState<CampusCircle>
        > {
  /// The campus's circles for a search, page by page.
  const CampusCirclesControllerProvider._({
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
    r'85bdb23773c9bc10a3e5919e60a7773850a948d8';

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
  const CampusCirclesControllerFamily._()
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
  void runBuild() {
    final created = build(_$args);
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
    element.handleValue(ref, created);
  }
}

/// Interest groups for a search, page by page.

@ProviderFor(CampusIgsController)
const campusIgsControllerProvider = CampusIgsControllerFamily._();

/// Interest groups for a search, page by page.
final class CampusIgsControllerProvider
    extends $AsyncNotifierProvider<CampusIgsController, PagedState<CampusIg>> {
  /// Interest groups for a search, page by page.
  const CampusIgsControllerProvider._({
    required CampusIgsControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: noRetry,
         name: r'campusIgsControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$campusIgsControllerHash();

  @override
  String toString() {
    return r'campusIgsControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CampusIgsController create() => CampusIgsController();

  @override
  bool operator ==(Object other) {
    return other is CampusIgsControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$campusIgsControllerHash() =>
    r'2b66f7d1c0651333a469d62529956bb1270e96bb';

/// Interest groups for a search, page by page.

final class CampusIgsControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          CampusIgsController,
          AsyncValue<PagedState<CampusIg>>,
          PagedState<CampusIg>,
          FutureOr<PagedState<CampusIg>>,
          String
        > {
  const CampusIgsControllerFamily._()
    : super(
        retry: noRetry,
        name: r'campusIgsControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Interest groups for a search, page by page.

  CampusIgsControllerProvider call(String search) =>
      CampusIgsControllerProvider._(argument: search, from: this);

  @override
  String toString() => r'campusIgsControllerProvider';
}

/// Interest groups for a search, page by page.

abstract class _$CampusIgsController
    extends $AsyncNotifier<PagedState<CampusIg>> {
  late final _$args = ref.$arg as String;
  String get search => _$args;

  FutureOr<PagedState<CampusIg>> build(String search);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref
            as $Ref<AsyncValue<PagedState<CampusIg>>, PagedState<CampusIg>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<PagedState<CampusIg>>,
                PagedState<CampusIg>
              >,
              AsyncValue<PagedState<CampusIg>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
