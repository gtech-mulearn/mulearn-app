import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/utils/unescape_literal_unicode.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_progress_bars.dart';
import 'package:mulearn_app/features/profile/domain/entities/level_task.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_level.dart';
import 'package:mulearn_app/features/profile/presentation/providers/public_profile_controller.dart';
import 'package:mulearn_app/features/profile/presentation/providers/user_levels_controller.dart';
import 'package:url_launcher/url_launcher.dart';

/// Level-by-level task progression — mirrors the reference dashboard's Mu
/// Voyage tab. Pass [publicMuid] to view another user's levels instead of
/// the signed-in user's own.
class MuVoyageTab extends ConsumerWidget {
  const MuVoyageTab({super.key, this.publicMuid});

  final String? publicMuid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final levelsState = publicMuid == null
        ? ref.watch(userLevelsProvider)
        : ref.watch(publicUserLevelsProvider(publicMuid!));

    return levelsState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) =>
          Center(child: Text(ApiException.messageFor(error))),
      data: (levels) => ListView(
        padding: const EdgeInsets.fromLTRB(MuSpace.screenH, MuSpace.screenH, MuSpace.screenH, MuSpace.navClearance),
        children: [
          if (publicMuid == null)
            Padding(
              padding: const EdgeInsets.only(bottom: MuSpace.l),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('MU VOYAGE', style: MuType.eyebrow),
                  GestureDetector(
                    onTap: () => context.push(RoutePaths.journey),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'See the map',
                          style: MuType.bodyMed.copyWith(color: MuColors.primary, fontSize: 13),
                        ),
                        const SizedBox(width: 2),
                        const Icon(LucideIcons.arrowRight, size: 14, color: MuColors.primary),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          for (final level in levels)
            Padding(
              padding: const EdgeInsets.only(bottom: MuSpace.m),
              child: _LevelSection(level: level),
            ),
        ],
      ),
    );
  }
}

class _LevelSection extends StatelessWidget {
  const _LevelSection({required this.level});

  final UserLevel level;

  @override
  Widget build(BuildContext context) {
    final total = level.tasks.length;
    final completed = level.tasks.where((t) => t.completed).length;
    final ringValue = total == 0 ? 1.0 : completed / total;
    final ringColor = ringValue >= 1
        ? MuColors.success
        : ringValue > 0
            ? MuColors.primary
            : MuColors.inkFaint;

    return MuCard(
      padding: EdgeInsets.zero,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: MuSpace.l),
          childrenPadding: const EdgeInsets.only(bottom: MuSpace.s),
          leading: MuProgressRing(
            value: ringValue,
            size: 36,
            strokeWidth: 4,
            color: ringColor,
          ),
          title: Text(level.name, style: MuType.bodyMed),
          subtitle: Text(
            '$completed / $total tasks completed',
            style: MuType.caption,
          ),
          trailing: Text(
            '${level.karma}',
            style: MuType.statSmall.copyWith(color: MuColors.primary, fontSize: 15),
          ),
          children: [
            for (final task in level.tasks) _TaskTile(task: task),
          ],
        ),
      ),
    );
  }
}

class _TaskTile extends StatelessWidget {
  const _TaskTile({required this.task});

  final LevelTask task;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: task.active ? 1 : 0.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: MuSpace.l, vertical: MuSpace.s),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              task.completed ? LucideIcons.checkCircle2 : LucideIcons.circle,
              size: 20,
              color: task.completed ? MuColors.success : MuColors.inkTertiary,
            ),
            const SizedBox(width: MuSpace.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.taskName,
                    style: MuType.body.copyWith(
                      color: task.completed ? MuColors.inkTertiary : MuColors.ink,
                      decoration: task.completed ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  if (task.taskDescription != null)
                    MarkdownBody(
                      data: unescapeLiteralUnicode(task.taskDescription!),
                      onTapLink: (text, href, title) {
                        if (href == null) return;
                        final uri = Uri.tryParse(href);
                        if (uri != null) {
                          launchUrl(uri, mode: LaunchMode.externalApplication);
                        }
                      },
                      styleSheet: MarkdownStyleSheet(
                        p: MuType.caption,
                        h1: MuType.bodyMed,
                        h2: MuType.bodyMed,
                        h3: MuType.body,
                        strong: MuType.caption.copyWith(fontWeight: FontWeight.w700),
                        a: MuType.caption.copyWith(
                          color: MuColors.primary,
                          decoration: TextDecoration.underline,
                        ),
                        listBullet: MuType.caption,
                        blockquote: MuType.caption.copyWith(color: MuColors.inkTertiary),
                        code: MuType.caption.copyWith(
                          backgroundColor: MuColors.canvas,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: MuSpace.s),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: MuSpace.s, vertical: 2),
              decoration: BoxDecoration(
                color: MuColors.primaryTint,
                borderRadius: BorderRadius.circular(MuRadius.chip),
              ),
              child: Text(
                '+${task.karma}',
                style: MuType.chip.copyWith(color: MuColors.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
