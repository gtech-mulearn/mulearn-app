import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/features/mentor/data/dtos/availability_slot_dto.dart';
import 'package:mulearn_app/features/mentor/domain/availability_rules.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fixtures.dart';
import 'mentor_test_support.dart';

const _list = '$mentorBase/availability/';
const _slotId = 'e5f98e0b-6605-46ab-9fe0-f264424ce104';
const _slot = '$mentorBase/availability/$_slotId/';

/// Plan 4, Task 6 (M5): weekly availability slots.
void main() {
  late FakeHttpAdapter adapter;

  setUp(() {
    adapter = mentorAdapter();
    adapter.routes['GET $_list'] = (_) => FakeResponse(200, loadFixture('dev/mentor_availability_list'));
  });

  Map<String, dynamic> bodyOf(String method, String path) {
    final r = adapter.requests.lastWhere((RequestOptions r) => r.method == method && r.uri.path == path);
    return (r.data is String ? jsonDecode(r.data as String) : r.data) as Map<String, dynamic>;
  }

  Future<void> drainToast(WidgetTester tester) => tester.pump(const Duration(seconds: 4));

  test('a recorded slot parses', () {
    final row = ((loadFixtureResponse('dev/mentor_availability_list')! as Map)['data'] as List).first;
    final s = AvailabilitySlotDto.fromJson(row as Map<String, dynamic>).toDomain();
    expect(s.id, _slotId);
    expect(s.weekday, 3);
    expect((s.startMinutes, s.endMinutes), (18 * 60, 19 * 60));
    expect(s.igName, 'Web Development');
    expect(s.timezone, 'Asia/Kolkata');
    expect(s.isActive, isTrue);
  });

  test('times read and write as the backend expects', () {
    expect(parseClock('18:00:00'), 1080);
    expect(parseClock('07:05'), 425);
    expect(formatClock(425), '07:05');
    expect(clockLabel(1080), '6:00 PM');
    expect(weekdayName(1), 'Monday');
    expect(weekdayName(7), 'Sunday');
  });

  group('SlotInput', () {
    const base = SlotInput(weekday: 3, startMinutes: 600, endMinutes: 660, timezone: 'Asia/Kolkata');

    test('sends HH:MM, the zone and the group only when chosen', () {
      expect(base.toJson(), {'weekday': 3, 'start_time': '10:00', 'end_time': '11:00', 'timezone': 'Asia/Kolkata', 'is_active': true});
      expect(base.copyWith(igId: 'ig1').toJson()['ig'], 'ig1');
    });

    test('end at or before start is refused in the backend words', () {
      expect(base.copyWith(endMinutes: 600).problem(), 'Start time must be before end time.');
      expect(base.problem(), isNull);
    });

    test('an overlapping slot on the same day is pointed out', () {
      final existing = AvailabilitySlotDto.fromJson(
        ((loadFixtureResponse('dev/mentor_availability_list')! as Map)['data'] as List).first as Map<String, dynamic>,
      ).toDomain();
      final overlapping = base.copyWith(startMinutes: 18 * 60 + 30, endMinutes: 19 * 60 + 30);
      expect(overlapping.overlapWith([existing]), existing);
      expect(overlapping.copyWith(weekday: 4).overlapWith([existing]), isNull);
      expect(overlapping.overlapWith([existing], editingId: existing.id), isNull);
      expect(base.copyWith(startMinutes: 19 * 60, endMinutes: 20 * 60).overlapWith([existing]), isNull,
          reason: 'touching ends do not overlap');
    });
  });

  testWidgets('slots group under their weekday with the time, group and zone', (tester) async {
    await pumpMentor(tester, adapter, '/mentor/availability');

    expect(find.text('WEDNESDAY'), findsOneWidget);
    expect(find.text('6:00 PM – 7:00 PM'), findsOneWidget);
    expect(find.text('Web Development · Asia/Kolkata'), findsOneWidget);
  });

  testWidgets('the switch pauses a slot at once and keeps it if refused', (tester) async {
    adapter.routes['PATCH $_slot'] = (_) => const FakeResponse(403, {
          'hasError': true,
          'statusCode': 403,
          'message': {'general': ['Your mentor account is deactivated. Please contact an administrator.']},
          'response': <String, dynamic>{},
        });
    await pumpMentor(tester, adapter, '/mentor/availability');

    await tester.tap(find.byType(Switch));
    await settleMentor(tester);

    expect(bodyOf('PATCH', _slot), {'is_active': false});
    expect(tester.widget<Switch>(find.byType(Switch)).value, isTrue, reason: 'rolled back');
    expect(find.text('Your mentor account is deactivated. Please contact an administrator.'), findsOneWidget);
    await drainToast(tester);
  });

  testWidgets('add a slot: pick the day, save', (tester) async {
    adapter.routes['POST $_list'] = (_) => FakeResponse(200, okEnvelope(<String, dynamic>{}, message: 'Availability slot created successfully.'));
    await pumpMentor(tester, adapter, '/mentor/availability');

    await tester.tap(find.text('Add slot'));
    await settleMentor(tester);
    await tester.tap(find.text('Mon'));
    await tester.pump();
    await tester.tap(find.text('Save'));
    await settleMentor(tester);

    expect(bodyOf('POST', _list), {
      'weekday': 1,
      'start_time': '10:00',
      'end_time': '11:00',
      'timezone': 'Asia/Kolkata',
      'is_active': true,
    });
    await drainToast(tester);
  });

  testWidgets("the backend's zone error shows under the zone", (tester) async {
    adapter.routes['POST $_list'] = (_) => FakeResponse(400, loadFixture('dev/mentor_availability_bad_tz'));
    await pumpMentor(tester, adapter, '/mentor/availability');

    await tester.tap(find.text('Add slot'));
    await settleMentor(tester);
    await tester.tap(find.text('Save'));
    await settleMentor(tester);

    expect(find.text('Enter a valid IANA timezone name (e.g. Asia/Kolkata).'), findsOneWidget);
  });

  testWidgets('a slot opens to edit, and can be deleted after a confirm', (tester) async {
    adapter.routes['DELETE $_slot'] = (_) => FakeResponse(200, okEnvelope(<String, dynamic>{}, message: 'Availability slot deleted successfully.'));
    await pumpMentor(tester, adapter, '/mentor/availability');

    await tester.tap(find.text('6:00 PM – 7:00 PM'));
    await settleMentor(tester);
    expect(find.text('Edit slot'), findsOneWidget);
    await tester.tap(find.text('Delete slot'));
    await settleMentor(tester);
    expect(find.text('Delete this slot?'), findsOneWidget);
    await tester.tap(find.descendant(of: find.byType(AlertDialog), matching: find.widgetWithText(TextButton, 'Delete')));
    await settleMentor(tester);

    expect(adapter.requests.where((RequestOptions r) => r.method == 'DELETE'), hasLength(1));
    await drainToast(tester);
  });

  testWidgets('no slots shows the dashboard copy with the illustration', (tester) async {
    adapter.routes['GET $_list'] = (_) => FakeResponse(200, pagedEnvelope(const []));
    await pumpMentor(tester, adapter, '/mentor/availability');

    expect(find.byType(MuStateDisplay), findsOneWidget);
    expect(find.text('No availability set.'), findsOneWidget);
  });

  testWidgets('the hub opens availability', (tester) async {
    await pumpMentor(tester, adapter, '/mentor');

    await tester.tap(find.text('Weekly availability'));
    await settleMentor(tester);
    expect(find.text('Add slot'), findsOneWidget);
  });
}
