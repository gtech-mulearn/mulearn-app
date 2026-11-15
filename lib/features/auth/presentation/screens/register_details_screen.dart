import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/features/auth/domain/entities/registration_role.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_submit_controller.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_wizard_controller.dart';
import 'package:mulearn_app/features/auth/presentation/widgets/auth_page.dart';
import 'package:mulearn_app/features/auth/presentation/widgets/enabler_details_form.dart';
import 'package:mulearn_app/features/auth/presentation/widgets/mentor_details_form.dart';
import 'package:mulearn_app/features/auth/presentation/widgets/student_details_form.dart';

/// Sign-up step 3 of 4: where you learn or work, one form per role (the
/// dashboard's step 3). On success the wizard resets and interests follow.
class RegisterDetailsScreen extends ConsumerWidget {
  const RegisterDetailsScreen({super.key});

  void _onSubmitted(BuildContext context, WidgetRef ref) {
    ref.read(registerWizardControllerProvider.notifier).reset();
    context.go(RoutePaths.onboardingInterests);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(registerWizardControllerProvider).role;

    ref.listen(registerSubmitControllerProvider, (_, next) {
      if (next.hasError && !next.isLoading) {
        MuToast.show(context, message: ApiException.messageFor(next.error!), type: MuToastType.error);
      }
    });

    if (role == null) {
      // Wizard state was reset (e.g. app restart mid-flow): start over.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) context.go(RoutePaths.registerBasicInfo);
      });
      return Scaffold(backgroundColor: context.mu.colors.chalk);
    }

    final (String light, String bold, String lead) = switch (role) {
      RegistrationRole.student => ('Where do ', 'you learn?', 'Your campus connects you with peers and campus events.'),
      RegistrationRole.mentor => ('Where do ', 'you work?', 'Learners will see where their mentor comes from.'),
      RegistrationRole.enabler => ('Which campus ', 'do you enable?', 'Pick the institution you support.'),
    };

    return AuthPage(
      step: 3,
      steps: 4,
      eyebrow: 'About you',
      light: light,
      bold: bold,
      lead: lead,
      children: [
        switch (role) {
          RegistrationRole.student => StudentDetailsForm(onSubmitted: () => _onSubmitted(context, ref)),
          RegistrationRole.enabler => EnablerDetailsForm(onSubmitted: () => _onSubmitted(context, ref)),
          RegistrationRole.mentor => MentorDetailsForm(onSubmitted: () => _onSubmitted(context, ref)),
        },
      ],
    );
  }
}
