import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
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
    return Scaffold(
      backgroundColor: MuColors.canvas,
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: MuSpace.screenH),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Tell us about yourself', style: MuType.headline),
              const SizedBox(height: MuSpace.s),
              Text(
                'Select your role to continue',
                style: MuType.body.copyWith(color: MuColors.inkSecondary),
              ),
              const SizedBox(height: MuSpace.l),
              _RoleOptionCard(
                emoji: '🎓',
                label: 'Learner',
                description: "I'm a learner exploring and building skills "
                    'across diverse domains while earning karma through '
                    'meaningful contributions',
                selected: _selected == RegistrationRole.student,
                onTap: () => setState(() => _selected = RegistrationRole.student),
              ),
              const SizedBox(height: MuSpace.m),
              _RoleOptionCard(
                emoji: '👨‍🏫',
                label: 'Mentor',
                description: 'I guide and support learners. Company '
                    'employees can choose this option and select their '
                    'company during setup.',
                selected: _selected == RegistrationRole.mentor,
                onTap: () => setState(() => _selected = RegistrationRole.mentor),
              ),
              const SizedBox(height: MuSpace.m),
              _RoleOptionCard(
                emoji: '🤝',
                label: 'Enabler',
                description: 'I represent an institution or organisation '
                    'supporting the μLearn community.',
                selected: _selected == RegistrationRole.enabler,
                onTap: () => setState(() => _selected = RegistrationRole.enabler),
              ),
              const SizedBox(height: MuSpace.m),
              _RoleOptionCard(
                emoji: '🏢',
                label: 'Company',
                description: "I'm registering my company for the first time "
                    'as the Point of Contact (POC). Employees should choose '
                    'Mentor.',
                selected: _selected == RegistrationRole.company,
                onTap: () => setState(() => _selected = RegistrationRole.company),
              ),
              const SizedBox(height: MuSpace.xl),
              MuPrimaryButton(
                label: 'Continue',
                onPressed: _selected == null ? null : _continue,
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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(MuRadius.inner),
      child: Container(
        padding: const EdgeInsets.all(MuSpace.l),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MuRadius.inner),
          border: Border.all(
            color: selected ? MuColors.primary : MuColors.divider,
            width: selected ? 1.5 : 1,
          ),
          color: selected ? MuColors.primaryTint : MuColors.surface,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: MuSpace.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: MuType.bodyMed),
                  const SizedBox(height: MuSpace.xs),
                  Text(description, style: MuType.caption),
                ],
              ),
            ),
            Icon(
              selected ? LucideIcons.checkCircle2 : LucideIcons.circle,
              color: selected ? MuColors.primary : MuColors.divider,
            ),
          ],
        ),
      ),
    );
  }
}
