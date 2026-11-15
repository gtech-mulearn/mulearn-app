// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campus_students_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CampusStudentsController)
final campusStudentsControllerProvider = CampusStudentsControllerFamily._();

final class CampusStudentsControllerProvider
    extends $AsyncNotifierProvider<CampusStudentsController, StudentsView> {
  CampusStudentsControllerProvider._({
    required CampusStudentsControllerFamily super.from,
    required StudentFilter super.argument,
  }) : super(
         retry: noRetry,
         name: r'campusStudentsControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$campusStudentsControllerHash();

  @override
  String toString() {
    return r'campusStudentsControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CampusStudentsController create() => CampusStudentsController();

  @override
  bool operator ==(Object other) {
    return other is CampusStudentsControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$campusStudentsControllerHash() =>
    r'be8377c1329617cd8054b00414685cec1ac88e22';

final class CampusStudentsControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          CampusStudentsController,
          AsyncValue<StudentsView>,
          StudentsView,
          FutureOr<StudentsView>,
          StudentFilter
        > {
  CampusStudentsControllerFamily._()
    : super(
        retry: noRetry,
        name: r'campusStudentsControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CampusStudentsControllerProvider call(StudentFilter filter) =>
      CampusStudentsControllerProvider._(argument: filter, from: this);

  @override
  String toString() => r'campusStudentsControllerProvider';
}

abstract class _$CampusStudentsController extends $AsyncNotifier<StudentsView> {
  late final _$args = ref.$arg as StudentFilter;
  StudentFilter get filter => _$args;

  FutureOr<StudentsView> build(StudentFilter filter);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<StudentsView>, StudentsView>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<StudentsView>, StudentsView>,
              AsyncValue<StudentsView>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

/// A student's karma entries, page by page.

@ProviderFor(StudentActivityController)
final studentActivityControllerProvider = StudentActivityControllerFamily._();

/// A student's karma entries, page by page.
final class StudentActivityControllerProvider
    extends
        $AsyncNotifierProvider<
          StudentActivityController,
          PagedState<StudentActivity>
        > {
  /// A student's karma entries, page by page.
  StudentActivityControllerProvider._({
    required StudentActivityControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: noRetry,
         name: r'studentActivityControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$studentActivityControllerHash();

  @override
  String toString() {
    return r'studentActivityControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  StudentActivityController create() => StudentActivityController();

  @override
  bool operator ==(Object other) {
    return other is StudentActivityControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$studentActivityControllerHash() =>
    r'f2b2c8d6e4cf11180f97bbd3b10a75a000aa3a39';

/// A student's karma entries, page by page.

final class StudentActivityControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          StudentActivityController,
          AsyncValue<PagedState<StudentActivity>>,
          PagedState<StudentActivity>,
          FutureOr<PagedState<StudentActivity>>,
          String
        > {
  StudentActivityControllerFamily._()
    : super(
        retry: noRetry,
        name: r'studentActivityControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// A student's karma entries, page by page.

  StudentActivityControllerProvider call(String muid) =>
      StudentActivityControllerProvider._(argument: muid, from: this);

  @override
  String toString() => r'studentActivityControllerProvider';
}

/// A student's karma entries, page by page.

abstract class _$StudentActivityController
    extends $AsyncNotifier<PagedState<StudentActivity>> {
  late final _$args = ref.$arg as String;
  String get muid => _$args;

  FutureOr<PagedState<StudentActivity>> build(String muid);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<PagedState<StudentActivity>>,
              PagedState<StudentActivity>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<PagedState<StudentActivity>>,
                PagedState<StudentActivity>
              >,
              AsyncValue<PagedState<StudentActivity>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
