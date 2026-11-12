import 'dart:io';

import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/storage/cache_store_factory.dart';

void main() {
  test("falls back to a memory store when the directory can't be opened", () async {
    final store = await openCacheStore(directory: () async => throw const FileSystemException('no dir'));

    expect(store, isA<MemCacheStore>());
  });
}
