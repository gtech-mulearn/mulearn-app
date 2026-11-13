import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/config/flavor_config.dart';
import 'package:mulearn_app/features/auth/domain/entities/registration_role.dart';
import 'package:mulearn_app/features/auth/presentation/screens/register_role_selection_screen.dart';

/// Company sign-up needs a verification document upload
/// (CompanyRegisterSerializer.verification_document_url is required), which
/// the mobile app can't provide — company POCs are sent to the dashboard.
void main() {
  setUpAll(() => FlavorConfig.initialize(Flavor.dev));

  testWidgets('there is no Company option; company POCs are pointed to the dashboard', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: MaterialApp(home: RegisterRoleSelectionScreen())));

    expect(find.text('Company'), findsNothing);
    expect(find.textContaining('Company accounts are created on the μLearn dashboard'), findsOneWidget);
    expect(find.text(FlavorConfig.instance.dashboardUrl), findsOneWidget);
    expect(FlavorConfig.instance.dashboardUrl, startsWith('https://'));
  });

  test('registration offers no Company role', () {
    expect(RegistrationRole.values.map((r) => r.apiTitle), ['Student', 'Mentor', 'Enabler']);
  });
}
