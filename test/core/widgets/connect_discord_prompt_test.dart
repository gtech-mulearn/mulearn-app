import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/session/capabilities.dart';
import 'package:mulearn_app/core/session/discord_connect.dart';
import 'package:mulearn_app/core/session/session_providers.dart';
import 'package:mulearn_app/core/widgets/connect_discord_prompt.dart';

/// Task proof is posted in Discord; karma needs the account linked (UX-02).
void main() {
  Capabilities caps({required bool needsDiscord}) => Capabilities(
        isLearner: true,
        isMentor: false,
        isMentorApproved: false,
        isEnabler: false,
        isCampusLead: false,
        isCompany: false,
        needsDiscord: needsDiscord,
      );

  Future<void> pump(WidgetTester tester, {required bool needsDiscord, Uri? discord}) => tester.pumpWidget(ProviderScope(
        overrides: [
          capabilitiesProvider.overrideWith((_) async => caps(needsDiscord: needsDiscord)),
          discordAuthUriProvider.overrideWithValue(discord),
        ],
        child: const MaterialApp(home: Scaffold(body: ConnectDiscordPrompt(orElse: Text('post proof')))),
      ));

  testWidgets('asks to connect when the account is not in the server', (tester) async {
    await pump(tester, needsDiscord: true, discord: Uri.parse('https://discord.com/oauth2/authorize'));
    await tester.pump();

    expect(find.text('Connect Discord to earn karma'), findsOneWidget);
    expect(find.text('post proof'), findsNothing);
  });

  testWidgets('shows the normal content once connected', (tester) async {
    await pump(tester, needsDiscord: false, discord: Uri.parse('https://discord.com/oauth2/authorize'));
    await tester.pump();

    expect(find.text('post proof'), findsOneWidget);
  });

  testWidgets('shows the normal content when the app has no Discord URL', (tester) async {
    await pump(tester, needsDiscord: true);
    await tester.pump();

    expect(find.text('post proof'), findsOneWidget);
  });
}
