import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/features/mentor/data/dtos/persona_dto.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_scope.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fixtures.dart';
import 'mentor_test_support.dart';

const _status = '$mentorBase/persona/status/';
const _switch = '$mentorBase/persona/switch/';
const _ig = '4ff0a5e5-d1ef-44dd-ac13-9a2f9e7717e3';

/// Plan 4, Task 7 (M6): which scope the mentor is acting in, or learner.
/// The backend gates nothing on it; it picks the default for new sessions.
void main() {
  late FakeHttpAdapter adapter;

  Map<String, dynamic> statusAs({required String persona, String? type, String? id, String? name}) => okEnvelope({
        'active_persona': persona,
        'active_scope_type': type,
        'active_scope_id': id,
        'active_scope_name': name,
      });

  setUp(() {
    adapter = mentorAdapter();
    adapter.routes['GET $_status'] = (_) => FakeResponse(200, loadFixture('dev/mentor_persona_status'));
    adapter.routes['POST $_switch'] = (_) => FakeResponse(200, okEnvelope(<String, dynamic>{}, message: 'Persona switched.'));
  });

  Map<String, dynamic> lastSwitch() {
    final r = adapter.requests.lastWhere((RequestOptions r) => r.method == 'POST' && r.uri.path == _switch);
    return (r.data is String ? jsonDecode(r.data as String) : r.data) as Map<String, dynamic>;
  }

  Future<void> drainToast(WidgetTester tester) => tester.pump(const Duration(seconds: 4));

  test('the recorded status parses: acting as a learner', () {
    final p = PersonaDto.fromJson(loadFixtureResponse('dev/mentor_persona_status')! as Map<String, dynamic>).toDomain();
    expect(p.isMentor, isFalse);
    expect(p.scopeId, isNull);

    final m = PersonaDto.fromJson({
      'active_persona': 'mentor',
      'active_scope_type': 'IG_MENTOR',
      'active_scope_id': _ig,
      'active_scope_name': 'Web Development',
    }).toDomain();
    expect((m.isMentor, m.scopeType, m.scopeId, m.scopeName), (true, MentorScopeType.igMentor, _ig, 'Web Development'));
  });

  testWidgets('the hub says who you are acting as', (tester) async {
    await pumpMentor(tester, adapter, '/mentor');
    expect(find.text('Acting as a learner'), findsOneWidget);
  });

  testWidgets('choosing a scope switches to it', (tester) async {
    await pumpMentor(tester, adapter, '/mentor');

    await tester.tap(find.text('Acting as a learner'));
    await settleMentor(tester);
    await tester.tap(find.descendant(of: find.byType(BottomSheet), matching: find.text('Web Development')));
    await settleMentor(tester);

    expect(lastSwitch(), {'persona': 'mentor', 'scope_type': 'IG_MENTOR', 'scope_id': _ig});
    expect(find.text('Acting as Web Development'), findsOneWidget);
    await drainToast(tester);
  });

  testWidgets('choosing Learner switches back', (tester) async {
    adapter.routes['GET $_status'] =
        (_) => FakeResponse(200, statusAs(persona: 'mentor', type: 'IG_MENTOR', id: _ig, name: 'Web Development'));
    await pumpMentor(tester, adapter, '/mentor');

    await tester.tap(find.text('Acting as Web Development'));
    await settleMentor(tester);
    await tester.tap(find.text('Learner'));
    await settleMentor(tester);

    expect(lastSwitch(), {'persona': 'learner'});
    expect(find.text('Acting as a learner'), findsOneWidget);
    await drainToast(tester);
  });

  testWidgets('a refused switch keeps the label and says why', (tester) async {
    adapter.routes['POST $_switch'] = (_) => FakeResponse(400, loadFixture('dev/mentor_persona_switch_refused'));
    await pumpMentor(tester, adapter, '/mentor');

    await tester.tap(find.text('Acting as a learner'));
    await settleMentor(tester);
    await tester.tap(find.descendant(of: find.byType(BottomSheet), matching: find.text('Web Development')));
    await settleMentor(tester);

    expect(find.text('Acting as a learner'), findsOneWidget);
    expect(find.text('You do not hold an active mentor grant for the requested scope.'), findsOneWidget);
    await drainToast(tester);
  });

  testWidgets('a new session starts in the scope you act in', (tester) async {
    adapter.routes['GET $mentorBase/overview/'] = (_) => FakeResponse(
          200,
          okEnvelope({
            'scopes': [
              {'scope_type': 'IG_MENTOR', 'scope_id': 'ig-a', 'scope_name': 'AI', 'metrics': <String, dynamic>{}},
              {'scope_type': 'IG_MENTOR', 'scope_id': _ig, 'scope_name': 'Web Development', 'metrics': <String, dynamic>{}},
            ],
          }),
        );
    adapter.routes['GET $_status'] =
        (_) => FakeResponse(200, statusAs(persona: 'mentor', type: 'IG_MENTOR', id: _ig, name: 'Web Development'));
    await pumpMentor(tester, adapter, '/mentor/sessions/new');

    final where = tester.widget<DropdownButtonFormField<Object?>>(find.byWidgetPredicate((w) => w is DropdownButtonFormField));
    expect(where.initialValue.toString(), contains(_ig));
  });
}
