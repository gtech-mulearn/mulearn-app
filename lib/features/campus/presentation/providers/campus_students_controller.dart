import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';
import 'package:mulearn_app/core/utils/no_retry.dart';
import 'package:mulearn_app/features/campus/data/campus_repository_provider.dart';
import 'package:mulearn_app/features/campus/domain/entities/campus_student.dart';
import 'package:mulearn_app/features/campus/domain/entities/student_activity.dart';
import 'package:mulearn_app/features/campus/domain/student_filter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'campus_students_controller.g.dart';

/// The campus's students for one [StudentFilter], page by page, with the
/// total the backend reports.
typedef StudentsView = ({PagedState<CampusStudent> paged, int count});

@Riverpod(retry: noRetry)
class CampusStudentsController extends _$CampusStudentsController {
  int _pageIndex = 1;
  Future<void>? _inFlight;

  @override
  Future<StudentsView> build(StudentFilter filter) async {
    _pageIndex = 1;
    _inFlight = null;
    final page = await ref
        .watch(campusRepositoryProvider)
        .getStudents(pageIndex: 1, search: filter.search, sortBy: filter.sort.query, alumni: filter.alumni);
    return (paged: PagedState(items: page.items, hasMore: page.hasNext), count: page.count);
  }

  Future<void> loadMore() => _inFlight ??= _loadNextPage().whenComplete(() => _inFlight = null);

  Future<void> _loadNextPage() async {
    final current = state.value;
    if (current == null || !current.paged.hasMore) return;
    state = AsyncData((paged: current.paged.copyWith(isLoadingMore: true, loadMoreError: null), count: current.count));
    final next = _pageIndex + 1;
    try {
      final page = await ref
          .read(campusRepositoryProvider)
          .getStudents(pageIndex: next, search: filter.search, sortBy: filter.sort.query, alumni: filter.alumni);
      if (!ref.mounted) return;
      _pageIndex = next;
      state = AsyncData((
        paged: PagedState(items: [...current.paged.items, ...page.items], hasMore: page.hasNext),
        count: page.count,
      ));
    } on Object catch (e, st) {
      appLogger.w('Loading more students failed', error: e, stackTrace: st);
      if (!ref.mounted) return;
      state = AsyncData((paged: current.paged.copyWith(isLoadingMore: false, loadMoreError: e), count: current.count));
    }
  }
}

/// A student's karma entries, page by page.
@Riverpod(retry: noRetry)
class StudentActivityController extends _$StudentActivityController {
  int _pageIndex = 1;
  Future<void>? _inFlight;

  @override
  Future<PagedState<StudentActivity>> build(String muid) async {
    _pageIndex = 1;
    _inFlight = null;
    final page = await ref.watch(campusRepositoryProvider).getStudentActivity(muid, pageIndex: 1);
    return PagedState(items: page.items, hasMore: page.hasNext);
  }

  Future<void> loadMore() => _inFlight ??= _loadNextPage().whenComplete(() => _inFlight = null);

  Future<void> _loadNextPage() async {
    final current = state.value;
    if (current == null || !current.hasMore) return;
    state = AsyncData(current.copyWith(isLoadingMore: true, loadMoreError: null));
    final next = _pageIndex + 1;
    try {
      final page = await ref.read(campusRepositoryProvider).getStudentActivity(muid, pageIndex: next);
      if (!ref.mounted) return;
      _pageIndex = next;
      state = AsyncData(PagedState(items: mergeUniqueBy(current.items, page.items, (a) => a.id), hasMore: page.hasNext));
    } on Object catch (e, st) {
      appLogger.w('Loading more activity failed', error: e, stackTrace: st);
      if (!ref.mounted) return;
      state = AsyncData(current.copyWith(isLoadingMore: false, loadMoreError: e));
    }
  }
}
