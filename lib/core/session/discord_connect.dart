import 'package:dio/dio.dart';
import 'package:mulearn_app/core/config/flavor_config.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/session/session_providers.dart';
import 'package:mulearn_app/core/utils/external_links.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'discord_connect.g.dart';

/// The μLearn Discord server (the dashboard links it after connecting).
final Uri discordServerInvite = Uri.parse('https://discord.gg/gtech-mulearn-771670169691881483');

/// Discord's OAuth authorize URL for this flavour (the dashboard's), or null
/// when not configured — every Connect Discord entry point hides then.
@Riverpod(keepAlive: true)
Uri? discordAuthUri(Ref ref) {
  final raw = FlavorConfig.instance.discordAuthUrl;
  return raw.isEmpty ? null : Uri.parse(raw);
}

/// Exchanges the code Discord sent back (via the dashboard redirect App
/// Link) and re-reads the signed-in user, whose `exist_in_guild` drives
/// `needsDiscord`. Value: the backend's message once connected.
@riverpod
class DiscordConnectController extends _$DiscordConnectController {
  String? _code;

  @override
  Future<String?> build() async => null;

  /// Sends [code] once; asking again with the same code does nothing.
  Future<void> connect(String code) async {
    if (code == _code) return;
    _code = code;
    final datasource = ref.read(sessionRemoteDataSourceProvider);
    final link = ref.keepAlive(); // finish the refresh even if the screen closes
    state = const AsyncLoading();
    try {
      final result = await AsyncValue.guard(() async {
        try {
          return await datasource.connectDiscord(code);
        } on DioException catch (e) {
          throw ApiException.fromDioException(e);
        }
      });
      if (!result.hasError) ref.invalidate(currentUserProvider);
      state = result;
    } finally {
      link.close();
    }
  }
}

/// Starting the OAuth flow, and the one check after it: the first app
/// resume after the browser opened re-reads the user (the web page may have
/// completed the link). Ordinary resumes do nothing — no polling.
@Riverpod(keepAlive: true)
class DiscordConnectFlow extends _$DiscordConnectFlow {
  @override
  bool build() => false;

  /// Whether this build can connect Discord at all.
  bool get available => ref.read(discordAuthUriProvider) != null;

  Future<void> start() async {
    final uri = ref.read(discordAuthUriProvider);
    if (uri == null) return;
    state = true;
    await ref.read(openExternalProvider)(uri);
  }

  void onResume() {
    if (!state) return;
    state = false;
    ref.invalidate(currentUserProvider);
  }
}
