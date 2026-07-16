import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/features/auth/domain/entities/registration_role.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_wizard_controller.dart';

/// Registration step 2 — role selection, matching the reference dashboard's
/// step 2 of 3.
class RegisterRoleSelectionScreen extends ConsumerStatefulWidget {
  const RegisterRoleSelectionScreen({super.key});

  @override
  ConsumerState<RegisterRoleSelectionScreen> createState() =>
      _RegisterRoleSelectionScreenState();
}

class _RegisterRoleSelectionScreenState
    extends ConsumerState<RegisterRoleSelectionScreen> {
  RegistrationRole? _selected;

  @override
  void initState() {
    super.initState();
    _selected = ref.read(registerWizardControllerProvider).role;
  }

  void _continue() {
    final role = _selected;
    if (role == null) return;
    ref.read(registerWizardControllerProvider.notifier).setRole(role);
    context.push(RoutePaths.registerDetails);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Tell us about yourself', style: theme.textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text(
                'Select your role to continue',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: MulearnColors.gray600),
              ),
              const SizedBox(height: 24),
              _RoleOptionCard(
                emoji: '🎓',
                label: 'Learner',
                description: "I'm a learner exploring and building skills "
                    'across diverse domains while earning karma through '
                    'meaningful contributions',
                selected: _selected == RegistrationRole.student,
                onTap: () => setState(() => _selected = RegistrationRole.student),
              ),
              const SizedBox(height: 12),
              _RoleOptionCard(
                emoji: '👨‍🏫',
                label: 'Mentor',
                description: 'I guide and support learners. Company '
                    'employees can choose this option and select their '
                    'company during setup.',
                selected: _selected == RegistrationRole.mentor,
                onTap: () => setState(() => _selected = RegistrationRole.mentor),
              ),
              const SizedBox(height: 12),
              _RoleOptionCard(
                emoji: '🤝',
                label: 'Enabler',
                description: 'I represent an institution or organisation '
                    'supporting the μLearn community.',
                selected: _selected == RegistrationRole.enabler,
                onTap: () => setState(() => _selected = RegistrationRole.enabler),
              ),
              const SizedBox(height: 12),
              _RoleOptionCard(
                emoji: '🏢',
                label: 'Company',
                description: "I'm registering my company for the first time "
                    'as the Point of Contact (POC). Employees should choose '
                    'Mentor.',
                selected: _selected == RegistrationRole.company,
                onTap: () => setState(() => _selected = RegistrationRole.company),
              ),
              const SizedBox(height: 28),
              FilledButton(
                onPressed: _selected == null ? null : _continue,
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleOptionCard extends StatelessWidget {
  const _RoleOptionCard({
    required this.emoji,
    required this.label,
    required this.description,
    required this.selected,
    required this.onTap,
  });

  final String emoji;
  final String label;
  final String description;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? MulearnColors.primary : MulearnColors.greyish,
            width: selected ? 1.5 : 1,
          ),
          color: selected
              ? MulearnColors.primary.withValues(alpha: 0.06)
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: MulearnColors.gray600),
                  ),
                ],
              ),
            ),
            Icon(
              selected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: selected ? MulearnColors.primary : MulearnColors.greyish,
            ),
          ],
        ),
      ),
    );
  }
}
