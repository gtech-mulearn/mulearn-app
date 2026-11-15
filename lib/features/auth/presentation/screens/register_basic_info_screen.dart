import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_wizard_controller.dart';
import 'package:mulearn_app/features/auth/presentation/widgets/auth_page.dart';

/// Sign-up step 1 of 4: name, email and password (the dashboard's step 1).
/// From "Continue with Google" the email is the Google account's, read-only,
/// and there is no password.
class RegisterBasicInfoScreen extends ConsumerStatefulWidget {
  const RegisterBasicInfoScreen({super.key});

  @override
  ConsumerState<RegisterBasicInfoScreen> createState() => _RegisterBasicInfoScreenState();
}

class _RegisterBasicInfoScreenState extends ConsumerState<RegisterBasicInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool get _isGoogleSignUp => ref.read(registerWizardControllerProvider).googleTempToken != null;

  @override
  void initState() {
    super.initState();
    final wizard = ref.read(registerWizardControllerProvider);
    _fullNameController.text = wizard.fullName ?? '';
    _emailController.text = wizard.email ?? '';
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _continue() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    ref
        .read(registerWizardControllerProvider.notifier)
        .setBasicInfo(
          fullName: _fullNameController.text.trim(),
          email: _emailController.text.trim(),
          password: _isGoogleSignUp ? null : _passwordController.text,
        );
    context.push(RoutePaths.registerRoleSelection);
  }

  @override
  Widget build(BuildContext context) {
    final isGoogle = _isGoogleSignUp;
    return AuthPage(
      step: 1,
      steps: 4,
      eyebrow: 'Create your account',
      light: 'Step into ',
      bold: 'the community',
      lead: isGoogle
          ? 'Finish setting up with your Google email.'
          : 'Learn by doing, alongside peers from every campus.',
      bottom: MuButton(label: 'Continue', block: true, knob: true, onPressed: _continue),
      children: [
        Form(
          key: _formKey,
          child: AutofillGroup(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MuTextField(
                  label: 'Full name',
                  hint: 'As on your college ID',
                  controller: _fullNameController,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  autofillHints: const [AutofillHints.name],
                  validator: (value) {
                    final v = value?.trim() ?? '';
                    if (v.length < 3) return 'Use at least 3 characters.';
                    if (v.length > 100) return 'Use at most 100 characters.';
                    return null;
                  },
                ),
                const SizedBox(height: MuSpacing.space4),
                MuTextField(
                  label: 'Email',
                  hint: 'you@college.edu',
                  controller: _emailController,
                  readOnly: isGoogle,
                  help: isGoogle ? 'From your Google account' : "We'll use it to sign you in.",
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.email],
                  validator: (value) {
                    final v = value?.trim() ?? '';
                    return (v.isEmpty || !v.contains('@')) ? 'Enter an email like you@college.edu.' : null;
                  },
                ),
                if (!isGoogle) ...[
                  const SizedBox(height: MuSpacing.space4),
                  MuTextField(
                    label: 'Password',
                    controller: _passwordController,
                    obscure: true,
                    help: 'At least 8 characters.',
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.newPassword],
                    validator: (value) {
                      final v = value ?? '';
                      if (v.length < 8) return 'Use at least 8 characters.';
                      if (v.length > 100) return 'Use at most 100 characters.';
                      return null;
                    },
                  ),
                  const SizedBox(height: MuSpacing.space4),
                  MuTextField(
                    label: 'Type it again',
                    controller: _confirmPasswordController,
                    obscure: true,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _continue(),
                    validator: (v) => v != _passwordController.text ? "The two passwords don't match." : null,
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: MuSpacing.space4),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text('Already on μLearn?', style: context.mu.text.body.copyWith(color: context.mu.colors.ink2)),
            MuButton(
              label: 'Sign in',
              variant: MuButtonVariant.ghost,
              size: MuButtonSize.small,
              onPressed: () => context.pop(),
            ),
          ],
        ),
      ],
    );
  }
}
