import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_wizard_controller.dart';

/// Registration step 1 — basic info (full name, email, password), matching
/// the reference dashboard's step 1 of 3.
class RegisterBasicInfoScreen extends ConsumerStatefulWidget {
  const RegisterBasicInfoScreen({super.key});

  @override
  ConsumerState<RegisterBasicInfoScreen> createState() =>
      _RegisterBasicInfoScreenState();
}

class _RegisterBasicInfoScreenState
    extends ConsumerState<RegisterBasicInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

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
    ref.read(registerWizardControllerProvider.notifier).setBasicInfo(
          fullName: _fullNameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
    context.push(RoutePaths.registerRoleSelection);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MuColors.canvas,
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: MuSpace.screenH),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Step into the community', style: MuType.headline),
              const SizedBox(height: MuSpace.s),
              Text(
                'Create your account to get started',
                style: MuType.body.copyWith(color: MuColors.inkSecondary),
              ),
              const SizedBox(height: MuSpace.xxl),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _fullNameController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        hintText: 'Enter your full name',
                      ),
                      validator: (value) {
                        final v = value?.trim() ?? '';
                        if (v.length < 3) {
                          return 'Full name must be at least 3 characters.';
                        }
                        if (v.length > 100) {
                          return 'Full name must be at most 100 characters.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: MuSpace.l),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        hintText: 'Email address',
                      ),
                      validator: (value) {
                        final v = value?.trim() ?? '';
                        if (v.isEmpty || !v.contains('@')) {
                          return 'Enter a valid email.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: MuSpace.l),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Create password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? LucideIcons.eye : LucideIcons.eyeOff,
                            color: MuColors.inkSecondary,
                          ),
                          onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                        ),
                      ),
                      validator: (value) {
                        final v = value ?? '';
                        if (v.length < 8) {
                          return 'Password must be at least 8 characters.';
                        }
                        if (v.length > 100) {
                          return 'Password must be at most 100 characters.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: MuSpace.l),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirm,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _continue(),
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        hintText: 'Re-enter password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirm ? LucideIcons.eye : LucideIcons.eyeOff,
                            color: MuColors.inkSecondary,
                          ),
                          onPressed: () => setState(
                            () => _obscureConfirm = !_obscureConfirm,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return "Passwords don't match.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: MuSpace.xl),
                    MuPrimaryButton(label: 'Continue', onPressed: _continue),
                  ],
                ),
              ),
              const SizedBox(height: MuSpace.l),
              Center(
                child: TextButton(
                  onPressed: () => context.pop(),
                  child: const Text('Already have an account? Sign in'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
