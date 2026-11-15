import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
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
    final name =
        p.scopeName ??
        scopes.where((s) => s.id == p.scopeId).map((s) => s.name).firstOrNull ??
        (p.scopeType == null ? null : scopeTypeLabel(p.scopeType!));
    return 'Acting as ${name ?? 'a mentor'}';
  }

  Future<void> _choose(
    BuildContext context,
    WidgetRef ref,
    Persona current,
    List<MentorScope> scopes,
  ) async {
    final picked = await showMuSheet<({MentorScope? scope})>(
      context,
      builder: (sheetContext) => SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          MuSpacing.space5,
          0,
          MuSpacing.space5,
          MuSpacing.space5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Semantics(
              header: true,
              child: Text('Act as', style: sheetContext.mu.text.title2),
            ),
            const SizedBox(height: MuSpacing.space1),
            Text(
              'New sessions start in the scope you act in.',
              style: sheetContext.mu.text.caption,
            ),
            const SizedBox(height: MuSpacing.space4),
            for (final s in scopes) ...[
              MuRadioCard<String?>(
                value: s.id,
                groupValue: current.isMentor ? current.scopeId : null,
                title: s.name,
                subtitle: scopeTypeLabel(s.type),
                icon: LucideIcons.graduationCap,
                onChanged: (_) => Navigator.pop(sheetContext, (scope: s)),
              ),
              const SizedBox(height: MuSpacing.space2),
            ],
            MuRadioCard<String?>(
              value: '__learner__',
              groupValue: current.isMentor ? null : '__learner__',
              title: 'Learner',
              subtitle: 'Use μLearn as a learner',
              icon: LucideIcons.user,
              onChanged: (_) => Navigator.pop(sheetContext, (scope: null)),
            ),
          ],
        ),
      ),
    );
    if (picked == null || !context.mounted) return;
    final scope = picked.scope;
    final unchanged =
        (scope == null && !current.isMentor) ||
        (scope != null && current.isMentor && current.scopeId == scope.id);
    if (unchanged) return;
    try {
      await ref.read(personaControllerProvider.notifier).switchTo(scope);
      if (context.mounted) {
        MuToast.show(
          context,
          message: scope == null
              ? 'Now acting as a learner'
              : 'Now acting as ${scope.name}',
          type: MuToastType.success,
        );
      }
    } on Object catch (e) {
      if (context.mounted) {
        MuToast.show(
          context,
          message: ApiException.messageFor(e),
          type: MuToastType.error,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final persona = ref.watch(personaControllerProvider).value;
    final scopes = ref.watch(mentorOverviewProvider).value ?? const [];
    if (persona == null) return const SizedBox.shrink();
    final mu = context.mu;
    final c = mu.colors;
    return Semantics(
      button: true,
      label: '${labelFor(persona, scopes)}. Change',
      excludeSemantics: true,
      child: InkWell(
        onTap: () => unawaited(_choose(context, ref, persona, scopes)),
        borderRadius: BorderRadius.circular(MuRadii.round),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: MuSpacing.space1),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  labelFor(persona, scopes),
                  style: mu.text.label.copyWith(color: c.cobaltText),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 2),
              Icon(
                LucideIcons.chevronDown,
                size: MuSizes.iconSm,
                color: c.cobaltText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
