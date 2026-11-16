import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/features/interest_groups/data/datasources/interest_groups_remote_datasource.dart';
import 'package:mulearn_app/features/interest_groups/data/repositories/interest_groups_repository_impl.dart';

import '../../support/fake_http_adapter.dart';

/// A group page shows its first circles and events, and the count of all of
/// them (production groups have thousands of circles) for "See all".
void main() {
  Map<String, dynamic> page(List<Map<String, Object>> rows, int count) => {
    'hasError': false,
    'statusCode': 200,
    'message': {'general': <String>[]},
    'response': {
      'data': rows,
      'pagination': {'count': count, 'totalPages': 248, 'isNext': true},
    },
  };

  test('circles: the first five, and how many in all', () async {
    final adapter = FakeHttpAdapter({
      'GET /api/v1/dashboard/learningcircle/list/': (r) {
        expect(r.queryParameters['ig'], 'ig1');
        expect('${r.queryParameters['perPage']}', '5');
        return FakeResponse(
          200,
          page([
            for (var i = 0; i < 5; i++)
              {'id': 'c$i', 'title': 'Circle $i', 'total_members': 4},
          ], 1240),
        );
      },
    });
    final preview = await InterestGroupsRepositoryImpl(
      InterestGroupsRemoteDataSource(fakeDio(adapter)),
    ).getCirclesInGroup('ig1');
    expect(preview.items, hasLength(5));
    expect(preview.total, 1240);
  });

  test('events: no pagination falls back to what came', () async {
    final adapter = FakeHttpAdapter({
      'GET /api/v1/dashboard/events/': (_) => const FakeResponse(200, {
        'hasError': false,
        'statusCode': 200,
        'message': {'general': <String>[]},
        'response': {
          'data': [
            {'id': 'e1', 'title': 'Hack night'},
          ],
        },
      }),
    });
    final preview = await InterestGroupsRepositoryImpl(
      InterestGroupsRemoteDataSource(fakeDio(adapter)),
    ).getEventsInGroup('ig1');
    expect(preview.total, 1);
  });
}
