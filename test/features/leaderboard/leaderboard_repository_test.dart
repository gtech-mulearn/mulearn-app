import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/features/leaderboard/data/datasources/leaderboard_remote_datasource.dart';
import 'package:mulearn_app/features/leaderboard/data/repositories/leaderboard_repository_impl.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fixtures.dart';

void main() {
  test('a student without a college stays on the board (was silently skipped)', () async {
    final repo = LeaderboardRepositoryImpl(LeaderboardRemoteDataSource(
      fakeDio(FakeHttpAdapter({
        'GET /api/v1/leaderboard/students/': (_) =>
            FakeResponse(200, loadFixture('serializer/students_leaderboard')),
      })),
      CacheOptions(store: MemCacheStore(), policy: CachePolicy.noCache),
    ));

    final entries = await repo.getStudentLeaderboard(monthly: false);

    expect(entries, hasLength(3));
    expect(entries.last.institution, isNull);
    expect(entries.last.muid, 'fixture-c@mulearn');
  });
}
