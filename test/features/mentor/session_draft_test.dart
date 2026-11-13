import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_scope.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_session.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_draft.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_enums.dart';
import 'package:mulearn_app/features/mentor/domain/session_filter.dart';

/// Plan 4, Task 3: what a new or edited session sends, following the
/// dashboard's `toBackendPayload` and the backend's SessionCreateSerializer.
void main() {
  const igTarget = SessionTarget(type: SessionType.igSession, entityId: 'ig1', label: 'Web Development');

  SessionDraft draft({
    SessionMode mode = SessionMode.online,
    String link = 'https://meet.example/x',
    String venue = '',
    DateTime? starts,
    DateTime? ends,
  }) =>
      SessionDraft(
        target: igTarget,
        title: '  Office hours  ',
        description: '',
        mode: mode,
        startsLocal: starts ?? DateTime(2026, 11, 20, 18),
        endsLocal: ends ?? DateTime(2026, 11, 20, 19),
        meetingLink: link,
        venue: venue,
      );

  group('validate', () {
    test('end before start is refused locally', () {
      expect(
        draft(starts: DateTime(2026, 11, 20, 19), ends: DateTime(2026, 11, 20, 18)).validate(),
        'Session start time must be before end time.',
      );
      expect(
        draft(starts: DateTime(2026, 11, 20, 19), ends: DateTime(2026, 11, 20, 19)).validate(),
        'Session start time must be before end time.',
      );
    });

    test('the target and title come first', () {
      expect(draft().copyWith(target: null).validate(), 'Pick where this session belongs.');
      expect(draft().copyWith(title: '   ').validate(), 'Title is required.');
    });

    test('hybrid needs both a venue and a link', () {
      expect(draft(mode: SessionMode.hybrid).validate(), 'Venue is required for a hybrid session.');
      expect(
        draft(mode: SessionMode.hybrid, venue: 'Hall A', link: '').validate(),
        'Meeting link is required for a hybrid session.',
      );
    });

    test('a repeating session needs how often', () {
      expect(draft().copyWith(isRecurring: true).validate(), 'Choose how often it repeats.');
      expect(
        draft()
            .copyWith(isRecurring: true, recurrenceType: RecurrenceType.weekly, recurrenceEndDate: DateTime(2026, 12, 18))
            .validate(),
        isNull,
      );
    });

    // Final review, Important 3: the backend always requires an end date
    // after the first session's day (SessionCreateSerializer.validate).
    test('a repeating session needs an end date after its first day', () {
      final weekly = draft().copyWith(isRecurring: true, recurrenceType: RecurrenceType.weekly);
      expect(weekly.validate(), 'Choose when it stops repeating.');
      expect(weekly.copyWith(recurrenceEndDate: DateTime(2026, 11, 20)).validate(),
          "The repeat must end after the first session's day.");
      expect(weekly.copyWith(recurrenceEndDate: DateTime(2026, 11, 21)).validate(), isNull);
    });
  });

  group('toCreateJson', () {
    test('online sends the link, a blank venue, trimmed text and UTC times', () {
      final json = draft(venue: 'typed then switched').toCreateJson();

      expect(json['session_type'], 'IG_SESSION');
      expect(json['entity_id'], 'ig1');
      expect(json['title'], 'Office hours');
      expect(json.containsKey('description'), isFalse, reason: 'empty optional text is omitted');
      expect(json['mode'], 'ONLINE');
      expect(json['venue'], '');
      expect(json['meeting_link'], 'https://meet.example/x');
      expect(json['starts_at'], DateTime(2026, 11, 20, 18).toUtc().toIso8601String());
      expect(json['ends_at'], DateTime(2026, 11, 20, 19).toUtc().toIso8601String());
      expect(json['is_recurring'], isFalse);
      expect(json.containsKey('recurrence_type'), isFalse);
    });

    test('offline sends a blank link', () {
      final json = draft(mode: SessionMode.offline, venue: 'Hall A').toCreateJson();
      expect(json['meeting_link'], '');
      expect(json['venue'], 'Hall A');
    });

    test('a weekly series sends its recurrence', () {
      final json = draft()
          .copyWith(
            isRecurring: true,
            recurrenceType: RecurrenceType.weekly,
            recurrenceInterval: 2,
            recurrenceEndDate: DateTime(2026, 12, 31),
            maxParticipants: 30,
          )
          .toCreateJson();
      expect(json['is_recurring'], isTrue);
      expect(json['recurrence_type'], 'WEEKLY');
      expect(json['recurrence_interval'], 2);
      expect(json['recurrence_end_date'], '2026-12-31');
      expect(json['max_participants'], 30);
    });
  });

  test('an edit sends only what the backend lets an edit change', () {
    final json = draft().copyWith(isRecurring: true, recurrenceType: RecurrenceType.daily, maxParticipants: 5).toUpdateJson();
    expect(json.keys.toSet(), {'title', 'mode', 'starts_at', 'ends_at', 'meeting_link', 'venue'});
  });

  group('sessionTargets', () {
    MentorScope scope(MentorScopeType type, {String id = 's1', String name = 'Scope'}) =>
        MentorScope(type: type, id: id, name: name, metrics: const MentorScopeMetrics());

    test('each scope is a target of its own session type', () {
      final targets = sessionTargets([
        scope(MentorScopeType.igMentor, id: 'ig1', name: 'Web Development'),
        scope(MentorScopeType.campusMentor, id: 'org1', name: 'CET'),
        scope(MentorScopeType.companyMentor, id: 'co1', name: 'Acme'),
      ], const []);
      expect(targets.map((t) => (t.type, t.entityId, t.label)), [
        (SessionType.igSession, 'ig1', 'Web Development'),
        (SessionType.campusSession, 'org1', 'CET'),
        (SessionType.companySession, 'co1', 'Acme'),
      ]);
    });

    test('a global mentor targets interest groups', () {
      final targets = sessionTargets(
        [scope(MentorScopeType.global)],
        const [IgOption(id: 'ig9', name: 'AI')],
      );
      expect(targets.single, const SessionTarget(type: SessionType.igSession, entityId: 'ig9', label: 'AI'));
    });

    test('a global mentor with no interest group has nowhere to create', () {
      expect(sessionTargets([scope(MentorScopeType.global)], const []), isEmpty);
    });
  });

  test('a late-evening session keeps its local day', () {
    final s = MentorSession(
      id: 'a',
      entityId: 'ig1',
      entityName: 'Web Development',
      type: SessionType.igSession,
      title: 'Late',
      description: '',
      mode: SessionMode.online,
      startsAt: DateTime.utc(2026, 11, 20, 18),
      endsAt: DateTime.utc(2026, 11, 20, 19),
      status: SessionStatus.scheduled,
      isRecurring: false,
    );
    // IST is UTC+5:30: 18:00Z is 23:30 on the 20th, not the 21st.
    final groups = groupByLocalDay([s], toLocal: (t) => t.add(const Duration(hours: 5, minutes: 30)));
    expect(groups.single.day, DateTime(2026, 11, 20));
  });

  test('each filter asks for its status and order', () {
    expect((SessionFilter.upcoming.status, SessionFilter.upcoming.ascending), (SessionStatus.scheduled, true));
    expect((SessionFilter.awaitingApproval.status, SessionFilter.awaitingApproval.ascending),
        (SessionStatus.pendingApproval, false));
    expect((SessionFilter.completed.status, SessionFilter.completed.ascending), (SessionStatus.completed, false));
    expect((SessionFilter.all.status, SessionFilter.all.ascending), (null, false));
    expect(SessionFilter.values.map((f) => f.label), ['Upcoming', 'Awaiting approval', 'Completed', 'All']);
  });
}
