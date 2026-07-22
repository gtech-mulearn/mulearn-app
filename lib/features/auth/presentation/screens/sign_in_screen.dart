import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/features/auth/presentation/providers/auth_controller.dart';

/// Email/MuID sign-in, matching the layout and copy of the reference
/// `mulearn-dashboard` login screen: password sign-in with an OTP-login
/// alternative, a forgot-password link, and native Google/Apple sign-in
/// (token exchange with `/auth/google-mobile/` / `/auth/apple-mobile/` —
/// confirmed real endpoints, distinct from the web-redirect flow the
/// reference dashboard uses, which this app can't replicate without deep
/// links).
///
/// Navigation on successful sign-in is handled by the router redirect, not
/// here.
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
  final _otpVerifyFormKey = GlobalKey<FormState>();

  final _emailOrMuidController = TextEditingController();
  final _passwordController = TextEditingController();
  final _otpEmailOrMuidController = TextEditingController();
  final _otpController = TextEditingController();

  bool _obscure = true;

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
      await ref.read(authControllerProvider.notifier).signInWithPassword(
            emailOrMuid: _emailOrMuidController.text.trim(),
            password: _passwordController.text,
          );
    } on Object catch (_) {
      // Surfaced via the ref.listen snackbar below.
    }
  }

  Future<void> _submitOtpRequest() async {
    if (!(_otpRequestFormKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    try {
      await ref.read(authControllerProvider.notifier).requestOtp(
            emailOrMuid: _otpEmailOrMuidController.text.trim(),
          );
      if (mounted) setState(() => _mode = _AuthMode.otpVerify);
    } on Object catch (_) {
      // Surfaced via the ref.listen snackbar below.
    }
  }

  Future<void> _submitOtpVerify() async {
    if (!(_otpVerifyFormKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    try {
      await ref.read(authControllerProvider.notifier).signInWithOtp(
            emailOrMuid: _otpEmailOrMuidController.text.trim(),
            otp: _otpController.text.trim(),
          );
    } on Object catch (_) {
      // Surfaced via the ref.listen snackbar below.
    }
  }

  void _switchMode(_AuthMode mode) => setState(() => _mode = mode);

  Future<void> _signInWithGoogle() async {
    try {
      await ref.read(authControllerProvider.notifier).signInWithGoogle();
    } on Object catch (_) {
      // Surfaced via the ref.listen snackbar below.
    }
  }

  Future<void> _signInWithApple() async {
    try {
      await ref.read(authControllerProvider.notifier).signInWithApple();
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: MuSpace.screenH, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(child: _BrandMark()),
              const SizedBox(height: 40),
              switch (_mode) {
                _AuthMode.password => _PasswordForm(
                    formKey: _passwordFormKey,
                    emailOrMuidController: _emailOrMuidController,
                    passwordController: _passwordController,
                    obscure: _obscure,
                    isLoading: isLoading,
                    onToggleObscure: () =>
                        setState(() => _obscure = !_obscure),
                    onForgotPassword: () =>
                        context.push(RoutePaths.forgotPassword),
                    onSwitchToOtp: () => _switchMode(_AuthMode.otpRequest),
                    onSubmit: _submitPassword,
                  ),
                _AuthMode.otpRequest => _OtpRequestForm(
                    formKey: _otpRequestFormKey,
                    emailOrMuidController: _otpEmailOrMuidController,
                    isLoading: isLoading,
                    onSwitchToPassword: () => _switchMode(_AuthMode.password),
                    onSubmit: _submitOtpRequest,
                  ),
                _AuthMode.otpVerify => _OtpVerifyForm(
                    formKey: _otpVerifyFormKey,
                    otpController: _otpController,
                    isLoading: isLoading,
                    onBack: () => _switchMode(_AuthMode.otpRequest),
                    onSubmit: _submitOtpVerify,
                  ),
              },
              if (_mode == _AuthMode.password) ...[
                const SizedBox(height: MuSpace.xl),
                _OrDivider(),
                const SizedBox(height: MuSpace.l),
                _SocialSignInButtons(
                  isLoading: isLoading,
                  onGoogle: _signInWithGoogle,
                  onApple: _signInWithApple,
                ),
                const SizedBox(height: MuSpace.xl),
                _SignUpFooter(
                  onSignUp: () => context.push(RoutePaths.registerBasicInfo),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _PasswordForm extends StatelessWidget {
  const _PasswordForm({
    required this.formKey,
    required this.emailOrMuidController,
    required this.passwordController,
    required this.obscure,
    required this.isLoading,
    required this.onToggleObscure,
    required this.onForgotPassword,
    required this.onSwitchToOtp,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailOrMuidController;
  final TextEditingController passwordController;
  final bool obscure;
  final bool isLoading;
  final VoidCallback onToggleObscure;
  final VoidCallback onForgotPassword;
  final VoidCallback onSwitchToOtp;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Welcome back', style: MuType.headline),
        const SizedBox(height: MuSpace.s),
        Text(
          'Sign in to continue to your account',
          style: MuType.body.copyWith(color: MuColors.inkSecondary),
        ),
        const SizedBox(height: MuSpace.xxl),
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: emailOrMuidController,
                textInputAction: TextInputAction.next,
                enabled: !isLoading,
                decoration: const InputDecoration(
                  labelText: 'Email or MuID',
                  hintText: 'email@example.com or muid',
                ),
                validator: (value) => (value?.trim().isEmpty ?? true)
                    ? 'Email or MuID is required.'
                    : null,
              ),
              const SizedBox(height: MuSpace.l),
              TextFormField(
                controller: passwordController,
                obscureText: obscure,
                textInputAction: TextInputAction.done,
                enabled: !isLoading,
                onFieldSubmitted: (_) => onSubmit(),
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscure ? LucideIcons.eye : LucideIcons.eyeOff,
                      color: MuColors.inkSecondary,
                    ),
                    onPressed: onToggleObscure,
                  ),
                ),
                validator: (value) =>
                    (value == null || value.isEmpty) ? 'Password is required.' : null,
              ),
              const SizedBox(height: MuSpace.m),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: isLoading ? null : onForgotPassword,
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: const Text('Forgot password?'),
                  ),
                  TextButton(
                    onPressed: isLoading ? null : onSwitchToOtp,
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: const Text('Login with OTP'),
                  ),
                ],
              ),
              const SizedBox(height: MuSpace.l),
              MuPrimaryButton(
                label: isLoading ? 'Signing in…' : 'Sign in',
                onPressed: isLoading ? null : onSubmit,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OtpRequestForm extends StatelessWidget {
  const _OtpRequestForm({
    required this.formKey,
    required this.emailOrMuidController,
    required this.isLoading,
    required this.onSwitchToPassword,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailOrMuidController;
  final bool isLoading;
  final VoidCallback onSwitchToPassword;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Login with OTP', style: MuType.headline),
        const SizedBox(height: MuSpace.s),
        Text(
          'Enter your email or MuID to receive an OTP',
          style: MuType.body.copyWith(color: MuColors.inkSecondary),
        ),
        const SizedBox(height: MuSpace.xxl),
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: emailOrMuidController,
                textInputAction: TextInputAction.done,
                enabled: !isLoading,
                onFieldSubmitted: (_) => onSubmit(),
                decoration: const InputDecoration(
                  labelText: 'Email or MuID',
                  hintText: 'email@example.com or muid',
                ),
                validator: (value) => (value?.trim().isEmpty ?? true)
                    ? 'Email or MuID is required.'
                    : null,
              ),
              const SizedBox(height: MuSpace.s),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: isLoading ? null : onSwitchToPassword,
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: const Text('Login with Password'),
                ),
              ),
              const SizedBox(height: MuSpace.s),
              MuPrimaryButton(
                label: isLoading ? 'Sending…' : 'Request OTP',
                onPressed: isLoading ? null : onSubmit,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OtpVerifyForm extends StatelessWidget {
  const _OtpVerifyForm({
    required this.formKey,
    required this.otpController,
    required this.isLoading,
    required this.onBack,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController otpController;
  final bool isLoading;
  final VoidCallback onBack;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextButton.icon(
          onPressed: isLoading ? null : onBack,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            alignment: Alignment.centerLeft,
          ),
          icon: const Icon(LucideIcons.arrowLeft, size: 18),
          label: const Text('Back'),
        ),
        const SizedBox(height: MuSpace.s),
        Text('Enter OTP', style: MuType.headline),
        const SizedBox(height: MuSpace.s),
        Text(
          "We've sent an OTP to your email. Enter it below to continue.",
          style: MuType.body.copyWith(color: MuColors.inkSecondary),
        ),
        const SizedBox(height: MuSpace.xxl),
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: otpController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                enabled: !isLoading,
                onFieldSubmitted: (_) => onSubmit(),
                decoration: const InputDecoration(labelText: 'OTP'),
                validator: (value) => (value?.trim().isEmpty ?? true)
                    ? 'OTP is required.'
                    : null,
              ),
              const SizedBox(height: MuSpace.l),
              MuPrimaryButton(
                label: isLoading ? 'Verifying…' : 'Verify OTP',
                onPressed: isLoading ? null : onSubmit,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MuSpace.m),
          child: Text('OR', style: MuType.caption),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}

class _SocialSignInButtons extends StatelessWidget {
  const _SocialSignInButtons({
    required this.isLoading,
    required this.onGoogle,
    required this.onApple,
  });

  final bool isLoading;
  final VoidCallback onGoogle;
  final VoidCallback onApple;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MuGhostButton(
          label: 'Continue with Google',
          icon: LucideIcons.chrome,
          onPressed: isLoading ? null : onGoogle,
        ),
        // Sign in with Apple is an Apple-platform-only affordance — Android
        // has no native Apple ID picker, so the button is never shown there.
        if (defaultTargetPlatform == TargetPlatform.iOS) ...[
          const SizedBox(height: MuSpace.m),
          MuGhostButton(
            label: 'Continue with Apple',
            icon: LucideIcons.apple,
            onPressed: isLoading ? null : onApple,
          ),
        ],
      ],
    );
  }
}

class _SignUpFooter extends StatelessWidget {
  const _SignUpFooter({required this.onSignUp});

  final VoidCallback onSignUp;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          style: MuType.body.copyWith(color: MuColors.inkSecondary),
          children: [
            const TextSpan(text: "Don't have an account? "),
            TextSpan(
              text: 'Sign up',
              style: const TextStyle(
                color: MuColors.primary,
                fontWeight: FontWeight.w600,
              ),
              recognizer: TapGestureRecognizer()..onTap = onSignUp,
            ),
          ],
        ),
      ),
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
            gradient: MuColors.heroGradient,
            borderRadius: BorderRadius.circular(MuRadius.inner),
          ),
          alignment: Alignment.center,
          child: const Text(
            'μ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(height: MuSpace.m),
        Text('μLearn', style: MuType.headline),
      ],
    );
  }
}
