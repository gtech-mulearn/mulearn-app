import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/features/auth/presentation/providers/auth_controller.dart';

enum _ResetStep { enterToken, newPassword, done }

/// Password-reset confirmation — a manual-entry alternative to consuming the
/// emailed reset link via a deep link (which this app doesn't have platform
/// config for yet): paste the token/code from the email, verify it, then set
/// a new password. Both API calls (`verify-token` then `reset-password`) are
/// real, confirmed endpoints — only "how the token gets into the app" is
/// simplified here to manual entry instead of a deep link.
class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  ConsumerState<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  _ResetStep _step = _ResetStep.enterToken;

  final _tokenFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final _tokenController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscure = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _tokenController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _verifyToken() async {
    if (!(_tokenFormKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    try {
      await ref
          .read(authControllerProvider.notifier)
          .verifyResetToken(_tokenController.text.trim());
      if (mounted) setState(() => _step = _ResetStep.newPassword);
    } on Object catch (_) {
      // Surfaced via the ref.listen snackbar below.
    }
  }

  Future<void> _resetPassword() async {
    if (!(_passwordFormKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    try {
      await ref.read(authControllerProvider.notifier).resetPassword(
            token: _tokenController.text.trim(),
            password: _passwordController.text,
          );
      if (mounted) setState(() => _step = _ResetStep.done);
    } on Object catch (_) {
      // Surfaced via the ref.listen snackbar below.
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authControllerProvider);

    ref.listen(authControllerProvider, (_, next) {
      if (next.hasError && !next.isLoading) {
        final error = next.error;
        final message = ApiException.messageFor(error!);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(message)));
      }
    });

    final isLoading = state.isLoading;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              switch (_step) {
                _ResetStep.enterToken => _EnterTokenStep(
                    formKey: _tokenFormKey,
                    tokenController: _tokenController,
                    isLoading: isLoading,
                    onSubmit: _verifyToken,
                  ),
                _ResetStep.newPassword => _NewPasswordStep(
                    formKey: _passwordFormKey,
                    passwordController: _passwordController,
                    confirmPasswordController: _confirmPasswordController,
                    obscure: _obscure,
                    obscureConfirm: _obscureConfirm,
                    isLoading: isLoading,
                    onToggleObscure: () => setState(() => _obscure = !_obscure),
                    onToggleObscureConfirm: () =>
                        setState(() => _obscureConfirm = !_obscureConfirm),
                    onSubmit: _resetPassword,
                  ),
                _ResetStep.done => _DoneStep(
                    onSignIn: () => context.go(RoutePaths.signIn),
                  ),
              },
            ],
          ),
        ),
      ),
    );
  }
}

class _EnterTokenStep extends StatelessWidget {
  const _EnterTokenStep({
    required this.formKey,
    required this.tokenController,
    required this.isLoading,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController tokenController;
  final bool isLoading;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Enter your reset code', style: theme.textTheme.headlineMedium),
        const SizedBox(height: 8),
        Text(
          'Paste the code or link token from the password-reset email we sent you.',
          style:
              theme.textTheme.bodyMedium?.copyWith(color: MulearnColors.gray600),
        ),
        const SizedBox(height: 32),
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: tokenController,
                enabled: !isLoading,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => onSubmit(),
                decoration: const InputDecoration(labelText: 'Reset code'),
                validator: (value) => (value?.trim().isEmpty ?? true)
                    ? 'Reset code is required.'
                    : null,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: isLoading ? null : onSubmit,
                child: isLoading
                    ? const _ButtonSpinner()
                    : const Text('Verify code'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _NewPasswordStep extends StatelessWidget {
  const _NewPasswordStep({
    required this.formKey,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.obscure,
    required this.obscureConfirm,
    required this.isLoading,
    required this.onToggleObscure,
    required this.onToggleObscureConfirm,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool obscure;
  final bool obscureConfirm;
  final bool isLoading;
  final VoidCallback onToggleObscure;
  final VoidCallback onToggleObscureConfirm;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Set a new password', style: theme.textTheme.headlineMedium),
        const SizedBox(height: 8),
        Text(
          'Your code is verified. Choose a new password.',
          style:
              theme.textTheme.bodyMedium?.copyWith(color: MulearnColors.gray600),
        ),
        const SizedBox(height: 32),
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: passwordController,
                obscureText: obscure,
                enabled: !isLoading,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'New password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: onToggleObscure,
                  ),
                ),
                validator: (value) {
                  final v = value ?? '';
                  if (v.length < 8) return 'Password must be at least 8 characters.';
                  if (v.length > 100) return 'Password must be at most 100 characters.';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: obscureConfirm,
                enabled: !isLoading,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => onSubmit(),
                decoration: InputDecoration(
                  labelText: 'Confirm new password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscureConfirm
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: onToggleObscureConfirm,
                  ),
                ),
                validator: (value) => value != passwordController.text
                    ? "Passwords don't match."
                    : null,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: isLoading ? null : onSubmit,
                child: isLoading
                    ? const _ButtonSpinner()
                    : const Text('Reset password'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DoneStep extends StatelessWidget {
  const _DoneStep({required this.onSignIn});

  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Password reset!', style: theme.textTheme.headlineMedium),
        const SizedBox(height: 8),
        Text(
          'You can now sign in with your new password.',
          style:
              theme.textTheme.bodyMedium?.copyWith(color: MulearnColors.gray600),
        ),
        const SizedBox(height: 24),
        FilledButton(onPressed: onSignIn, child: const Text('Sign in')),
      ],
    );
  }
}

class _ButtonSpinner extends StatelessWidget {
  const _ButtonSpinner();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 22,
      width: 22,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        valueColor: AlwaysStoppedAnimation(MulearnColors.whitish),
      ),
    );
  }
}
