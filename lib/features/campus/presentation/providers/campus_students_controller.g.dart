// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campus_students_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CampusStudentsController)
const campusStudentsControllerProvider = CampusStudentsControllerFamily._();

final class CampusStudentsControllerProvider
    extends $AsyncNotifierProvider<CampusStudentsController, StudentsView> {
  const CampusStudentsControllerProvider._({
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
    r'efb0fa8261f841edc5b9b1354b8326f33ad50fd0';

final class CampusStudentsControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          CampusStudentsController,
          AsyncValue<StudentsView>,
          StudentsView,
          FutureOr<StudentsView>,
          StudentFilter
        > {
  const CampusStudentsControllerFamily._()
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
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<StudentsView>, StudentsView>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<StudentsView>, StudentsView>,
              AsyncValue<StudentsView>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// One student, found by muID (`student-details` searches muIDs too), so a
/// deep link works without the list. Null when not at this campus.

@ProviderFor(campusStudent)
const campusStudentProvider = CampusStudentFamily._();

/// One student, found by muID (`student-details` searches muIDs too), so a
/// deep link works without the list. Null when not at this campus.

final class CampusStudentProvider
    extends
        $FunctionalProvider<
          AsyncValue<CampusStudent?>,
          CampusStudent?,
          FutureOr<CampusStudent?>
        >
    with $FutureModifier<CampusStudent?>, $FutureProvider<CampusStudent?> {
  /// One student, found by muID (`student-details` searches muIDs too), so a
  /// deep link works without the list. Null when not at this campus.
  const CampusStudentProvider._({
    required CampusStudentFamily super.from,
    required String super.argument,
  }) : super(
         retry: noRetry,
         name: r'campusStudentProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$campusStudentHash();

  @override
  String toString() {
    return r'campusStudentProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<CampusStudent?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CampusStudent?> create(Ref ref) {
    final argument = this.argument as String;
    return campusStudent(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CampusStudentProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$campusStudentHash() => r'26b1eef20fe5fc51698b2fb971d76193fa2dd50b';

/// One student, found by muID (`student-details` searches muIDs too), so a
/// deep link works without the list. Null when not at this campus.

final class CampusStudentFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<CampusStudent?>, String> {
  const CampusStudentFamily._()
    : super(
        retry: noRetry,
        name: r'campusStudentProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// One student, found by muID (`student-details` searches muIDs too), so a
  /// deep link works without the list. Null when not at this campus.

  CampusStudentProvider call(String muid) =>
      CampusStudentProvider._(argument: muid, from: this);

  @override
  String toString() => r'campusStudentProvider';
}

/// A student's karma entries, page by page.

@ProviderFor(StudentActivityController)
const studentActivityControllerProvider = StudentActivityControllerFamily._();

/// A student's karma entries, page by page.
final class StudentActivityControllerProvider
    extends
        $AsyncNotifierProvider<
          StudentActivityController,
          PagedState<StudentActivity>
        > {
  /// A student's karma entries, page by page.
  const StudentActivityControllerProvider._({
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
  const StudentActivityControllerFamily._()
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
  void runBuild() {
    final created = build(_$args);
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
    element.handleValue(ref, created);
  }
}
