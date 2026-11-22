import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/config/app_links.dart';
import 'package:mulearn_app/features/profile/presentation/screens/settings_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../support/fake_http_adapter.dart';
import 'settings_test_support.dart';

/// Settings (UX-03, SEC-14, L19). Account deletion is confirmed in the app
/// and then requested from support (spec §11, guideline 5.1.1(v)): no call to
/// DELETE /dashboard/profile/.
void main() {
  Future<void> openSettings(
    WidgetTester tester,
    FakeHttpAdapter adapter, {
    List<Uri>? opened,
  }) => pumpSettingsApp(
    tester,
    adapter,
    location: '/settings',
    routes: {'/settings': () => const SettingsScreen()},
    opened: opened,
  );

  testWidgets('shows every section', (tester) async {
    await openSettings(tester, settingsAdapter());

    for (final label in ['Change password', 'Discord', 'Public profile']) {
      expect(find.text(label), findsOneWidget, reason: label);
    }
    for (final label in [
      'Blocked users',
      'Contact support',
      'Privacy policy',
      'Terms and conditions',
    ]) {
      await tester.scrollUntilVisible(find.text(label), 200);
      expect(find.text(label), findsOneWidget, reason: label);
    }
    await tester.scrollUntilVisible(find.text('Delete account'), 200);
    expect(find.text('Sign out'), findsOneWidget);
    expect(find.text('Delete account'), findsOneWidget);
  });

  testWidgets('the installed version sits at the bottom, as CI named it', (
    tester,
  ) async {
    PackageInfo.setMockInitialValues(
      appName: 'μLearn',
      packageName: 'org.mulearn.muapp.dev',
      version: '1.0.0-dev.84',
      buildNumber: '84',
      buildSignature: '',
    );
    await openSettings(tester, settingsAdapter());
    await tester.scrollUntilVisible(find.text('μLearn 1.0.0-dev.84 (84)'), 200);
    expect(find.text('μLearn 1.0.0-dev.84 (84)'), findsOneWidget);
  });

  testWidgets('Discord shows whether the account is connected', (tester) async {
    await openSettings(
      tester,
      settingsAdapter(),
    ); // dev/user_info: exist_in_guild false

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

    await tester.scrollUntilVisible(find.text('Terms and conditions'), 200);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Privacy policy'));
    await tester.tap(find.text('Terms and conditions'));
    await tester.pump();

    expect(opened, [AppLinks.privacyPolicy, AppLinks.terms]);
  });

  testWidgets(
    'delete account needs DELETE typed, then emails support and never deletes',
    (tester) async {
      final opened = <Uri>[];
      final adapter = settingsAdapter();
      await openSettings(tester, adapter, opened: opened);

      await tester.scrollUntilVisible(find.text('Delete account'), 200);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete account'));
      await settle(tester);
      expect(find.text('Type DELETE to confirm'), findsOneWidget);

      // The button is off until DELETE is typed.
      await tester.tap(find.text('Request deletion'));
      await tester.pump();
      expect(opened, isEmpty);

      await tester.enterText(find.byType(EditableText), 'DELETE');
      await tester.pump();
      await tester.tap(find.text('Request deletion'));
      await tester.pump();

      final mail = opened.single;
      expect(mail.scheme, 'mailto');
      expect(mail.path, 'info@mulearn.org');
      expect(Uri.decodeComponent(mail.query), contains('qastudentone@mulearn'));
      expect(find.textContaining('Your request is ready'), findsOneWidget);
      expect(
        adapter.requests.where((RequestOptions r) => r.method == 'DELETE'),
        isEmpty,
      );
    },
  );

  testWidgets('safety and help: blocked users and a way to reach support', (
    tester,
  ) async {
    final opened = <Uri>[];
    await openSettings(tester, settingsAdapter(), opened: opened);

    await tester.scrollUntilVisible(find.text('Contact support'), 200);
    await tester.pumpAndSettle();
    expect(find.text('Blocked users'), findsOneWidget);
    await tester.tap(find.text('Contact support'));
    await tester.pump();

    expect(opened.single.scheme, 'mailto');
    expect(opened.single.path, AppLinks.supportEmail);
  });

  testWidgets(
    'the public-profile switch saves and refreshes the shared profile',
    (tester) async {
      final adapter = settingsAdapter({'PUT $sharePath': (_) => okEnvelope});
      await openSettings(tester, adapter);
      final before = adapter.requests
          .where((RequestOptions r) => r.uri.path == profilePath)
          .length;

      await tester.tap(find.text('Public profile'));
      await settle(tester);

      final put = adapter.requests.singleWhere(
        (RequestOptions r) => r.method == 'PUT',
      );
      expect(put.data, {'is_public': true});
      expect(
        adapter.requests
            .where((RequestOptions r) => r.uri.path == profilePath)
            .length,
        before + 1,
      );
    },
  );

  test('the deletion email names the account', () {
    final uri = AppLinks.deletionRequest('someone@mulearn');

    expect(uri.toString(), startsWith('mailto:info@mulearn.org?subject='));
    expect(Uri.decodeComponent(uri.query), contains('someone@mulearn'));
  });
}
