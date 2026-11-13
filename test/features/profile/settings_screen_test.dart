import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/config/app_links.dart';
import 'package:mulearn_app/features/profile/presentation/screens/settings_screen.dart';

import '../../support/fake_http_adapter.dart';
import 'settings_test_support.dart';

/// Settings (UX-03, SEC-14, L19). Account deletion is a request to support
/// (spec §11): no call to DELETE /dashboard/profile/.
void main() {
  Future<void> openSettings(WidgetTester tester, FakeHttpAdapter adapter, {List<Uri>? opened}) =>
      pumpSettingsApp(tester, adapter,
          location: '/settings', routes: {'/settings': () => const SettingsScreen()}, opened: opened);

  testWidgets('shows every section', (tester) async {
    await openSettings(tester, settingsAdapter());

    for (final label in ['Change password', 'Discord', 'Public profile', 'Privacy policy', 'Terms and conditions']) {
      expect(find.text(label), findsOneWidget, reason: label);
    }
    await tester.scrollUntilVisible(find.text('Delete account'), 200);
    expect(find.text('Sign out'), findsOneWidget);
    expect(find.text('Delete account'), findsOneWidget);
  });

  testWidgets('Discord shows whether the account is connected', (tester) async {
    await openSettings(tester, settingsAdapter()); // dev/user_info: exist_in_guild false

    expect(find.text('Not connected'), findsOneWidget);
  });

  testWidgets('tapping Discord starts the connect flow', (tester) async {
    final opened = <Uri>[];
    await openSettings(tester, settingsAdapter(), opened: opened);

    await tester.tap(find.text('Discord'));
    await tester.pump();

    expect(opened.single, settingsDiscordUri);
  });

  testWidgets('legal links open in the browser', (tester) async {
    final opened = <Uri>[];
    await openSettings(tester, settingsAdapter(), opened: opened);

    await tester.tap(find.text('Privacy policy'));
    await tester.tap(find.text('Terms and conditions'));
    await tester.pump();

    expect(opened, [AppLinks.privacyPolicy, AppLinks.terms]);
  });

  testWidgets('delete account asks support by email and never deletes', (tester) async {
    final opened = <Uri>[];
    final adapter = settingsAdapter();
    await openSettings(tester, adapter, opened: opened);

    await tester.ensureVisible(find.text('Delete account'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete account'));
    await settle(tester);
    expect(find.textContaining('Contact support to delete your account'), findsOneWidget);
    await tester.tap(find.text('Email support'));
    await tester.pump();

    final mail = opened.single;
    expect(mail.scheme, 'mailto');
    expect(mail.path, 'info@mulearn.org');
    expect(Uri.decodeComponent(mail.query), contains('qastudentone@mulearn'));
    expect(adapter.requests.where((RequestOptions r) => r.method == 'DELETE'), isEmpty);
  });

  testWidgets('the public-profile switch saves and refreshes the shared profile', (tester) async {
    final adapter = settingsAdapter({'PUT $sharePath': (_) => okEnvelope});
    await openSettings(tester, adapter);
    final before = adapter.requests.where((RequestOptions r) => r.uri.path == profilePath).length;

    await tester.tap(find.byType(Switch));
    await settle(tester);

    final put = adapter.requests.singleWhere((RequestOptions r) => r.method == 'PUT');
    expect(put.data, {'is_public': true});
    expect(adapter.requests.where((RequestOptions r) => r.uri.path == profilePath).length, before + 1);
  });

  test('the deletion email names the account', () {
    final uri = AppLinks.deletionRequest('someone@mulearn');

    expect(uri.toString(), startsWith('mailto:info@mulearn.org?subject='));
    expect(Uri.decodeComponent(uri.query), contains('someone@mulearn'));
  });
}
