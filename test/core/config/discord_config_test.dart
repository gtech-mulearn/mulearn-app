import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// The Android App Link host must be the host Discord redirects to, or the
/// link opens the browser instead of the app.
void main() {
  test("the dev App Link host is the dev Discord redirect's host", () {
    final env = File('.env.dev').readAsLinesSync();
    final authUrl = env.firstWhere((l) => l.startsWith('DISCORD_AUTH_URL=')).substring('DISCORD_AUTH_URL='.length);
    final redirect = Uri.parse(Uri.parse(authUrl).queryParameters['redirect_uri']!);
    final gradle = File('android/app/build.gradle.kts').readAsStringSync();
    final dev = RegExp(r'create\("dev"\)\s*\{[^}]*discordRedirectHost"\]\s*=\s*"([^"]+)"').firstMatch(gradle);

    expect(dev, isNotNull, reason: 'dev flavour sets manifestPlaceholders["discordRedirectHost"]');
    expect(dev!.group(1), redirect.host);
    expect(redirect.path, '/dashboard/connect-discord');
  });

  test('the manifest routes that host and path to the app', () {
    final manifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();

    expect(manifest, contains(r'android:host="${discordRedirectHost}"'));
    expect(manifest, contains('android:pathPrefix="/dashboard/connect-discord"'));
    expect(manifest, contains('android:autoVerify="true"'));
  });
}
