import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/data/location_remote_datasource.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:mulearn_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:mulearn_app/features/profile/domain/password_rules.dart';
import 'package:mulearn_app/features/profile/presentation/screens/change_password_screen.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fixtures.dart';
import 'settings_test_support.dart';

/// POST /dashboard/profile/change-password/ {current_password, password}
/// (ResetPasswordAPI, profile_view.py:622). Rules copied from the
/// dashboard's ChangePasswordRequestSchema (settings.schema.ts).
void main() {
  group('validateNewPassword', () {
    test('the dashboard rules', () {
      expect(validateNewPassword(current: 'old-pass-1', next: 'short', confirm: 'short'),
          'Password must be at least 8 characters');
      expect(validateNewPassword(current: 'same-pass-1', next: 'same-pass-1', confirm: 'same-pass-1'),
          'The new password must be different from the current password.');
      expect(validateNewPassword(current: 'old-pass-1', next: 'new-pass-1', confirm: 'new-pass-2'),
          'Passwords do not match');
      expect(validateNewPassword(current: 'old-pass-1', next: 'new-pass-1', confirm: 'new-pass-1'), isNull);
    });
  });

  group('repository', () {
    test('sends current_password and password', () async {
      final adapter = FakeHttpAdapter({'POST $changePasswordPath': (_) => okEnvelope});
      final repo = ProfileRepositoryImpl(
        remote: ProfileRemoteDataSource(fakeDio(adapter)),
        locationRemote: LocationRemoteDataSource(fakeDio(adapter)),
      );

      await repo.changePassword(current: 'old-pass-1', next: 'new-pass-1');

      expect(adapter.requests.single.data, {'current_password': 'old-pass-1', 'password': 'new-pass-1'});
    });

    test("the backend's wrong-password reply surfaces its message", () async {
      final adapter = FakeHttpAdapter({
        'POST $changePasswordPath': (_) => FakeResponse(400, loadFixture('dev/change_password_wrong_current')),
      });
      final repo = ProfileRepositoryImpl(
        remote: ProfileRemoteDataSource(fakeDio(adapter)),
        locationRemote: LocationRemoteDataSource(fakeDio(adapter)),
      );

      await expectLater(
        repo.changePassword(current: 'wrong', next: 'new-pass-1'),
        throwsA(isA<ApiException>().having((e) => e.message, 'message', 'Current Password is incorrect')),
      );
    });
  });

  group('screen', () {
    Future<void> fill(WidgetTester tester, {String current = 'old-pass-1', String next = 'new-pass-1', String confirm = 'new-pass-1'}) async {
      await tester.enterText(find.widgetWithText(TextFormField, 'Current password'), current);
      await tester.enterText(find.widgetWithText(TextFormField, 'New password'), next);
      await tester.enterText(find.widgetWithText(TextFormField, 'Confirm new password'), confirm);
      await tester.tap(find.widgetWithText(MuPrimaryButton, 'Change password'));
      await settle(tester);
    }

    testWidgets('a wrong current password shows under that field', (tester) async {
      final adapter = settingsAdapter({
        'POST $changePasswordPath': (_) => FakeResponse(400, loadFixture('dev/change_password_wrong_current')),
      });
      await pumpSettingsApp(tester, adapter,
          location: '/settings/password', routes: {'/settings/password': () => const ChangePasswordScreen()});

      await fill(tester, current: 'wrong-one');

      expect(find.text('Current Password is incorrect'), findsOneWidget);
      expect(find.byType(ChangePasswordScreen), findsOneWidget, reason: 'stays open');
    });

    testWidgets('invalid input is caught before any request', (tester) async {
      final adapter = settingsAdapter();
      await pumpSettingsApp(tester, adapter,
          location: '/settings/password', routes: {'/settings/password': () => const ChangePasswordScreen()});

      await fill(tester, confirm: 'different-1');

      expect(find.text('Passwords do not match'), findsOneWidget);
      expect(adapter.requests.where((RequestOptions r) => r.method == 'POST'), isEmpty);
    });

    testWidgets('success says so and closes', (tester) async {
      final adapter = settingsAdapter({'POST $changePasswordPath': (_) => okEnvelope});
      await pumpSettingsApp(tester, adapter,
          location: '/settings/password', routes: {'/settings/password': () => const ChangePasswordScreen()});

      await fill(tester);

      expect(find.text('Password changed'), findsOneWidget);
      expect(find.byType(ChangePasswordScreen), findsNothing);
      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();
    });
  });
}
