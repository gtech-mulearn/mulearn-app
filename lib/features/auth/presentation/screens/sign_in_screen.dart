import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_gradients.dart';
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
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(message)));
      }
    });

    final isLoading = state.isLoading;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
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
                const SizedBox(height: 24),
                _OrDivider(),
                const SizedBox(height: 20),
                _SocialSignInButtons(
                  isLoading: isLoading,
                  onGoogle: _signInWithGoogle,
                  onApple: _signInWithApple,
                ),
                const SizedBox(height: 24),
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
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Welcome back', style: theme.textTheme.headlineMedium),
        const SizedBox(height: 8),
        Text(
          'Sign in to continue to your account',
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
              const SizedBox(height: 16),
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
                      obscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: onToggleObscure,
                  ),
                ),
                validator: (value) =>
                    (value == null || value.isEmpty) ? 'Password is required.' : null,
              ),
              const SizedBox(height: 12),
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
              const SizedBox(height: 16),
              FilledButton(
                onPressed: isLoading ? null : onSubmit,
                child: isLoading ? const _ButtonSpinner() : const Text('Sign in'),
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
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Login with OTP', style: theme.textTheme.headlineMedium),
        const SizedBox(height: 8),
        Text(
          'Enter your email or MuID to receive an OTP',
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
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: isLoading ? null : onSwitchToPassword,
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: const Text('Login with Password'),
                ),
              ),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: isLoading ? null : onSubmit,
                child:
                    isLoading ? const _ButtonSpinner() : const Text('Request OTP'),
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
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextButton.icon(
          onPressed: isLoading ? null : onBack,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            alignment: Alignment.centerLeft,
          ),
          icon: const Icon(Icons.arrow_back, size: 18),
          label: const Text('Back'),
        ),
        const SizedBox(height: 8),
        Text('Enter OTP', style: theme.textTheme.headlineMedium),
        const SizedBox(height: 8),
        Text(
          "We've sent an OTP to your email. Enter it below to continue.",
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
              const SizedBox(height: 16),
              FilledButton(
                onPressed: isLoading ? null : onSubmit,
                child:
                    isLoading ? const _ButtonSpinner() : const Text('Verify OTP'),
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
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'OR',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: MulearnColors.gray600),
          ),
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
        OutlinedButton.icon(
          onPressed: isLoading ? null : onGoogle,
          icon: const _GoogleMark(),
          label: const Text('Continue with Google'),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: isLoading ? null : onApple,
          icon: const Icon(Icons.apple, size: 20),
          label: const Text('Continue with Apple'),
        ),
      ],
    );
  }
}

class _GoogleMark extends StatelessWidget {
  const _GoogleMark();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 18,
      width: 18,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        border: Border.fromBorderSide(BorderSide(color: MulearnColors.gray600)),
      ),
      child: const Text(
        'G',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: MulearnColors.gray600,
        ),
      ),
    );
  }
}

class _SignUpFooter extends StatelessWidget {
  const _SignUpFooter({required this.onSignUp});

  final VoidCallback onSignUp;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: RichText(
        text: TextSpan(
          style:
              theme.textTheme.bodyMedium?.copyWith(color: MulearnColors.gray600),
          children: [
            const TextSpan(text: "Don't have an account? "),
            TextSpan(
              text: 'Sign up',
              style: const TextStyle(
                color: MulearnColors.primary,
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
            gradient: MulearnGradients.trusty,
            borderRadius: BorderRadius.circular(14),
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
        const SizedBox(height: 12),
        Text(
          'μLearn',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w900),
        ),
      ],
    );
  }
}
