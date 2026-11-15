import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/widgets/mu_logo.dart';
import 'package:mulearn_app/features/auth/domain/entities/social_sign_in_outcome.dart';
import 'package:mulearn_app/features/auth/presentation/providers/auth_controller.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_wizard_controller.dart';

/// Sign in (artifact Screen patterns → Authentication): one column on
/// `chalk`, "Welcome to μLearn", social sign-in first (Google in ink, Apple
/// outlined on Apple platforms), an "or with email" hairline, filled
/// fields, a blue Sign in, then Forgot password and a one-time-code path.
/// The code arrives in six cells and signs in on the last digit.
///
/// Logic is the dashboard login's: password, or OTP request then verify,
/// plus native Google/Apple token exchange (`/auth/google-mobile/`,
/// `/auth/apple-mobile/`). Navigation after sign-in is the router's.
class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

enum _AuthMode { password, otpRequest, otpVerify }

class _SignInScreenState extends ConsumerState<SignInScreen> {
  _AuthMode _mode = _AuthMode.password;

  final _passwordFormKey = GlobalKey<FormState>();
  final _otpRequestFormKey = GlobalKey<FormState>();

  final _emailOrMuidController = TextEditingController();
  final _passwordController = TextEditingController();
  final _otpEmailOrMuidController = TextEditingController();
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _emailOrMuidController.dispose();
    _passwordController.dispose();
    _otpEmailOrMuidController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _submitPassword() async {
    if (!(_passwordFormKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    try {
      await ref
          .read(authControllerProvider.notifier)
          .signInWithPassword(
            emailOrMuid: _emailOrMuidController.text.trim(),
            password: _passwordController.text,
          );
    } on Object catch (_) {
      // Surfaced via the ref.listen toast below.
    }
  }

  Future<void> _submitOtpRequest() async {
    if (!(_otpRequestFormKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    try {
      await ref
          .read(authControllerProvider.notifier)
          .requestOtp(emailOrMuid: _otpEmailOrMuidController.text.trim());
      if (mounted) setState(() => _mode = _AuthMode.otpVerify);
    } on Object catch (_) {
      // Surfaced via the ref.listen toast below.
    }
  }

  Future<void> _submitOtpVerify(String code) async {
    if (code.trim().length < 6) return;
    FocusScope.of(context).unfocus();
    try {
      await ref
          .read(authControllerProvider.notifier)
          .signInWithOtp(
            emailOrMuid: _otpEmailOrMuidController.text.trim(),
            otp: code.trim(),
          );
    } on Object catch (_) {
      // Surfaced via the ref.listen toast below; the code stays so it can
      // be corrected.
    }
  }

  void _switchMode(_AuthMode mode) {
    HapticFeedback.selectionClick();
    // Carry what was typed across: the same person, a different way in.
    if (mode == _AuthMode.otpRequest &&
        _otpEmailOrMuidController.text.isEmpty) {
      _otpEmailOrMuidController.text = _emailOrMuidController.text;
    }
    if (mode == _AuthMode.otpVerify) _otpController.clear();
    setState(() => _mode = mode);
  }

  Future<void> _signInWithGoogle() async {
    final SocialSignInOutcome outcome;
    try {
      outcome = await ref
          .read(authControllerProvider.notifier)
          .signInWithGoogle();
    } on Object catch (_) {
      return; // Surfaced via the ref.listen toast below.
    }
    if (outcome is SocialNeedsRegistration && mounted) {
      ref
          .read(registerWizardControllerProvider.notifier)
          .setGoogleSignUp(
            tempToken: outcome.tempToken,
            email: outcome.email,
            fullName: outcome.fullName,
          );
      await context.push(RoutePaths.registerBasicInfo);
    }
  }

  Future<void> _signInWithApple() async {
    try {
      await ref.read(authControllerProvider.notifier).signInWithApple();
    } on AppleAccountNotFound {
      if (!mounted) return;
      final create = await showMuConfirm(
        context,
        title: 'No account yet',
        body:
            "No μLearn account uses this Apple ID's email yet. Create an account with that email first, "
            'then sign in with Apple.',
        confirmLabel: 'Create account',
        cancelLabel: 'Close',
      );
      if (create) _startSignUp();
    } on Object catch (_) {
      // Surfaced via the ref.listen toast below.
    }
  }

  /// Normal (password) sign-up: drop any half-finished Google sign-up first.
  void _startSignUp() {
    ref.read(registerWizardControllerProvider.notifier).reset();
    context.push(RoutePaths.registerBasicInfo);
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final loading = ref.watch(authControllerProvider).isLoading;
    final showGoogle = ref
        .watch(googleNativeSignInDataSourceProvider)
        .isAvailable;
    final showApple = defaultTargetPlatform == TargetPlatform.iOS;

    ref.listen(authControllerProvider, (_, next) {
      // Apple's "no account" case gets its own sheet, not a toast.
      if (next.hasError &&
          !next.isLoading &&
          next.error is! AppleAccountNotFound) {
        MuToast.show(
          context,
          message: ApiException.messageFor(next.error!),
          type: MuToastType.error,
        );
      }
    });

    final (
      String eyebrow,
      String light,
      String bold,
      String lead,
    ) = switch (_mode) {
      _AuthMode.password => (
        'Sign in',
        'Welcome\nto ',
        'μLearn',
        'Pick up your karma where you left off.',
      ),
      _AuthMode.otpRequest => (
        'Sign in with a code',
        'One code, ',
        'no password',
        "Enter your email or muid and we'll send a 6-digit code.",
      ),
      _AuthMode.otpVerify => (
        'Check your email',
        'Enter ',
        'your code',
        'We sent a 6-digit code. It signs you in as soon as the last digit is in.',
      ),
    };

    return Scaffold(
      backgroundColor: c.chalk,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            MuSpacing.space5,
            MuSpacing.space3,
            MuSpacing.space5,
            MuSpacing.space8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  if (_mode != _AuthMode.password)
                    MuIconButton(
                      icon: LucideIcons.arrowLeft,
                      tooltip: 'Back',
                      onPressed: loading
                          ? null
                          : () => _switchMode(
                              _mode == _AuthMode.otpVerify
                                  ? _AuthMode.otpRequest
                                  : _AuthMode.password,
                            ),
                    )
                  else
                    const ExcludeSemantics(child: MuLogo.mark(size: 40)),
                ],
              ),
              const SizedBox(height: MuSpacing.space6),
              Text(
                eyebrow.toUpperCase(),
                style: mu.text.eyebrow.copyWith(color: c.ink3),
              ),
              const SizedBox(height: MuSpacing.space2),
              Semantics(
                header: true,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: light,
                        style: mu.text.displayLight.copyWith(fontSize: 40),
                      ),
                      TextSpan(
                        text: bold,
                        style: mu.text.display.copyWith(fontSize: 40),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: MuSpacing.space2),
              Text(
                lead,
                style: mu.text.bodyLg.copyWith(fontSize: 16, color: c.ink2),
              ),
              const SizedBox(height: MuSpacing.space6),
              ...switch (_mode) {
                _AuthMode.password => [
                  if (showGoogle) ...[
                    MuButton(
                      label: 'Continue with Google',
                      icon: LucideIcons.chrome,
                      variant: MuButtonVariant.ink,
                      block: true,
                      onPressed: loading ? null : _signInWithGoogle,
                    ),
                    const SizedBox(height: MuSpacing.space3),
                  ],
                  // Sign in with Apple has no native picker on Android.
                  if (showApple) ...[
                    MuButton(
                      label: 'Continue with Apple',
                      icon: LucideIcons.apple,
                      variant: MuButtonVariant.outline,
                      block: true,
                      onPressed: loading ? null : _signInWithApple,
                    ),
                    const SizedBox(height: MuSpacing.space3),
                  ],
                  if (showGoogle || showApple) ...[
                    const _OrDivider(),
                    const SizedBox(height: MuSpacing.space4),
                  ],
                  Form(
                    key: _passwordFormKey,
                    child: AutofillGroup(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          MuTextField(
                            label: 'Email or muid',
                            hint: 'you@college.edu',
                            controller: _emailOrMuidController,
                            enabled: !loading,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            autofillHints: const [
                              AutofillHints.username,
                              AutofillHints.email,
                            ],
                            validator: (v) => (v?.trim().isEmpty ?? true)
                                ? 'Enter your email or muid to continue.'
                                : null,
                          ),
                          const SizedBox(height: MuSpacing.space4),
                          MuTextField(
                            label: 'Password',
                            controller: _passwordController,
                            obscure: true,
                            enabled: !loading,
                            textInputAction: TextInputAction.done,
                            autofillHints: const [AutofillHints.password],
                            onSubmitted: (_) => _submitPassword(),
                            validator: (v) => (v == null || v.isEmpty)
                                ? 'Enter your password.'
                                : null,
                          ),
                          const SizedBox(height: MuSpacing.space5),
                          MuButton(
                            label: 'Sign in',
                            block: true,
                            loading: loading,
                            loadingLabel: 'Signing you in…',
                            onPressed: _submitPassword,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: MuSpacing.space2),
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      MuButton(
                        label: 'Forgot password',
                        variant: MuButtonVariant.ghost,
                        size: MuButtonSize.small,
                        onPressed: loading
                            ? null
                            : () => context.push(RoutePaths.forgotPassword),
                      ),
                      MuButton(
                        label: 'Use a code instead',
                        variant: MuButtonVariant.ghost,
                        size: MuButtonSize.small,
                        onPressed: loading
                            ? null
                            : () => _switchMode(_AuthMode.otpRequest),
                      ),
                    ],
                  ),
                  const SizedBox(height: MuSpacing.space6),
                  _NewHere(onSignUp: loading ? null : _startSignUp),
                ],
                _AuthMode.otpRequest => [
                  Form(
                    key: _otpRequestFormKey,
                    child: MuTextField(
                      label: 'Email or muid',
                      hint: 'you@college.edu',
                      controller: _otpEmailOrMuidController,
                      enabled: !loading,
                      autofocus: _otpEmailOrMuidController.text.isEmpty,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _submitOtpRequest(),
                      validator: (v) => (v?.trim().isEmpty ?? true)
                          ? 'Enter your email or muid to continue.'
                          : null,
                    ),
                  ),
                  const SizedBox(height: MuSpacing.space5),
                  MuButton(
                    label: 'Send code',
                    block: true,
                    loading: loading,
                    loadingLabel: 'Sending…',
                    onPressed: _submitOtpRequest,
                  ),
                  const SizedBox(height: MuSpacing.space2),
                  Center(
                    child: MuButton(
                      label: 'Use my password',
                      variant: MuButtonVariant.ghost,
                      size: MuButtonSize.small,
                      onPressed: loading
                          ? null
                          : () => _switchMode(_AuthMode.password),
                    ),
                  ),
                ],
                _AuthMode.otpVerify => [
                  MuOtpField(
                    label:
                        'Code sent to ${_otpEmailOrMuidController.text.trim()}',
                    controller: _otpController,
                    enabled: !loading,
                    onCompleted: _submitOtpVerify,
                  ),
                  const SizedBox(height: MuSpacing.space5),
                  if (loading)
                    const Center(
                      child: MuDotsLoader(label: 'Checking your code…'),
                    )
                  else
                    MuButton(
                      label: 'Verify and sign in',
                      block: true,
                      onPressed: () => _submitOtpVerify(_otpController.text),
                    ),
                  const SizedBox(height: MuSpacing.space2),
                  Center(
                    child: MuButton(
                      label: 'Send a new code',
                      variant: MuButtonVariant.ghost,
                      size: MuButtonSize.small,
                      onPressed: loading ? null : _submitOtpRequest,
                    ),
                  ),
                ],
              },
            ],
          ),
        ),
      ),
    );
  }
}

/// "or with email" between two hairlines.
class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: c.line)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MuSpacing.space3),
          child: Text(
            'or with email',
            style: mu.text.caption.copyWith(color: c.ink3),
          ),
        ),
        Expanded(child: Container(height: 1, color: c.line)),
      ],
    );
  }
}

/// "New to μLearn? Create an account".
class _NewHere extends StatelessWidget {
  const _NewHere({required this.onSignUp});

  final VoidCallback? onSignUp;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          'New to μLearn?',
          style: mu.text.body.copyWith(color: mu.colors.ink2),
        ),
        MuButton(
          label: 'Create an account',
          variant: MuButtonVariant.ghost,
          size: MuButtonSize.small,
          onPressed: onSignUp,
        ),
      ],
    );
  }
}
