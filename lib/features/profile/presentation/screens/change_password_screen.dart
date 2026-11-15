import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/features/profile/domain/password_rules.dart';
import 'package:mulearn_app/features/profile/presentation/providers/change_password_controller.dart';

/// Settings → Change password. Rules match the dashboard; the backend's
/// "Current Password is incorrect" shows under the current-password field.
class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _current = TextEditingController();
  final _next = TextEditingController();
  final _confirm = TextEditingController();
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
    FocusScope.of(context).unfocus();
    final ok = await ref
        .read(changePasswordControllerProvider.notifier)
        .submit(current: _current.text, next: _next.text);
    if (!mounted) return;
    if (ok) {
      MuToast.show(
        context,
        message: 'Password changed',
        type: MuToastType.success,
      );
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
      MuToast.show(
        context,
        message: ApiException.messageFor(error ?? 'Something went wrong'),
        type: MuToastType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final saving = ref.watch(changePasswordControllerProvider).isLoading;

    return Scaffold(
      backgroundColor: c.chalk,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MuTopBar.detail(title: 'Password'),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  MuSpacing.space5,
                  MuSpacing.space3,
                  MuSpacing.space5,
                  MuSpacing.space8,
                ),
                children: [
                  Text(
                    'Use at least 8 characters, different from your current password.',
                    style: mu.text.body.copyWith(color: c.ink2),
                  ),
                  const SizedBox(height: MuSpacing.space5),
                  AutofillGroup(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          MuTextField(
                            label: 'Current password',
                            controller: _current,
                            obscure: true,
                            error: _currentServerError,
                            autofillHints: const [AutofillHints.password],
                            textInputAction: TextInputAction.next,
                            validator: (v) => currentPasswordError(v ?? ''),
                          ),
                          const SizedBox(height: MuSpacing.space4),
                          MuTextField(
                            label: 'New password',
                            controller: _next,
                            obscure: true,
                            error: _nextServerError,
                            autofillHints: const [AutofillHints.newPassword],
                            textInputAction: TextInputAction.next,
                            validator: (v) => newPasswordError(
                              current: _current.text,
                              next: v ?? '',
                            ),
                          ),
                          const SizedBox(height: MuSpacing.space4),
                          MuTextField(
                            label: 'Confirm new password',
                            controller: _confirm,
                            obscure: true,
                            autofillHints: const [AutofillHints.newPassword],
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) => _submit(),
                            validator: (v) => confirmPasswordError(
                              next: _next.text,
                              confirm: v ?? '',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                MuSpacing.space5,
                MuSpacing.space2,
                MuSpacing.space5,
                MuSpacing.space4,
              ),
              child: MuButton(
                label: 'Change password',
                block: true,
                loading: saving,
                loadingLabel: 'Saving…',
                onPressed: _submit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
