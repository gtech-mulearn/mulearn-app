import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/features/calendar/data/datasources/calendar_remote_datasource.dart';
import 'package:mulearn_app/features/calendar/data/repositories/calendar_repository_impl.dart';
import 'package:mulearn_app/features/calendar/domain/entities/calendar_entry_kind.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fixtures.dart';

const _calendar = 'GET /api/v1/dashboard/calendar/events/';

CalendarRepositoryImpl repoServing(String fixture) => CalendarRepositoryImpl(
      CalendarRemoteDataSource(fakeDio(FakeHttpAdapter({
        _calendar: (_) => FakeResponse(200, loadFixture(fixture)),
      }))),
    );

void main() {
  final start = DateTime(2026, 11);
  final end = DateTime(2026, 11, 30);

  test('mentor sessions parse from their own shape (starts_at/ends_at)', () async {
    final entries = await repoServing('serializer/calendar_with_sessions')
        .getEntries(start: start, end: end);

    final sessions = entries.where((e) => e.kind == CalendarEntryKind.session).toList();
    expect(sessions, hasLength(1), reason: 'the malformed session is skipped, not fatal');
    expect(sessions.single.id, 's1');
    expect(sessions.single.start, '2026-11-18T16:00:00+05:30');
    expect(sessions.single.end, '2026-11-18T17:00:00+05:30');
    expect(sessions.single.organiserName, 'Fixture User');
    expect(sessions.single.venueType, 'online');
  });

  test('events still parse alongside sessions', () async {
    final entries = await repoServing('serializer/calendar_with_sessions')
        .getEntries(start: start, end: end);

    final events = entries.where((e) => e.kind == CalendarEntryKind.event).toList();
    expect(events.single.id, 'e1');
    expect(events.single.start, '2026-11-21T10:00:00+05:30');
  });

  test('the calendar recorded on dev for a student parses with no sessions', () async {
    final entries = await repoServing('dev/calendar_student').getEntries(start: start, end: end);
    final buckets = (loadFixture('dev/calendar_student')['response'] as Map<String, dynamic>)['events']
        as Map<String, dynamic>;
    final recordedEvents = buckets.values.fold<int>(0, (n, b) => n + (b as List<dynamic>).length);

    expect(recordedEvents, greaterThan(0), reason: 'seeded dev has events this month');
    expect(entries.where((e) => e.kind == CalendarEntryKind.event), hasLength(recordedEvents));
    expect(entries.where((e) => e.kind == CalendarEntryKind.session), isEmpty);
  });

  test("a mentor's sessions recorded on dev use the same lowercase vocabulary as events", () async {
    final entries = await repoServing('dev/calendar_mentor').getEntries(start: start, end: end);

    final sessions = entries.where((e) => e.kind == CalendarEntryKind.session).toList();
    expect(sessions, hasLength(2));
    expect(sessions.map((s) => s.venueType), unorderedEquals(['online', 'offline']));
    expect(sessions.map((s) => s.status), everyElement('scheduled'));
    expect(sessions.map((s) => s.organiserName), everyElement(isNotNull));
  });
}
