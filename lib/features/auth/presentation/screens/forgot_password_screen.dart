import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/features/auth/presentation/providers/auth_controller.dart';
import 'package:mulearn_app/features/auth/presentation/widgets/auth_page.dart';

/// Requests a password-reset email, like the dashboard's `/forgot-password`.
/// Once sent, offers the manual path ([RoutePaths.resetPassword]) to paste
/// the emailed code, since the app doesn't consume the reset link itself.
class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailOrMuidController = TextEditingController();
  bool _sent = false;

  @override
  void dispose() {
    _emailOrMuidController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    try {
      await ref
          .read(authControllerProvider.notifier)
          .requestPasswordReset(
            emailOrMuid: _emailOrMuidController.text.trim(),
          );
      if (mounted) setState(() => _sent = true);
    } on Object catch (_) {
      // Surfaced via the ref.listen toast below.
    }
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final loading = ref.watch(authControllerProvider).isLoading;

    ref.listen(authControllerProvider, (_, next) {
      if (next.hasError && !next.isLoading) {
        MuToast.show(
          context,
          message: ApiException.messageFor(next.error!),
          type: MuToastType.error,
        );
      }
    });

    if (_sent) {
      return AuthPage(
        eyebrow: 'Check your email',
        light: 'Link ',
        bold: 'on its way',
        lead:
            'We sent a reset link for ${_emailOrMuidController.text.trim()}. '
            'Open it on this phone, or paste the code from the email here.',
        bottom: MuButton(
          label: 'I have a reset code',
          block: true,
          knob: true,
          onPressed: () => context.push(RoutePaths.resetPassword),
        ),
        children: [
          Container(
            padding: const EdgeInsets.all(MuSpacing.space4),
            decoration: BoxDecoration(
              color: c.surface,
              borderRadius: BorderRadius.circular(MuRadii.card),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: c.successTint,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    LucideIcons.mailCheck,
                    color: c.success,
                    size: MuSizes.iconMd,
                  ),
                ),
                const SizedBox(width: MuSpacing.space3),
                Expanded(
                  child: Text(
                    "Didn't get it? Check spam, or send it again.",
                    style: mu.text.body.copyWith(color: c.ink2),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: MuSpacing.space2),
          Center(
            child: MuButton(
              label: 'Send it again',
              variant: MuButtonVariant.ghost,
              size: MuButtonSize.small,
              onPressed: loading ? null : _submit,
            ),
          ),
        ],
      );
    }

    return AuthPage(
      eyebrow: 'Reset your password',
      light: 'Forgot ',
      bold: 'your password?',
      lead:
          "Enter your email or muid and we'll send you a link to set a new one.",
      bottom: MuButton(
        label: 'Send reset link',
        block: true,
        loading: loading,
        loadingLabel: 'Sending…',
        onPressed: _submit,
      ),
      children: [
        Form(
          key: _formKey,
          child: MuTextField(
            label: 'Email or muid',
            hint: 'you@college.edu',
            controller: _emailOrMuidController,
            enabled: !loading,
            autofocus: true,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.send,
            onSubmitted: (_) => _submit(),
            validator: (v) => (v?.trim().isEmpty ?? true)
                ? 'Enter your email or muid to continue.'
                : null,
          ),
        ),
      ],
    );
  }
}
