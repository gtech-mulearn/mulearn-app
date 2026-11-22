import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/config/app_links.dart';
import 'package:mulearn_app/core/config/flavor_config.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/utils/external_links.dart';
import 'package:mulearn_app/features/auth/presentation/screens/register_basic_info_screen.dart';

/// Guideline 1.2: users agree to the Terms (no objectionable content) before
/// they can create an account.
void main() {
  setUpAll(() => FlavorConfig.initialize(Flavor.dev));

  Future<List<Uri>> pumpScreen(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 4000);
    addTearDown(tester.view.reset);
    final opened = <Uri>[];
    final router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (_, _) => const RegisterBasicInfoScreen()),
        GoRoute(
          path: RoutePaths.registerRoleSelection,
          builder: (_, _) => const Scaffold(body: Text('role step')),
        ),
      ],
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          openExternalProvider.overrideWithValue((uri) async {
            opened.add(uri);
            return true;
          }),
        ],
        child: MaterialApp.router(
          theme: MuThemeData.light(),
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();
    return opened;
  }

  Future<void> fillForm(WidgetTester tester) async {
    final fields = find.byType(EditableText);
    await tester.enterText(fields.at(0), 'Ana Maria');
    await tester.enterText(fields.at(1), 'ana@college.edu');
    await tester.enterText(fields.at(2), 'password123');
    await tester.enterText(fields.at(3), 'password123');
  }

  testWidgets('a valid form cannot continue until the Terms are agreed', (
    tester,
  ) async {
    await pumpScreen(tester);
    await fillForm(tester);

    await tester.tap(find.widgetWithText(MuButton, 'Continue'));
    await tester.pumpAndSettle();

    expect(find.text('role step'), findsNothing);
    expect(
      find.text('Please agree to the Terms and Privacy Policy to continue.'),
      findsOneWidget,
    );

    await tester.tap(find.byType(MuCheckbox));
    await tester.pumpAndSettle();
    expect(
      find.text('Please agree to the Terms and Privacy Policy to continue.'),
      findsNothing,
    );
    await tester.tap(find.widgetWithText(MuButton, 'Continue'));
    await tester.pumpAndSettle();

    expect(find.text('role step'), findsOneWidget);
  });

  testWidgets('the Terms and Privacy Policy names open their pages', (
    tester,
  ) async {
    final opened = await pumpScreen(tester);

    await tester.tapOnText(find.textRange.ofSubstring('Terms'));
    await tester.tapOnText(find.textRange.ofSubstring('Privacy Policy'));
    await tester.pump();

    expect(opened, [AppLinks.terms, AppLinks.privacyPolicy]);
  });
}
