import 'dart:io';

import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mulearn_app/core/storage/cache_store_factory.dart';

void main() {
  late Directory temp;

  setUp(() => temp = Directory.systemTemp.createTempSync('mu_cache_test'));
  tearDown(() async {
    await Hive.close();
    temp.deleteSync(recursive: true);
  });

  test("falls back to a memory store when the directory can't be resolved", () async {
    final store = await openCacheStore(directory: () async => throw const FileSystemException('no dir'));

    expect(store, isA<MemCacheStore>());
  });

  test("falls back to a memory store when the directory exists but can't hold the cache", () async {
    // A path that is a file, not a directory: Hive can't create its box there.
    final notADirectory = File('${temp.path}/not_a_dir')..writeAsStringSync('x');

    final store = await openCacheStore(directory: () async => Directory(notADirectory.path));

    expect(store, isA<MemCacheStore>());
    expect(await store.get('anything'), isNull, reason: 'the fallback store works');
  });

  test('opens the persistent store in a usable directory', () async {
    final store = await openCacheStore(directory: () async => temp);

    expect(store, isA<HiveCacheStore>());
    expect(await store.get('anything'), isNull);
  });
}
