import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/attendee_report.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting_detail.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting_form.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting_report.dart';
import 'package:mulearn_app/features/learning_circles/presentation/providers/learning_circles_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'meetings_controller.g.dart';

/// A circle's meetings, one page at a time — the same paging behaviour as
/// [CirclesListController]: keep-on-error, de-duplicated by id, and
/// concurrent [loadMore] calls share one request.
@riverpod
class CircleMeetingsController extends _$CircleMeetingsController {
  int _pageIndex = 1;
  Future<void>? _inFlight;

  @override
  Future<PagedState<Meeting>> build(String circleId) async {
    _pageIndex = 1;
    _inFlight = null;
    final page = await ref
        .watch(learningCirclesRepositoryProvider)
        .getCircleMeetings(circleId, pageIndex: 1);
    return PagedState(items: page.meetings, hasMore: page.hasNext);
  }

  /// Loads the next page, or retries it after a failure.
  Future<void> loadMore() =>
      _inFlight ??= _loadNextPage().whenComplete(() => _inFlight = null);

  Future<void> _loadNextPage() async {
    final current = state.value;
    if (current == null || !current.hasMore) return;
    state = AsyncData(current.copyWith(isLoadingMore: true, loadMoreError: null));
    final next = _pageIndex + 1;
    try {
      final page = await ref
          .read(learningCirclesRepositoryProvider)
          .getCircleMeetings(circleId, pageIndex: next);
      if (!ref.mounted) return;
      _pageIndex = next;
      state = AsyncData(PagedState(
        items: mergeUniqueBy(current.items, page.meetings, (m) => m.id),
        hasMore: page.hasNext,
      ));
    } on Object catch (e, st) {
      appLogger.w('Loading more meetings failed', error: e, stackTrace: st);
      if (!ref.mounted) return;
      state = AsyncData(current.copyWith(isLoadingMore: false, loadMoreError: e));
    }
  }
}

@riverpod
Future<MeetingDetail> meetingDetail(Ref ref, String id) =>
    ref.watch(learningCirclesRepositoryProvider).getMeetingDetail(id);

@riverpod
Future<AttendeeReport> attendeeReport(Ref ref, String meetingId) =>
    ref.watch(learningCirclesRepositoryProvider).getAttendeeReport(meetingId);

@riverpod
Future<MeetingReport> meetingReport(Ref ref, String meetingId) =>
    ref.watch(learningCirclesRepositoryProvider).getMeetingReport(meetingId);

/// Every meeting action (create/edit/delete/RSVP/join-by-code/leave/
/// reports) — a single notifier, mirroring [CircleActionsController].
@riverpod
class MeetingActionsController extends _$MeetingActionsController {
  @override
  Future<void> build() async {}

  Future<bool> createMeeting(String circleId, MeetingForm form) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(learningCirclesRepositoryProvider)
          .createMeeting(circleId, form);
      ref.invalidate(circleMeetingsControllerProvider(circleId));
    });
    return !state.hasError;
  }

  Future<void> editMeeting(String id, MeetingForm form) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(learningCirclesRepositoryProvider).editMeeting(id, form);
      ref.invalidate(meetingDetailProvider(id));
    });
  }

  /// [circleId] is only known when reached from the circle detail screen's
  /// meetings section (not from meeting-detail alone, which doesn't carry
  /// its own circle id) — passed so that screen's cached meeting list gets
  /// busted; harmless to omit otherwise.
  Future<bool> deleteMeeting(String id, {String? circleId}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(learningCirclesRepositoryProvider).deleteMeeting(id);
      if (circleId != null) ref.invalidate(circleMeetingsControllerProvider(circleId));
    });
    return !state.hasError;
  }

  Future<void> rsvp(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(learningCirclesRepositoryProvider).rsvpMeeting(id);
      ref.invalidate(meetingDetailProvider(id));
    });
  }

  Future<void> joinWithCode(String id, String code) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(learningCirclesRepositoryProvider)
          .joinMeetingWithCode(id, code);
      ref.invalidate(meetingDetailProvider(id));
    });
  }

  Future<void> leave(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(learningCirclesRepositoryProvider).leaveMeeting(id);
      ref.invalidate(meetingDetailProvider(id));
    });
  }

  Future<void> submitAttendeeReport(
    String meetingId, {
    String? report,
    String? reportLink,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(learningCirclesRepositoryProvider).submitAttendeeReport(
            meetingId,
            report: report,
            reportLink: reportLink,
          );
      ref
        ..invalidate(attendeeReportProvider(meetingId))
        ..invalidate(meetingDetailProvider(meetingId));
    });
  }

  Future<void> submitMeetingReport(
    String meetingId, {
    required String report,
    required Map<String, bool> attendees,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(learningCirclesRepositoryProvider).submitMeetingReport(
            meetingId,
            report: report,
            attendees: attendees,
          );
      ref.invalidate(meetingReportProvider(meetingId));
    });
  }
}
