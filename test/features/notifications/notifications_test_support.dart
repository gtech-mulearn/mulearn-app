import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/core/utils/clock.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';

const feedPath = '/api/v1/notification/';
const unreadPath = '/api/v1/notification/unread-count/';
const readAllPath = '/api/v1/notification/read-all/';
String readPath(String id) => '/api/v1/notification/$id/read/';
String archivePath(String id) => '/api/v1/notification/$id/archive/';

const okEnvelope = FakeResponse(200, {
  'hasError': false,
  'statusCode': 200,
  'message': {'general': <String>['ok']},
  'response': <String, dynamic>{},
});

FakeResponse failure(String message, {int status = 400}) => FakeResponse(status, {
      'hasError': true,
      'statusCode': status,
      'message': {
        'general': [message],
      },
      'response': <String, dynamic>{},
    });

Map<String, dynamic> item(String id, {bool read = false, String source = 'personal', String? type = 'LC_INVITE'}) => {
      'id': id,
      'type': type,
      'category': type == null ? 'SYSTEM' : 'LC',
      'title': 'Title $id',
      'description': 'Body $id',
      'entity_type': type == null ? null : 'learning_circle',
      'entity_id': type == null ? null : 'circle-$id',
      'is_read': read,
      'is_archived': false,
      'created_at': '2026-11-12T16:00:02Z',
      'read_at': null,
      'source': source,
      'redirect_url': null,
    };

FakeResponse feedPage(List<Map<String, dynamic>> items, {required int page, required int count}) =>
    FakeResponse(200, {
      'hasError': false,
      'statusCode': 200,
      'message': {'general': <String>[]},
      'response': {'count': count, 'page': page, 'page_size': 20, 'results': items},
    });

FakeResponse unread(int count) => FakeResponse(200, {
      'hasError': false,
      'statusCode': 200,
      'message': {'general': <String>[]},
      'response': {'unread_count': count},
    });

/// A signed-in container on [adapter]; [now] drives `clockProvider`.
Future<ProviderContainer> signedInContainer(FakeHttpAdapter adapter, {DateTime Function()? now}) async {
  final tokens = TokenStorage(FakeSecureStorage());
  await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
  return ProviderContainer(overrides: [
    dioProvider.overrideWithValue(fakeDio(adapter)),
    tokenStorageProvider.overrideWithValue(tokens),
    if (now != null) clockProvider.overrideWithValue(now),
  ]);
}

int callsTo(FakeHttpAdapter adapter, String method, String path) =>
    adapter.requests.where((RequestOptions r) => r.method == method && r.uri.path == path).length;
