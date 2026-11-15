import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/config/flavor_config.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/features/auth/domain/entities/registration_role.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_wizard_controller.dart';
import 'package:mulearn_app/features/auth/presentation/widgets/auth_page.dart';

/// Sign-up step 2 of 4: the role, as radio cards (the dashboard's step 2).
/// There is no Company option: company accounts are made on the dashboard.
class RegisterRoleSelectionScreen extends ConsumerStatefulWidget {
  const RegisterRoleSelectionScreen({super.key});

  @override
  ConsumerState<RegisterRoleSelectionScreen> createState() => _RegisterRoleSelectionScreenState();
}

class _RegisterRoleSelectionScreenState extends ConsumerState<RegisterRoleSelectionScreen> {
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

  void _pick(RegistrationRole role) {
    HapticFeedback.selectionClick();
    setState(() => _selected = role);
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    return AuthPage(
      step: 2,
      steps: 4,
      eyebrow: 'Your role',
      light: 'How will you ',
      bold: 'take part?',
      lead: 'You can add more roles later. Many people learn and mentor at once.',
      bottom: MuButton(label: 'Continue', block: true, knob: true, onPressed: _selected == null ? null : _continue),
      children: [
        MuRadioCard<RegistrationRole>(
          value: RegistrationRole.student,
          groupValue: _selected,
          icon: LucideIcons.graduationCap,
          title: 'Learner',
          subtitle: 'Build skills across domains and earn karma for real work.',
          onChanged: _pick,
        ),
        const SizedBox(height: MuSpacing.space3),
        MuRadioCard<RegistrationRole>(
          value: RegistrationRole.mentor,
          groupValue: _selected,
          icon: LucideIcons.compass,
          title: 'Mentor',
          subtitle: 'Guide learners. Company employees pick their company during setup.',
          onChanged: _pick,
        ),
        const SizedBox(height: MuSpacing.space3),
        MuRadioCard<RegistrationRole>(
          value: RegistrationRole.enabler,
          groupValue: _selected,
          icon: LucideIcons.building2,
          title: 'Enabler',
          subtitle: 'Represent an institution or organisation that supports μLearn.',
          onChanged: _pick,
        ),
        const SizedBox(height: MuSpacing.space5),
        Text(
          'Representing a company? Company accounts are created on the μLearn dashboard.',
          style: mu.text.caption.copyWith(color: c.ink2),
        ),
        const SizedBox(height: 2),
        SelectableText(FlavorConfig.instance.dashboardUrl, style: mu.text.caption.copyWith(color: c.cobaltText)),
      ],
    );
  }
}
