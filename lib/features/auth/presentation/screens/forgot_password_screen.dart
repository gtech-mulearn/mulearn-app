import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/features/auth/presentation/providers/auth_controller.dart';

/// Requests a password-reset email, matching the reference dashboard's
/// `/forgot-password` page. Once sent, offers a manual-entry path
/// ([RoutePaths.resetPassword]) to paste the emailed code/token, since this
/// app doesn't consume the reset link via a deep link.
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
      await ref.read(authControllerProvider.notifier).requestPasswordReset(
            emailOrMuid: _emailOrMuidController.text.trim(),
          );
      if (mounted) setState(() => _sent = true);
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
        MuToast.show(context, message: message, type: MuToastType.error);
      }
    });

    final isLoading = state.isLoading;

    return Scaffold(
      backgroundColor: MuColors.canvas,
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: MuSpace.screenH),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: MuSpace.m),
              Text('Forgot password?', style: MuType.headline),
              const SizedBox(height: MuSpace.s),
              Text(
                _sent
                    ? 'Check your email for a link to reset your password.'
                    : "Enter your email or MuID and we'll send you a link to "
                        'reset your password.',
                style: MuType.body.copyWith(color: MuColors.inkSecondary),
              ),
              const SizedBox(height: MuSpace.xxl),
              if (!_sent)
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _emailOrMuidController,
                        textInputAction: TextInputAction.done,
                        enabled: !isLoading,
                        onFieldSubmitted: (_) => _submit(),
                        decoration: const InputDecoration(
                          labelText: 'Email or MuID',
                          hintText: 'email@example.com or muid',
                        ),
                        validator: (value) => (value?.trim().isEmpty ?? true)
                            ? 'Email or MuID is required.'
                            : null,
                      ),
                      const SizedBox(height: MuSpace.xl),
                      MuPrimaryButton(
                        label: isLoading ? 'Sending…' : 'Send reset link',
                        onPressed: isLoading ? null : _submit,
                      ),
                    ],
                  ),
                ),
              if (_sent) ...[
                const SizedBox(height: MuSpace.s),
                Center(
                  child: TextButton(
                    onPressed: () => context.push(RoutePaths.resetPassword),
                    child: const Text('Already have a reset code? Enter it here'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
