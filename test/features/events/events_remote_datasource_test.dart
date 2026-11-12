import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/features/events/data/datasources/events_remote_datasource.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fixtures.dart';

void main() {
  test('fetchEvents sends pageIndex/perPage, never page', () async {
    final adapter = FakeHttpAdapter({
      'GET /api/v1/dashboard/events/': (_) => FakeResponse(200, loadFixture('dev/events_page1')),
    });
    final datasource = EventsRemoteDataSource(fakeDio(adapter));

    await datasource.fetchEvents(pageIndex: 2);

    final query = adapter.requests.single.queryParameters;
    expect(query, {'pageIndex': 2, 'perPage': 20});
    expect(query.containsKey('page'), isFalse);
  });

  test('fetchEvents returns the data/pagination payload recorded on dev', () async {
    final datasource = EventsRemoteDataSource(fakeDio(FakeHttpAdapter({
      'GET /api/v1/dashboard/events/': (_) => FakeResponse(200, loadFixture('dev/events_page1')),
    })));

    final payload = await datasource.fetchEvents(pageIndex: 1);

    expect(payload['data'], isA<List<dynamic>>());
    expect(payload['pagination'], containsPair('isNext', isA<bool>()));
  });
}
