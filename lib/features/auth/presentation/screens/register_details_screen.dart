import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/features/auth/domain/entities/registration_role.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_submit_controller.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_wizard_controller.dart';
import 'package:mulearn_app/features/auth/presentation/widgets/company_details_form.dart';
import 'package:mulearn_app/features/auth/presentation/widgets/enabler_details_form.dart';
import 'package:mulearn_app/features/auth/presentation/widgets/mentor_details_form.dart';
import 'package:mulearn_app/features/auth/presentation/widgets/student_details_form.dart';

/// Registration step 3 — role-specific details, matching the reference
/// dashboard's step 3 of 3. Renders a different form per [RegistrationRole]
/// (set in step 2). On success, resets the wizard and navigates onward:
/// Company → profile (the reference goes to its dashboard); Student/Mentor/
/// Enabler → the interests onboarding step.
class RegisterDetailsScreen extends ConsumerWidget {
  const RegisterDetailsScreen({super.key});

  void _onSubmitted(BuildContext context, WidgetRef ref, RegistrationRole role) {
    ref.read(registerWizardControllerProvider.notifier).reset();
    if (role == RegistrationRole.company) {
      context.go(RoutePaths.home);
    } else {
      context.go(RoutePaths.onboardingInterests);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(registerWizardControllerProvider).role;

    ref.listen(registerSubmitControllerProvider, (_, next) {
      if (next.hasError && !next.isLoading) {
        final error = next.error;
        final message = ApiException.messageFor(error!);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(message)));
      }
    });

    if (role == null) {
      // Wizard state was reset (e.g. app restart mid-flow) — start over.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) context.go(RoutePaths.registerBasicInfo);
      });
      return const Scaffold(body: SizedBox.shrink());
    }

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: switch (role) {
            RegistrationRole.student => StudentDetailsForm(
                onSubmitted: () => _onSubmitted(context, ref, role),
              ),
            RegistrationRole.enabler => EnablerDetailsForm(
                onSubmitted: () => _onSubmitted(context, ref, role),
              ),
            RegistrationRole.mentor => MentorDetailsForm(
                onSubmitted: () => _onSubmitted(context, ref, role),
              ),
            RegistrationRole.company => CompanyDetailsForm(
                onSubmitted: () => _onSubmitted(context, ref, role),
              ),
          },
        ),
      ),
    );
  }
}
