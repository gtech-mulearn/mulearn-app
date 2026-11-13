import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/features/dashboard/data/dtos/learner_summary_dto.dart';

import '../../support/fixtures.dart';

/// GET /api/v1/dashboard/home/learner/summary/ (LearnerDashboardSummaryAPIView).
void main() {
  test('the recorded summary parses, with its next meeting', () {
    final json = loadFixtureResponse('dev/learner_summary')! as Map<String, dynamic>;
    final stats = json['stats'] as Map<String, dynamic>;
    final meeting = json['next_meeting'] as Map<String, dynamic>;

    final s = LearnerSummaryDto.fromJson(json).toDomain();

    expect(s.weeklyKarma, stats['weekly_karma']);
    expect(s.streakDays, stats['streak_days']);
    expect(s.activeCircles, stats['active_circles']);
    expect(s.nextMeeting!.id, meeting['id']);
    expect(s.nextMeeting!.circleName, meeting['circle_name']);
    expect(s.nextMeeting!.startsAt, DateTime.parse(meeting['starts_at'] as String));
    expect(s.nextMeeting!.startsAt.isUtc, isTrue);
  });

  test('no upcoming meeting is null, not an error', () {
    final json = loadFixtureResponse('serializer/learner_summary_no_meeting')! as Map<String, dynamic>;

    expect(LearnerSummaryDto.fromJson(json).toDomain().nextMeeting, isNull);
  });
}
