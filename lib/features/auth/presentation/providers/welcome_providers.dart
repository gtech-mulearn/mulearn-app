import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/features/auth/data/datasources/welcome_remote_datasource.dart';
import 'package:mulearn_app/features/auth/domain/entities/public_community.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'welcome_providers.g.dart';

@riverpod
WelcomeRemoteDataSource welcomeRemoteDataSource(Ref ref) => WelcomeRemoteDataSource(ref.watch(dioProvider));

/// Community counts for the arrival beats and the Commons.
@riverpod
Future<PublicStats> publicStats(Ref ref) => ref.watch(welcomeRemoteDataSourceProvider).fetchStats();

/// Featured events, for the "Then show up" beat and the Commons.
@riverpod
Future<List<GuestEvent>> guestFeaturedEvents(Ref ref) =>
    ref.watch(welcomeRemoteDataSourceProvider).fetchFeaturedEvents();

/// Every Interest Group's name, for the ring that bursts into stickers.
@riverpod
Future<List<GuestInterestGroup>> guestInterestGroups(Ref ref) =>
    ref.watch(welcomeRemoteDataSourceProvider).fetchInterestGroups();

/// Whether this device has seen the arrival beats. Not a secret, but the
/// app already keeps one small store, so it lives in secure storage.
@Riverpod(keepAlive: true)
class ArrivalSeen extends _$ArrivalSeen {
  static const _key = 'arrival_seen';

  @override
  Future<bool> build() async => (await ref.watch(secureStorageProvider).read(key: _key)) == '1';

  Future<void> markSeen() async {
    state = const AsyncData(true);
    await ref.read(secureStorageProvider).write(key: _key, value: '1');
  }
}
