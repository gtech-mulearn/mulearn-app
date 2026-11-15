import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/features/auth/presentation/providers/auth_controller.dart';
import 'package:mulearn_app/features/auth/presentation/widgets/auth_page.dart';

enum _ResetStep { enterToken, newPassword, done }

/// Password reset by hand: paste the code from the reset email, verify it
/// (`verify-token`), then set a new password (`reset-password`). Both are
/// the real endpoints; only how the code gets into the app is manual.
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
      await ref.read(authControllerProvider.notifier).verifyResetToken(_tokenController.text.trim());
      if (mounted) setState(() => _step = _ResetStep.newPassword);
    } on Object catch (_) {
      // Surfaced via the ref.listen toast below.
    }
  }

  Future<void> _resetPassword() async {
    if (!(_passwordFormKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    try {
      await ref
          .read(authControllerProvider.notifier)
          .resetPassword(token: _tokenController.text.trim(), password: _passwordController.text);
      if (!mounted) return;
      unawaited(HapticFeedback.mediumImpact());
      setState(() => _step = _ResetStep.done);
    } on Object catch (_) {
      // Surfaced via the ref.listen toast below.
    }
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(authControllerProvider).isLoading;

    ref.listen(authControllerProvider, (_, next) {
      if (next.hasError && !next.isLoading) {
        MuToast.show(context, message: ApiException.messageFor(next.error!), type: MuToastType.error);
      }
    });

    return switch (_step) {
      _ResetStep.enterToken => AuthPage(
        eyebrow: 'Reset your password',
        light: 'Enter ',
        bold: 'your reset code',
        lead: 'Paste the code from the password-reset email we sent you.',
        bottom: MuButton(
          label: 'Verify code',
          block: true,
          loading: loading,
          loadingLabel: 'Verifying…',
          onPressed: _verifyToken,
        ),
        children: [
          Form(
            key: _tokenFormKey,
            child: MuTextField(
              label: 'Reset code',
              controller: _tokenController,
              enabled: !loading,
              autofocus: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _verifyToken(),
              validator: (v) => (v?.trim().isEmpty ?? true) ? 'Paste the code from the email.' : null,
            ),
          ),
        ],
      ),
      _ResetStep.newPassword => AuthPage(
        eyebrow: 'Code verified',
        light: 'Choose ',
        bold: 'a new password',
        lead: 'At least 8 characters. Something only you would know.',
        bottom: MuButton(
          label: 'Save password',
          block: true,
          loading: loading,
          loadingLabel: 'Saving…',
          onPressed: _resetPassword,
        ),
        children: [
          Form(
            key: _passwordFormKey,
            child: AutofillGroup(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MuTextField(
                    label: 'New password',
                    controller: _passwordController,
                    obscure: true,
                    enabled: !loading,
                    autofocus: true,
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
                    enabled: !loading,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _resetPassword(),
                    validator: (v) => v != _passwordController.text ? "The two passwords don't match." : null,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      _ResetStep.done => AuthPage(
        eyebrow: 'All set',
        light: 'Password ',
        bold: 'changed',
        lead: 'Sign in with your new password.',
        onBack: () => context.go(RoutePaths.signIn),
        bottom: MuButton(label: 'Sign in', block: true, knob: true, onPressed: () => context.go(RoutePaths.signIn)),
        children: [
          Center(
            child: Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(color: context.mu.colors.successTint, shape: BoxShape.circle),
              child: Icon(LucideIcons.check, size: 40, color: context.mu.colors.success),
            ),
          ),
        ],
      ),
    };
  }
}
