import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/utils/unescape_literal_unicode.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/core/widgets/mu_chip.dart';
import 'package:mulearn_app/core/widgets/mu_empty_state.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/features/tasks/domain/entities/task_catalog_item.dart';
import 'package:mulearn_app/features/tasks/presentation/providers/tasks_controller.dart';

/// Full task brief, from the real, dedicated task catalog (`GET
/// /api/v1/dashboard/task/list/`, confirmed live). Submission happens on
/// Discord — this endpoint gives a channel name + hashtag + a raw Discord
/// channel id, but no guild id, so no valid
/// `discord.com/channels/{guild}/{channel}` link can be built from it alone
/// (unlike the old `get-user-levels`-derived flow, which had a ready-made
/// URL). Rather than fabricate a link that would 404, this offers a "copy
/// submission info" action instead.
class TaskDetailScreen extends ConsumerWidget {
  const TaskDetailScreen({required this.taskId, super.key});

  final String taskId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksState = ref.watch(tasksControllerProvider);

    return Scaffold(
      backgroundColor: MuColors.canvas,
      appBar: AppBar(
        backgroundColor: MuColors.canvas,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: MuColors.ink),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        top: false,
        child: tasksState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => ErrorRetryView(
            error: error,
            onRetry: () => ref.invalidate(tasksControllerProvider),
          ),
          data: (tasks) {
            TaskCatalogItem? task;
            for (final t in tasks) {
              if (t.id == taskId) {
                task = t;
                break;
              }
            }
            if (task == null) {
              return const MuEmptyState(
                icon: LucideIcons.search,
                title: 'Task not found',
                message: "This task isn't available anymore.",
              );
            }
            return _TaskDetailBody(task: task);
          },
        ),
      ),
    );
  }
}

class _TaskDetailBody extends StatelessWidget {
  const _TaskDetailBody({required this.task});

  final TaskCatalogItem task;

  Future<void> _copySubmissionInfo(BuildContext context) async {
    final channel = task.channel;
    if (channel == null) return;
    final text = task.hashtag != null && task.hashtag!.isNotEmpty
        ? '#$channel — tag your submission with ${task.hashtag}'
        : '#$channel';
    await Clipboard.setData(ClipboardData(text: text));
    if (context.mounted) {
      MuToast.show(context, message: 'Copied', type: MuToastType.success);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasChannel = task.channel != null && task.channel!.isNotEmpty;

    return ListView(
      padding: const EdgeInsets.fromLTRB(MuSpace.screenH, 0, MuSpace.screenH, MuSpace.xxl),
      children: [
        Row(
          children: [
            if (task.interestGroupName != null) ...[
              MuTagChip(label: task.interestGroupName!.toUpperCase()),
              const SizedBox(width: MuSpace.s),
            ],
            if (task.type != null)
              MuTagChip(label: task.type!.toUpperCase()),
          ],
        ),
        const SizedBox(height: MuSpace.m),
        Text(task.title, style: MuType.display.copyWith(fontSize: 26)),
        if (task.level != null) ...[
          const SizedBox(height: MuSpace.xs),
          Text(
            task.level!.toUpperCase(),
            style: MuType.body.copyWith(color: MuColors.inkSecondary),
          ),
        ],
        const SizedBox(height: MuSpace.xl),
        _RewardTile(karma: task.karma, completed: task.completed),
        if (task.description != null && task.description!.isNotEmpty) ...[
          const SizedBox(height: MuSpace.xxl),
          Text("WHAT YOU'LL DO", style: MuType.eyebrow),
          const SizedBox(height: MuSpace.m),
          MarkdownBody(
            data: unescapeLiteralUnicode(task.description!),
            styleSheet: MarkdownStyleSheet(
              p: MuType.body.copyWith(color: const Color(0xFF33333A)),
              h1: MuType.headline,
              h2: MuType.title,
              h3: MuType.bodyMed,
              strong: MuType.bodyMed.copyWith(color: const Color(0xFF33333A)),
              em: MuType.body.copyWith(
                color: const Color(0xFF33333A),
                fontStyle: FontStyle.italic,
              ),
              a: MuType.body.copyWith(
                color: MuColors.primary,
                decoration: TextDecoration.underline,
              ),
              listBullet: MuType.body.copyWith(color: const Color(0xFF33333A)),
              blockquote: MuType.body.copyWith(color: MuColors.inkSecondary),
              blockquoteDecoration: BoxDecoration(
                color: MuColors.canvas,
                border: const Border(
                  left: BorderSide(color: MuColors.primary, width: 3),
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              blockquotePadding: const EdgeInsets.all(MuSpace.m),
              code: MuType.body.copyWith(
                color: const Color(0xFF33333A),
                backgroundColor: MuColors.canvas,
                fontFamily: 'monospace',
              ),
              codeblockDecoration: BoxDecoration(
                color: MuColors.canvas,
                borderRadius: BorderRadius.circular(MuRadius.inner),
              ),
            ),
          ),
        ],
        const SizedBox(height: MuSpace.xxl),
        Text('SUBMIT YOUR PROOF', style: MuType.eyebrow),
        const SizedBox(height: MuSpace.m),
        if (hasChannel) ...[
          MuPrimaryButton(
            label: 'Copy submission info',
            icon: LucideIcons.copy,
            onPressed: () => _copySubmissionInfo(context),
          ),
          const SizedBox(height: MuSpace.m),
          Text(
            task.hashtag != null && task.hashtag!.isNotEmpty
                ? "Post your proof in Discord's #${task.channel} channel, tagged ${task.hashtag}"
                : "Post your proof in Discord's #${task.channel} channel.",
            style: MuType.caption,
          ),
        ] else
          Text(
            'No Discord channel is listed for this task yet.',
            style: MuType.caption,
          ),
      ],
    );
  }
}

class _RewardTile extends StatelessWidget {
  const _RewardTile({required this.karma, required this.completed});

  final num karma;
  final bool completed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(MuSpace.l),
      decoration: BoxDecoration(
        color: MuColors.ink,
        borderRadius: BorderRadius.circular(MuRadius.inner),
      ),
      child: Row(
        children: [
          const Icon(LucideIcons.zap, color: MuColors.karmaAccent, size: 22),
          const SizedBox(width: MuSpace.s),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'REWARD',
                style: MuType.eyebrow.copyWith(color: Colors.white.withValues(alpha: 0.6)),
              ),
              Text(
                '$karma',
                style: MuType.stat.copyWith(color: MuColors.surface, fontSize: 24),
              ),
            ],
          ),
          const Spacer(),
          if (completed)
            Row(
              children: [
                const Icon(LucideIcons.checkCircle2, size: 16, color: MuColors.success),
                const SizedBox(width: 4),
                Text(
                  'Done',
                  style: MuType.chip.copyWith(color: MuColors.success),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
