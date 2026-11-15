import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/session/discord_connect.dart';
import 'package:mulearn_app/core/session/session_providers.dart';
import 'package:mulearn_app/core/utils/external_links.dart';
import 'package:mulearn_app/core/utils/level_label.dart';
import 'package:mulearn_app/core/utils/unescape_literal_unicode.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/features/tasks/domain/entities/task_catalog_item.dart';
import 'package:mulearn_app/features/tasks/domain/task_submission.dart';
import 'package:mulearn_app/features/tasks/presentation/providers/tasks_controller.dart';

/// A task's brief (artifact: TaskCard → Detail screen): back + copy, a
/// huge title, hashtag / level / karma pills, the brief, links from it as a resources slab, and "Copy
/// hashtag & open Discord" pinned at the bottom as a slide to confirm. The
/// Discord link is the dashboard's: the task's channel in the μLearn
/// server, or the default task channel.
class TaskDetailScreen extends ConsumerWidget {
  const TaskDetailScreen({required this.taskId, super.key});

  final String taskId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksState = ref.watch(tasksControllerProvider);
    final task = tasksState.value?.where((t) => t.id == taskId).firstOrNull;

    return Scaffold(
      backgroundColor: context.mu.colors.chalk,
      body: SafeArea(
        child: Column(
          children: [
            MuTopBar.detail(
              action: task?.hashtag == null || task!.hashtag!.isEmpty
                  ? null
                  : MuIconButton(
                      icon: LucideIcons.copy,
                      tooltip: 'Copy hashtag',
                      variant: MuIconButtonVariant.cobalt,
                      onPressed: () => _copyHashtag(context, task),
                    ),
            ),
            Expanded(
              child: tasksState.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) =>
                    ErrorRetryView(error: error, onRetry: () => ref.invalidate(tasksControllerProvider)),
                data: (_) => task == null
                    ? const Center(
                        child: SingleChildScrollView(
                          child: MuStateDisplay(
                            variant: MuStateVariant.notFound,
                            title: 'Task not found',
                            description: "This task isn't available anymore.",
                          ),
                        ),
                      )
                    : _Body(task: task),
              ),
            ),
            if (task != null) _SubmitBar(task: task),
          ],
        ),
      ),
    );
  }
}

Future<void> _copyHashtag(BuildContext context, TaskCatalogItem task) async {
  await Clipboard.setData(ClipboardData(text: task.hashtag!));
  if (context.mounted) MuToast.show(context, message: 'Copied ${task.hashtag}', type: MuToastType.success);
}

final _urlPattern = RegExp(r'https?://[^\s)\]>"]+');

class _Body extends StatelessWidget {
  const _Body({required this.task});

  final TaskCatalogItem task;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final description = task.description == null ? '' : unescapeLiteralUnicode(task.description!).trim();
    final links = {for (final m in _urlPattern.allMatches(description)) m.group(0)!}.toList();
    final level = task.level == null || task.level!.isEmpty ? null : levelLabel(task.level);
    final hashtag = task.hashtag == null || task.hashtag!.isEmpty ? null : task.hashtag!;

    return ListView(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      padding: const EdgeInsets.fromLTRB(MuSpacing.space5, MuSpacing.space2, MuSpacing.space5, MuSpacing.space8),
      children: [
        Semantics(
          header: true,
          child: Text(task.title, style: mu.text.display.copyWith(fontSize: 38)),
        ),
        const SizedBox(height: MuSpacing.space4),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            if (hashtag != null) MuPill(hashtag, tone: MuPillTone.night, mono: true),
            if (level != null) MuPill(level, tone: MuPillTone.cobalt),
            if (task.completed)
              MuPill('+${muGrouped(task.karma.toInt())} earned', tone: MuPillTone.success, icon: LucideIcons.check)
            else
              MuPill('+${muGrouped(task.karma.toInt())} karma', tone: MuPillTone.volt),
            if (task.interestGroupName != null && task.interestGroupName!.isNotEmpty) MuPill(task.interestGroupName!),
          ],
        ),
        const SizedBox(height: MuSpacing.space6),
        if (description.isNotEmpty) ...[
          _Card(title: 'The brief', child: _Markdown(description)),
        ],
        if (links.isNotEmpty) ...[
          const SizedBox(height: MuSpacing.space3),
          _Resources(links: links),
        ],
        const SizedBox(height: MuSpacing.space4),
        Text(
          'Published by μLearn Foundation',
          style: mu.text.caption.copyWith(color: c.ink3),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    return Container(
      padding: const EdgeInsets.fromLTRB(MuSpacing.space5, MuSpacing.space4, MuSpacing.space5, MuSpacing.space4),
      decoration: BoxDecoration(color: mu.colors.surface, borderRadius: BorderRadius.circular(MuRadii.card)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: mu.text.title3),
          const SizedBox(height: MuSpacing.space2),
          child,
        ],
      ),
    );
  }
}

