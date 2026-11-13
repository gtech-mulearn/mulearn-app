import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_scope.dart';
import 'package:mulearn_app/features/mentor/domain/entities/persona.dart';
import 'package:mulearn_app/features/mentor/presentation/providers/mentor_hub_providers.dart';
import 'package:mulearn_app/features/mentor/presentation/providers/persona_controller.dart';
import 'package:mulearn_app/features/mentor/presentation/widgets/session_labels.dart';

/// "Acting as Web Development ▾" under the hub's title; opens a sheet with
/// the mentor's scopes and Learner.
class ActingAsMenu extends ConsumerWidget {
  const ActingAsMenu({super.key});

  static String labelFor(Persona p, List<MentorScope> scopes) {
    if (!p.isMentor) return 'Acting as a learner';
    final name = p.scopeName ??
        scopes.where((s) => s.id == p.scopeId).map((s) => s.name).firstOrNull ??
        (p.scopeType == null ? null : scopeTypeLabel(p.scopeType!));
    return 'Acting as ${name ?? 'a mentor'}';
  }

  Future<void> _choose(BuildContext context, WidgetRef ref, Persona current, List<MentorScope> scopes) async {
    final picked = await showModalBottomSheet<({MentorScope? scope})>(
      context: context,
      showDragHandle: true,
      backgroundColor: MuColors.surface,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(MuSpace.screenH, 0, MuSpace.screenH, MuSpace.s),
              child: Text(
                'New sessions start in the scope you act in.',
                style: MuType.caption,
              ),
            ),
            for (final s in scopes)
              ListTile(
                leading: const Icon(LucideIcons.graduationCap, color: MuColors.primary),
                title: Text(s.name),
                subtitle: Text(scopeTypeLabel(s.type)),
                trailing: current.isMentor && current.scopeId == s.id
                    ? const Icon(LucideIcons.check, color: MuColors.primary)
                    : null,
                onTap: () => Navigator.pop(sheetContext, (scope: s)),
              ),
            ListTile(
              leading: const Icon(LucideIcons.user, color: MuColors.inkSecondary),
              title: const Text('Learner'),
              subtitle: const Text('Use μLearn as a learner'),
              trailing: current.isMentor ? null : const Icon(LucideIcons.check, color: MuColors.primary),
              onTap: () => Navigator.pop(sheetContext, (scope: null)),
            ),
          ],
        ),
      ),
    );
    if (picked == null || !context.mounted) return;
    final scope = picked.scope;
    if ((scope == null && !current.isMentor) || (scope != null && current.isMentor && current.scopeId == scope.id)) return;
    try {
      await ref.read(personaControllerProvider.notifier).switchTo(scope);
      if (context.mounted) {
        MuToast.show(
          context,
          message: scope == null ? 'Now acting as a learner' : 'Now acting as ${scope.name}',
          type: MuToastType.success,
        );
      }
    } on Object catch (e) {
      if (context.mounted) MuToast.show(context, message: ApiException.messageFor(e), type: MuToastType.error);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final persona = ref.watch(personaControllerProvider).value;
    final scopes = ref.watch(mentorOverviewProvider).value ?? const [];
    if (persona == null) return const SizedBox.shrink();
    return InkWell(
      onTap: () => unawaited(_choose(context, ref, persona, scopes)),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                labelFor(persona, scopes),
                style: MuType.caption.copyWith(color: MuColors.primary),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(LucideIcons.chevronDown, size: 14, color: MuColors.primary),
          ],
        ),
      ),
    );
  }
}
