import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/features/weekly_twitches/data/weekly_twitches_data.dart';
import 'package:mulearn_app/features/weekly_twitches/domain/entities/twitch.dart';
import 'package:mulearn_app/features/weekly_twitches/presentation/screens/twitch_detail_screen.dart';
import 'package:mulearn_app/features/weekly_twitches/presentation/screens/weekly_twitches_screen.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';

const _base = '/api/v1/dashboard/media-content';

// Dev had no episodes on 2026-11-15 (see the recorded empty list fixture), so
// these rows are SYNTHETIC, built field for field from the read serializers in
// `api/dashboard/media_content/serializers.py` (origin/dev).
Map<String, dynamic> _officeHours({
  required String id,
  required String title,
  required String date,
  required String status,
  String? time = '18:30:00',
}) => {
  'id': id,
  'title': title,
  'performer': 'Asha Menon',
  'designation': 'Staff Engineer',
  'description': 'How a backend team ships every day.',
  'date': date,
  'time': time,
  'link': 'https://meet.example.org/oh',
  'interest_groups': ['Web Development'],
  'poster_thumbnail': null,
  'status': status,
  'created_at': '2026-11-01T10:00:00Z',
  'updated_at': '2026-11-01T10:00:00Z',
};

Map<String, dynamic> _page(
  List<Map<String, dynamic>> rows, {
  bool isNext = false,
}) => {
  'hasError': false,
  'statusCode': 200,
  'message': {'general': <String>[]},
  'response': {
    'data': rows,
    'pagination': {
      'count': rows.length,
      'totalPages': 1,
      'isNext': isNext,
      'isPrev': false,
      'nextPage': null,
    },
  },
};

void main() {
  test('episodes parse from both campus-show and office-hours shapes', () {
    final smt = WeeklyTwitchesRepositoryImpl.parse(TwitchShow.saltMangoTree, {
      'id': 's1',
      'topic': 'Building a maker space',
      'campus': 'CET Trivandrum',
      'zone': 'south',
      'date': '2026-11-20',
      'time': '19:00:00',
      'status': 'upcoming',
    })!;
    expect(smt.title, 'Building a maker space');
    expect(smt.zone, 'South');
    expect(smt.startsAt, DateTime(2026, 11, 20, 19));

    final oh = WeeklyTwitchesRepositoryImpl.parse(
      TwitchShow.officeHours,
      _officeHours(
        id: 'o1',
        title: 'Shipping daily',
        date: '21/11/2026',
        status: 'ongoing',
        time: null,
      ),
    )!;
    expect(oh.date, DateTime(2026, 11, 21));
    expect(oh.time, isNull);
    expect(oh.status, TwitchStatus.ongoing);
    expect(oh.speaker, 'Asha Menon · Staff Engineer');
    expect(oh.interestGroups, ['Web Development']);

    expect(
      WeeklyTwitchesRepositoryImpl.parse(TwitchShow.officeHours, {
        'id': 'x',
        'date': 'soon',
      }),
      isNull,
    );

    final empty = WeeklyTwitchesRepositoryImpl.parsePage(
      TwitchShow.officeHours,
      loadFixtureResponse('dev/weekly_twitches_office_hours_empty')!
          as Map<String, dynamic>,
    );
    expect(empty.items, isEmpty);
    expect(empty.hasNext, isFalse);
  });

  late FakeHttpAdapter adapter;

  setUp(() {
    adapter = FakeHttpAdapter({
      'GET $_base/office-hours/': (RequestOptions r) => FakeResponse(
        200,
        r.queryParameters['status'] == 'completed'
            ? _page([
                _officeHours(
                  id: 'p1',
                  title: 'Your first open-source PR',
                  date: '2026-11-01',
                  status: 'completed',
                ),
              ])
            : _page([
                _officeHours(
                  id: 'u2',
                  title: 'Later talk',
                  date: '2026-11-28',
                  status: 'upcoming',
                ),
                _officeHours(
                  id: 'u1',
                  title: 'Shipping daily',
                  date: '2026-11-15',
                  status: 'ongoing',
                ),
              ]),
      ),
      'GET $_base/office-hours/u1/': (_) => FakeResponse(200, {
        'hasError': false,
        'statusCode': 200,
        'message': {'general': <String>[]},
        'response': _officeHours(
          id: 'u1',
          title: 'Shipping daily',
          date: '2026-11-15',
          status: 'ongoing',
        ),
      }),
      'GET $_base/salt-mango-tree/': (_) => FakeResponse(200, _page(const [])),
    });
  });

  Future<void> pump(WidgetTester tester) async {
    final tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        dioProvider.overrideWithValue(fakeDio(adapter)),
        tokenStorageProvider.overrideWithValue(tokens),
      ],
    );
    addTearDown(container.dispose);
    final router = GoRouter(
      initialLocation: '/weekly-twitches',
      routes: [
        GoRoute(
          path: '/weekly-twitches',
          builder: (_, _) => const WeeklyTwitchesScreen(),
        ),
        GoRoute(
          path: '/weekly-twitches/:show/:id',
          builder: (_, s) => TwitchDetailScreen(
            show: TwitchShow.from(s.pathParameters['show'])!,
            id: s.pathParameters['id']!,
          ),
        ),
      ],
    );
    addTearDown(router.dispose);
    tester.view.physicalSize = const Size(1080, 4000);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          theme: MuThemeData.light(),
          routerConfig: router,
        ),
      ),
    );
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
  }

  testWidgets(
    'a show lists what is coming up soonest first, then past episodes',
    (tester) async {
      await pump(tester);

      final soon = tester.getTopLeft(find.text('Shipping daily'));
      final later = tester.getTopLeft(find.text('Later talk'));
      final past = tester.getTopLeft(find.text('Your first open-source PR'));
      expect(soon.dy, lessThan(later.dy), reason: 'soonest first');
      expect(later.dy, lessThan(past.dy), reason: 'past episodes after');
      expect(find.text('Today'), findsOneWidget);

      final sent = adapter.requests
          .map((r) => r.queryParameters['status'])
          .toSet();
      expect(sent, {'upcoming,ongoing', 'completed'});

      await tester.tap(find.text('Salt Mango Tree'));
      for (var i = 0; i < 6; i++) {
        await tester.pump(const Duration(milliseconds: 50));
      }
      expect(find.textContaining('Nothing announced yet'), findsOneWidget);
      expect(find.text('No past episodes yet.'), findsOneWidget);
    },
  );

  testWidgets('an episode shows who and when, and Join now on the day', (
    tester,
  ) async {
    await pump(tester);
    await tester.tap(find.text('Shipping daily'));
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
    expect(find.byType(TwitchDetailScreen), findsOneWidget);
    expect(find.text('Asha Menon'), findsWidgets);
    expect(find.text('Staff Engineer'), findsOneWidget);
    expect(find.text('Web Development'), findsOneWidget);
    expect(find.widgetWithText(MuButton, 'Join now'), findsOneWidget);
  });
}
