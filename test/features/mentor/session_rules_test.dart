import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_session.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_enums.dart';
import 'package:mulearn_app/features/mentor/domain/session_rules.dart';

/// When Join shows: an online or hybrid scheduled session with a link, from
/// 15 minutes before it starts until it ends.
void main() {
  final starts = DateTime.utc(2026, 11, 20, 12, 30);
  MentorSession session({
    SessionMode mode = SessionMode.online,
    String? link = 'https://meet.example/x',
    SessionStatus status = SessionStatus.scheduled,
  }) =>
      MentorSession(
        id: 's',
        entityId: 'ig',
        entityName: 'Web Development',
        type: SessionType.igSession,
        title: 'Office hours',
        description: '',
        mode: mode,
        startsAt: starts,
        endsAt: starts.add(const Duration(hours: 1)),
        status: status,
        isRecurring: false,
        meetingLink: link,
      );

  test('join opens 15 minutes before the start and closes at the end', () {
    expect(canJoinSession(session(), starts.subtract(const Duration(minutes: 16))), isFalse);
    expect(canJoinSession(session(), starts.subtract(const Duration(minutes: 15))), isTrue);
    expect(canJoinSession(session(), starts.add(const Duration(minutes: 59))), isTrue);
    expect(canJoinSession(session(), starts.add(const Duration(hours: 1))), isFalse);
  });

  test('no join without a link, in person, or once it is not scheduled', () {
    final live = starts.add(const Duration(minutes: 5));
    expect(canJoinSession(session(link: null), live), isFalse);
    expect(canJoinSession(session(mode: SessionMode.offline), live), isFalse);
    expect(canJoinSession(session(mode: SessionMode.hybrid), live), isTrue);
    expect(canJoinSession(session(status: SessionStatus.completed), live), isFalse);
  });

  test('a session has started from its start time', () {
    expect(hasStarted(session(), starts.subtract(const Duration(seconds: 1))), isFalse);
    expect(hasStarted(session(), starts), isTrue);
  });
}
