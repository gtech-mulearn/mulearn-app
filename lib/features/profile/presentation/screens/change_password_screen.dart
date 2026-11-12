import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/features/profile/domain/password_rules.dart';
import 'package:mulearn_app/features/profile/presentation/providers/change_password_controller.dart';

/// Settings → Change password. Rules match the dashboard; the backend's
/// "Current Password is incorrect" shows under the current-password field.
class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _current = TextEditingController();
  final _next = TextEditingController();
  final _confirm = TextEditingController();
  final _obscure = <String, bool>{'current': true, 'next': true, 'confirm': true};
  String? _currentServerError;
  String? _nextServerError;

  @override
  void dispose() {
    _current.dispose();
    _next.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _currentServerError = null;
      _nextServerError = null;
    });
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final controller = ref.read(changePasswordControllerProvider.notifier);
    final ok = await controller.submit(current: _current.text, next: _next.text);
    if (!mounted) return;
    if (ok) {
      MuToast.show(context, message: 'Password changed', type: MuToastType.success);
      context.pop();
      return;
    }
    final error = ref.read(changePasswordControllerProvider).error;
    final api = error is ApiException ? error : null;
    final passwordErrors = api?.fieldErrors['password'];
    final currentErrors = api?.fieldErrors['current_password'];
    setState(() {
      if (api != null && api.message == 'Current Password is incorrect') {
        _currentServerError = api.message;
      } else if (currentErrors != null && currentErrors.isNotEmpty) {
        _currentServerError = currentErrors.first;
      } else if (passwordErrors != null && passwordErrors.isNotEmpty) {
        _nextServerError = passwordErrors.first;
      }
    });
    if (_currentServerError == null && _nextServerError == null) {
      MuToast.show(context, message: ApiException.messageFor(error ?? 'Something went wrong'), type: MuToastType.error);
    }
  }

  Widget _field({
    required String key,
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    String? serverError,
    TextInputAction action = TextInputAction.next,
  }) {
    final obscure = _obscure[key]!;
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      textInputAction: action,
      autofillHints: key == 'current' ? const [AutofillHints.password] : const [AutofillHints.newPassword],
      onFieldSubmitted: action == TextInputAction.done ? (_) => _submit() : null,
      forceErrorText: serverError,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: IconButton(
          tooltip: obscure ? 'Show password' : 'Hide password',
          icon: Icon(obscure ? LucideIcons.eye : LucideIcons.eyeOff, color: MuColors.inkSecondary),
          onPressed: () => setState(() => _obscure[key] = !obscure),
        ),
      ),
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    final saving = ref.watch(changePasswordControllerProvider).isLoading;
    return Scaffold(
      backgroundColor: MuColors.canvas,
      appBar: AppBar(backgroundColor: MuColors.canvas, title: Text('Password', style: MuType.headline)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(MuSpace.screenH),
          children: [
            Text(
              'Use at least 8 characters, different from your current password.',
              style: MuType.body.copyWith(color: MuColors.inkSecondary),
            ),
            const SizedBox(height: MuSpace.xl),
            AutofillGroup(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _field(
                      key: 'current',
                      label: 'Current password',
                      controller: _current,
                      serverError: _currentServerError,
                      validator: (v) => currentPasswordError(v ?? ''),
                    ),
                    const SizedBox(height: MuSpace.l),
                    _field(
                      key: 'next',
                      label: 'New password',
                      controller: _next,
                      serverError: _nextServerError,
                      validator: (v) => newPasswordError(current: _current.text, next: v ?? ''),
                    ),
                    const SizedBox(height: MuSpace.l),
                    _field(
                      key: 'confirm',
                      label: 'Confirm new password',
                      controller: _confirm,
                      action: TextInputAction.done,
                      validator: (v) => confirmPasswordError(next: _next.text, confirm: v ?? ''),
                    ),
                    const SizedBox(height: MuSpace.xl),
                    MuPrimaryButton(
                      label: saving ? 'Saving…' : 'Change password',
                      onPressed: saving ? null : _submit,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
