import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/data/location_remote_datasource.dart';
import 'package:mulearn_app/core/models/reference_option.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/features/auth/data/datasources/register_remote_datasource.dart';
import 'package:mulearn_app/features/auth/data/repositories/register_repository_impl.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';

Map<String, dynamic> _ok(Object response) => {
  'hasError': false,
  'statusCode': 200,
  'message': {'general': <String>[]},
  'response': response,
};

/// The sign-up lookups a learner's School / Community pick needs.
void main() {
  late FakeHttpAdapter adapter;
  late RegisterRepositoryImpl repository;

  setUp(() {
    adapter = FakeHttpAdapter({});
    final dio = fakeDio(adapter);
    repository = RegisterRepositoryImpl(
      remote: RegisterRemoteDataSource(dio),
      locationRemote: LocationRemoteDataSource(dio),
      tokenStorage: TokenStorage(FakeSecureStorage()),
    );
  });

  test('searchDistricts sends q and maps location to title', () async {
    adapter.routes['GET /api/v1/register/location/'] = (_) => FakeResponse(
      200,
      _ok([
        {'id': 'd1', 'location': 'Kottayam, Kerala, India'},
      ]),
    );

    final found = await repository.searchDistricts('kott');

    expect(found, const [
      ReferenceOption(id: 'd1', title: 'Kottayam, Kerala, India'),
    ]);
    expect(adapter.requests.single.uri.queryParameters['q'], 'kott');
  });

  test('fetchCommunities maps the community list', () async {
    adapter.routes['GET /api/v1/register/community/list/'] = (_) =>
        FakeResponse(
          200,
          _ok({
            'communities': [
              {'id': 'c1', 'title': 'Flutter Kerala'},
            ],
          }),
        );

    final communities = await repository.fetchCommunities();

    expect(communities, const [
      ReferenceOption(id: 'c1', title: 'Flutter Kerala'),
    ]);
  });

  test('fetchSchools posts the district', () async {
    adapter.routes['POST /api/v1/register/schools/list/'] = (_) => FakeResponse(
      200,
      _ok({
        'schools': [
          {'id': 's1', 'title': 'Govt HSS Palai'},
        ],
      }),
    );

    final schools = await repository.fetchSchools('d1');

    expect(schools, const [ReferenceOption(id: 's1', title: 'Govt HSS Palai')]);
    expect(adapter.requests.single.data, {'district': 'd1'});
  });

  test('a failed lookup throws ApiException', () async {
    adapter.routes['GET /api/v1/register/community/list/'] = (_) =>
        const FakeResponse(500, {
          'hasError': true,
          'statusCode': 500,
          'message': {
            'general': ['Server error'],
          },
          'response': <String, dynamic>{},
        });

    await expectLater(
      repository.fetchCommunities(),
      throwsA(isA<ApiException>()),
    );
  });
}
