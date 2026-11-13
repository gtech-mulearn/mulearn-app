import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/features/mentor/data/dtos/mentor_analytics_dto.dart';
import 'package:mulearn_app/features/mentor/data/dtos/mentor_profile_completion_dto.dart';
import 'package:mulearn_app/features/mentor/data/dtos/mentor_scope_dto.dart';
import 'package:mulearn_app/features/mentor/data/dtos/mentor_session_dto.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_scope.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_enums.dart';

import '../../support/fixtures.dart';

/// Plan 4, Task 2: the mentor workspace's DTOs on the QA mentor's recorded
/// dev responses (`api/dashboard/mentor/`).
void main() {
  test('overview scopes parse with their metrics', () {
    final scopes = ((loadFixtureResponse('dev/mentor_overview')! as Map)['scopes'] as List)
        .map((j) => MentorScopeDto.fromJson(j as Map<String, dynamic>).toDomain())
        .toList();

    expect(scopes, hasLength(1));
    final s = scopes.single;
    expect(s.type, MentorScopeType.igMentor);
    expect(s.name, 'Web Development');
    expect(s.metrics.totalIgLearners, 6);
    expect(s.metrics.activeIgLearners, 6);
    expect(s.metrics.upcomingSessions, 2);
    expect(s.metrics.igLearningCircles, 3);
  });

  test('scope types map from the backend values; unknown ones are kept as unknown', () {
    MentorScopeType type(String wire) =>
        MentorScopeDto.fromJson({'scope_type': wire, 'scope_id': 'x', 'scope_name': 'X', 'metrics': <String, dynamic>{}})
            .toDomain()
            .type;
    expect(type('IG_MENTOR'), MentorScopeType.igMentor);
    expect(type('CAMPUS_MENTOR'), MentorScopeType.campusMentor);
    expect(type('COMPANY_MENTOR'), MentorScopeType.companyMentor);
    expect(type('MENTOR'), MentorScopeType.global);
    expect(type('SOMETHING_NEW'), MentorScopeType.unknown);
  });

  test('personal analytics parse, with no rating yet', () {
    final a = MentorAnalyticsDto.fromJson(loadFixtureResponse('dev/mentor_analytics')! as Map<String, dynamic>).toDomain();

    expect(a.sessionsTotal, 2);
    expect(a.sessionsUpcoming, 2);
    expect(a.sessionsCompleted, 0);
    expect(a.karmaEarned, 0);
    expect(a.ratingAverage, isNull);
    expect(a.ratingCount, 0);
  });

  test('profile completion parses its checklist', () {
    final c = MentorProfileCompletionDto.fromJson(
      loadFixtureResponse('dev/mentor_profile_completion')! as Map<String, dynamic>,
    ).toDomain();

    expect(c.percentage, 75);
    expect(c.checklist, {'about': true, 'expertise': true, 'linkedin': false, 'preferred_igs': true});
  });

  test('a session parses its enums and UTC times', () {
    final rows = (loadFixtureResponse('dev/mentor_sessions_scheduled')! as Map)['data'] as List;
    final s = MentorSessionDto.fromJson(rows.first as Map<String, dynamic>).toDomain();

    expect(s.title, 'Office hours: debugging your first Flutter app');
    expect(s.type, SessionType.igSession);
    expect(s.mode, SessionMode.online);
    expect(s.status, SessionStatus.scheduled);
    expect(s.startsAt, DateTime.utc(2026, 11, 20, 12, 30));
    expect(s.endsAt, DateTime.utc(2026, 11, 20, 13, 30));
    expect(s.meetingLink, startsWith('https://meet.google.com/'));
    expect(s.venue, isNull);
    expect(s.entityName, 'Web Development');
  });

  test('the session detail has the list shape', () {
    final s = MentorSessionDto.fromJson(loadFixtureResponse('dev/mentor_session_detail')! as Map<String, dynamic>).toDomain();
    expect(s.id, '282426eb-7650-45da-bbf1-905fe1835115');
  });

  test('enums keep unknown backend values as unknown', () {
    expect(SessionStatus.fromWire('PENDING_APPROVAL'), SessionStatus.pendingApproval);
    expect(SessionStatus.fromWire('ARCHIVED'), SessionStatus.unknown);
    expect(SessionMode.fromWire('HYBRID'), SessionMode.hybrid);
    expect(SessionMode.fromWire(null), SessionMode.unknown);
    expect(SessionType.fromWire('COMPANY_SESSION').wire, 'COMPANY_SESSION');
  });

  test('session times read as day, date and time', () {
    expect(formatDayTime(DateTime(2026, 11, 20, 18)), 'Fri 20 Nov · 6:00 PM');
    expect(formatDayTime(DateTime(2026, 1, 5, 0, 5)), 'Mon 5 Jan · 12:05 AM');
    expect(formatTime(DateTime(2026, 1, 5, 12, 30)), '12:30 PM');
  });
}
