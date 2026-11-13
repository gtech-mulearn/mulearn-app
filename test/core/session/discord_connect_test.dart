import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/session/discord_connect.dart';
import 'package:mulearn_app/core/session/session_providers.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/core/utils/external_links.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';

const _connect = '/api/v1/register/connect-discord/';
const _userInfo = '/api/v1/dashboard/user/info/';

/// GET /api/v1/register/connect-discord/?code= (ConnectDiscordAPI,
/// register_views.py:28): the backend exchanges Discord's code itself.
void main() {
  late FakeHttpAdapter adapter;
  late List<Uri> opened;
  final authUri = Uri.parse('https://discord.com/oauth2/authorize?client_id=1&redirect_uri=x');

  setUp(() {
    opened = [];
    adapter = FakeHttpAdapter({
      'GET $_userInfo': (_) => FakeResponse(200, loadFixture('dev/user_info')),
      'GET $_connect': (o) => o.queryParameters['code'] == 'good'
          ? const FakeResponse(200, {
              'hasError': false,
              'statusCode': 200,
              'message': {
                'general': ['You will be added to the discord server soon'],
              },
              'response': <String, dynamic>{},
            })
          : FakeResponse(400, loadFixture('dev/connect_discord_bad_code')),
    });
  });

  Future<ProviderContainer> container({Uri? discord}) async {
    final tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
    final c = ProviderContainer(retry: (_, __) => null, overrides: [
      dioProvider.overrideWithValue(fakeDio(adapter)),
      tokenStorageProvider.overrideWithValue(tokens),
      openExternalProvider.overrideWithValue((uri) async {
        opened.add(uri);
        return true;
      }),
      discordAuthUriProvider.overrideWithValue(discord),
    ]);
    addTearDown(c.dispose);
    return c;
  }

  int calls(String path) => adapter.requests.where((RequestOptions r) => r.uri.path == path).length;

  test('connecting sends the code once and refreshes the signed-in user', () async {
    final c = await container();
    c
      ..listen(currentUserProvider, (_, __) {})
      ..listen(discordConnectControllerProvider, (_, __) {});
    await c.read(currentUserProvider.future);

    final controller = c.read(discordConnectControllerProvider.notifier);
    await controller.connect('good');
    await controller.connect('good'); // a rebuild asking again

    expect(calls(_connect), 1);
    expect(adapter.requests.firstWhere((r) => r.uri.path == _connect).queryParameters, {'code': 'good'});
    expect(c.read(discordConnectControllerProvider).value, 'You will be added to the discord server soon');
    await c.read(currentUserProvider.future);
    expect(calls(_userInfo), 2, reason: 'exist_in_guild is re-read');
  });

  test("Discord's refusal surfaces the backend message", () async {
    final c = await container()
      ..listen(discordConnectControllerProvider, (_, __) {});

    await c.read(discordConnectControllerProvider.notifier).connect('bad');

    final error = c.read(discordConnectControllerProvider).error;
    expect(error, isA<ApiException>().having((e) => e.message, 'message', 'Failed to get access token'));
  });

  test('starting the flow opens Discord, and only the next resume re-checks the account', () async {
    final c = await container(discord: authUri)
      ..listen(currentUserProvider, (_, __) {})
      ..listen(discordConnectFlowProvider, (_, __) {});
    await c.read(currentUserProvider.future);
    final flow = c.read(discordConnectFlowProvider.notifier)
      ..onResume(); // an ordinary resume: nothing pending
    await Future<void>.delayed(Duration.zero);
    expect(calls(_userInfo), 1);

    await flow.start();
    expect(opened, [authUri]);
    flow.onResume();
    await c.read(currentUserProvider.future);
    expect(calls(_userInfo), 2);

    flow.onResume();
    await Future<void>.delayed(Duration.zero);
    expect(calls(_userInfo), 2, reason: 'one check per flow, no polling');
  });

  test('no Discord URL means the flow is unavailable', () async {
    final c = await container();

    expect(c.read(discordConnectFlowProvider.notifier).available, isFalse);
  });
}
