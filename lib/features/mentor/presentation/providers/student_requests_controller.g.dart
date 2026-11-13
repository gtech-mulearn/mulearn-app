// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_requests_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Learners' requests waiting for the mentor, soonest first.

@ProviderFor(StudentRequestsController)
const studentRequestsControllerProvider = StudentRequestsControllerProvider._();

/// Learners' requests waiting for the mentor, soonest first.
final class StudentRequestsControllerProvider
    extends
        $AsyncNotifierProvider<
          StudentRequestsController,
          PagedState<StudentSessionRequest>
        > {
  /// Learners' requests waiting for the mentor, soonest first.
  const StudentRequestsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'studentRequestsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$studentRequestsControllerHash();

  @$internal
  @override
  StudentRequestsController create() => StudentRequestsController();
}

String _$studentRequestsControllerHash() =>
    r'9456cd11f7bb55021cc5ff1cd8ef31b46b32241c';

/// Learners' requests waiting for the mentor, soonest first.

abstract class _$StudentRequestsController
    extends $AsyncNotifier<PagedState<StudentSessionRequest>> {
  FutureOr<PagedState<StudentSessionRequest>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<PagedState<StudentSessionRequest>>,
              PagedState<StudentSessionRequest>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<PagedState<StudentSessionRequest>>,
                PagedState<StudentSessionRequest>
              >,
              AsyncValue<PagedState<StudentSessionRequest>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