class _Markdown extends StatelessWidget {
  const _Markdown(this.data);

  final String data;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final body = mu.text.body.copyWith(color: c.ink2);
    return Consumer(
      builder: (context, ref, _) => MarkdownBody(
        data: data,
        onTapLink: (_, href, _) {
          final uri = href == null ? null : Uri.tryParse(href);
          if (uri != null) unawaited(ref.read(openExternalProvider)(uri));
        },
        styleSheet: MarkdownStyleSheet(
          p: body,
          h1: mu.text.title2,
          h2: mu.text.title3,
          h3: mu.text.bodyStrong,
          strong: body.copyWith(color: c.ink, fontWeight: FontWeight.w700),
          em: body.copyWith(fontStyle: FontStyle.italic),
          a: body.copyWith(color: c.cobaltText, decoration: TextDecoration.underline),
          listBullet: body,
          code: mu.text.codeSm.copyWith(color: c.ink, backgroundColor: c.surfaceSunk),
          codeblockDecoration: BoxDecoration(color: c.surfaceSunk, borderRadius: BorderRadius.circular(MuRadii.tag)),
          blockquote: body,
          blockquoteDecoration: BoxDecoration(color: c.surfaceSunk, borderRadius: BorderRadius.circular(MuRadii.tag)),
          blockquotePadding: const EdgeInsets.all(MuSpacing.space3),
        ),
      ),
    );
  }
}

class _Resources extends ConsumerWidget {
  const _Resources({required this.links});

  final List<String> links;

  static String _label(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null || uri.host.isEmpty) return url;
    return uri.host.replaceFirst(RegExp(r'^www\.'), '');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final c = mu.colors;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: c.cobalt, borderRadius: BorderRadius.circular(MuRadii.card)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Resources', style: mu.text.title3.copyWith(color: c.onCobalt)),
          const SizedBox(height: MuSpacing.space3),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final url in links)
                MuPressable(
                  onTap: () => unawaited(ref.read(openExternalProvider)(Uri.parse(url))),
                  child: Semantics(
                    link: true,
                    label: 'Open ${_label(url)}',
                    excludeSemantics: true,
                    child: MuPill(_label(url), tone: MuPillTone.paper, icon: LucideIcons.arrowUpRight),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// The pinned action: done tasks say so; otherwise connect Discord first
/// (proof is posted there), then slide to copy the hashtag and open the
/// task's channel.
class _SubmitBar extends ConsumerWidget {
  const _SubmitBar({required this.task});

  final TaskCatalogItem task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final c = mu.colors;
    final needsDiscord = ref.watch(capabilitiesProvider).value?.needsDiscord ?? false;
    final canConnect = ref.watch(discordAuthUriProvider) != null;

    final Widget child;
    if (task.completed) {
      child = Container(
        height: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: c.successTint, borderRadius: BorderRadius.circular(MuRadii.round)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(LucideIcons.checkCircle2, color: c.success, size: MuSizes.iconMd),
            const SizedBox(width: MuSpacing.space2),
            Text(
              'Completed · ${muGrouped(task.karma.toInt())} karma earned',
              style: mu.text.bodyStrong.copyWith(color: c.success),
            ),
          ],
        ),
      );
    } else if (needsDiscord && canConnect) {
      child = MuButton(
        label: 'Connect Discord to submit',
        icon: LucideIcons.messageCircle,
        variant: MuButtonVariant.ink,
        block: true,
        onPressed: () => unawaited(ref.read(discordConnectFlowProvider.notifier).start()),
      );
    } else {
      child = Center(
        child: MuSlideToConfirm(
          label: task.hashtag == null || task.hashtag!.isEmpty ? 'Open Discord to submit' : 'Copy hashtag & open Discord',
          confirmedLabel: 'Opened Discord',
          icon: LucideIcons.send,
          onConfirmed: () async {
            if (task.hashtag != null && task.hashtag!.isNotEmpty) {
              await Clipboard.setData(ClipboardData(text: task.hashtag!));
            }
            await ref.read(openExternalProvider)(taskDiscordUri(task));
          },
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(MuSpacing.space5, MuSpacing.space2, MuSpacing.space5, MuSpacing.space3),
      child: child,
    );
  }
}
