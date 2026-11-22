import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/moderation/blocked_user.dart';
import 'package:mulearn_app/core/moderation/blocked_users.dart';
import 'package:mulearn_app/core/moderation/moderation_sheet.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/utils/external_links.dart';
import 'package:mulearn_app/core/utils/search_debouncer.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_markdown.dart';
import 'package:mulearn_app/features/projects/domain/entities/project.dart';
import 'package:mulearn_app/features/projects/presentation/providers/projects_providers.dart';

/// One project: screenshots, what it is, links, skills, the team, upvotes
/// and comments. Its owner also edits, publishes or archives it, manages
/// the team and deletes it.
class ProjectDetailScreen extends ConsumerWidget {
  const ProjectDetailScreen({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(projectProvider(id));
    final viewer = ref.watch(projectsViewerProvider).value;
    final project = state.value;
    final owns =
        project != null && viewer != null && project.ownerId == viewer.id;
    return Scaffold(
      backgroundColor: context.mu.colors.chalk,
      body: SafeArea(
        child: Column(
          children: [
            MuTopBar.detail(
              action: owns
                  ? MuIconButton(
                      icon: LucideIcons.moreHorizontal,
                      tooltip: 'Project actions',
                      onPressed: () => _OwnerMenu.show(context, project),
                    )
                  : project == null
                  ? null
                  : MuIconButton(
                      icon: LucideIcons.flag,
                      tooltip: 'Report or block',
                      onPressed: () => unawaited(
                        showModerationSheet(
                          context,
                          kind: ModerationKind.project,
                          contentId: project.id,
                          contentTitle: project.title,
                          author: BlockedUser(
                            id: project.ownerId,
                            muid: project.ownerMuid,
                            name: project.ownerName,
                          ),
                        ),
                      ),
                    ),
            ),
            Expanded(
              child: state.when(
                skipLoadingOnRefresh: true,
                loading: () => const Center(
                  child: MuDotsLoader(label: 'Loading the project…'),
                ),
                error: (e, _) => ErrorRetryView(
                  error: e,
                  onRetry: () => ref.invalidate(projectProvider(id)),
                ),
                data: (p) =>
                    !owns &&
                        ref
                            .watch(blockedUsersProvider)
                            .blocks(id: p.ownerId, muid: p.ownerMuid)
                    ? Padding(
                        padding: const EdgeInsets.all(MuSpacing.space5),
                        child: MuEmptyLine(
                          'You blocked ${p.ownerName}. Unblock them in '
                          'Settings to see this project.',
                        ),
                      )
                    : _Body(project: p, viewerId: viewer?.id, owns: owns),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _toast(
  BuildContext context,
  WidgetRef ref, {
  required bool ok,
  required String done,
}) async {
  if (!context.mounted) return;
  final error = ref.read(projectActionsProvider).error;
  MuToast.show(
    context,
    message: ok
        ? done
        : ApiException.messageFor(error ?? "That didn't go through"),
    type: ok ? MuToastType.success : MuToastType.error,
  );
}

class _Body extends ConsumerWidget {
  const _Body({
    required this.project,
    required this.viewerId,
    required this.owns,
  });

  final Project project;
  final String? viewerId;
  final bool owns;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final c = mu.colors;
    final p = project;
    final busy = ref.watch(projectActionsProvider).isLoading;
    final blocked = ref.watch(blockedUsersProvider);
    final comments = [
      for (final cm in p.comments)
        if (!blocked.blocks(id: cm.authorId)) cm,
    ];
    final upvoted = p.upvoteBy(viewerId) != null;
    final pictures = [
      ...p.images,
      if (p.images.isEmpty && p.logoUrl != null) p.logoUrl!,
    ];
    return RefreshIndicator(
      onRefresh: () => ref.refresh(projectProvider(p.id).future),
      child: ListView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: const EdgeInsets.fromLTRB(
          MuSpacing.space5,
          MuSpacing.space2,
          MuSpacing.space5,
          MuSpacing.space8,
        ),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(MuRadii.card),
            child: AspectRatio(
              aspectRatio: 16 / 10,
              child: pictures.isEmpty
                  ? MuGeneratedPoster(text: p.title, fontSize: 40)
                  : PageView(
                      children: [
                        for (final (i, url) in pictures.indexed)
                          Semantics(
                            image: true,
                            label: 'Screenshot ${i + 1} of ${pictures.length}',
                            child: CachedNetworkImage(
                              imageUrl: url,
                              fit: BoxFit.cover,
                              errorWidget: (_, _, _) => MuGeneratedPoster(
                                text: p.title,
                                fontSize: 40,
                              ),
                            ),
                          ),
                      ],
                    ),
            ),
          ),
          if (pictures.length > 1) ...[
            const SizedBox(height: MuSpacing.space2),
            Text(
              '${pictures.length} screenshots · swipe',
              style: mu.text.caption,
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: MuSpacing.space5),
          Semantics(
            header: true,
            child: Text(p.title, style: mu.text.display.copyWith(fontSize: 30)),
          ),
          const SizedBox(height: MuSpacing.space2),
          Row(
            children: [
              Flexible(
                child: InkWell(
                  onTap: p.ownerMuid == null
                      ? null
                      : () => context.push(
                          RoutePaths.publicProfilePath(p.ownerMuid!),
                        ),
                  child: Text(
                    'by ${p.ownerName}',
                    style: mu.text.label.copyWith(color: c.cobaltText),
                  ),
                ),
              ),
              Text(' · ${formatDay(p.createdAt)}', style: mu.text.caption),
            ],
          ),
          const SizedBox(height: MuSpacing.space4),
          Wrap(
            spacing: MuSpacing.space2,
            runSpacing: MuSpacing.space2,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              MuButton(
                label: upvoted
                    ? 'Upvoted · ${p.upvotes}'
                    : 'Upvote · ${p.upvotes}',
                icon: LucideIcons.arrowBigUp,
                variant: upvoted
                    ? MuButtonVariant.volt
                    : MuButtonVariant.outline,
                size: MuButtonSize.small,
                onPressed:
                    busy ||
                        viewerId == null ||
                        p.status != ProjectStatus.published
                    ? null
                    : () => unawaited(
                        ref
                            .read(projectActionsProvider.notifier)
                            .toggleUpvote(p, viewerId!),
                      ),
              ),
              if (owns)
                switch (p.status) {
                  ProjectStatus.published => const MuPill(
                    'Published',
                    tone: MuPillTone.success,
                    icon: LucideIcons.globe,
                  ),
                  ProjectStatus.draft => const MuPill(
                    'Draft · only you see it',
                    icon: LucideIcons.pencil,
                  ),
                  ProjectStatus.archived => const MuPill(
                    'Archived',
                    icon: LucideIcons.archive,
                  ),
                },
            ],
          ),
          if (p.description.isNotEmpty) ...[
            const MuSectionEyebrow('ABOUT', top: MuSpacing.space6),
            MuMarkdown(p.description),
          ],
          if (p.links.isNotEmpty) ...[
            const MuSectionEyebrow('LINKS', top: MuSpacing.space6),
            MuFeedGroup(
              children: [
                for (final (i, l) in p.links.indexed)
                  MuFeedRow(
                    leading: const MuFeedIcon(
                      LucideIcons.link,
                      tone: MuFeedTone.event,
                    ),
                    subject: l.label,
                    time: Uri.tryParse(l.url)?.host ?? l.url,
                    trailing: Icon(
                      LucideIcons.arrowUpRight,
                      size: MuSizes.iconSm,
                      color: c.ink3,
                    ),
                    divider: i < p.links.length - 1,
                    onTap: () {
                      final uri = Uri.tryParse(l.url);
                      if (uri != null) {
                        unawaited(ref.read(openExternalProvider)(uri));
                      }
                    },
                  ),
              ],
            ),
          ],
          if (p.skills.isNotEmpty) ...[
            const MuSectionEyebrow('SKILLS', top: MuSpacing.space6),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [for (final s in p.skills) MuPill(s.name)],
            ),
          ],
          MuSectionEyebrow(
            'TEAM',
            top: MuSpacing.space6,
            action: owns ? 'Add' : null,
            onAction: owns ? () => _MemberSheet.show(context, p) : null,
          ),
          MuFeedGroup(
            children: [
              MuFeedRow(
                leading: MuAvatar(
                  name: p.ownerName,
                  size: MuSizes.avatarMd,
                  ring: false,
                ),
                subject: p.ownerName,
                time: 'Owner',
                divider: p.members.isNotEmpty,
                onTap: p.ownerMuid == null
                    ? null
                    : () => context.push(
                        RoutePaths.publicProfilePath(p.ownerMuid!),
                      ),
              ),
              for (final (i, m) in p.members.indexed)
                MuFeedRow(
                  leading: MuAvatar(
                    name: m.name,
                    url: m.photoUrl,
                    size: MuSizes.avatarMd,
                    ring: false,
                  ),
                  subject: m.name,
                  time: m.role ?? (m.muid == null ? 'Collaborator' : m.muid!),
                  trailing: owns
                      ? MuIconButton(
                          icon: LucideIcons.x,
                          tooltip: 'Remove ${m.name}',
                          variant: MuIconButtonVariant.sunk,
                          onPressed: busy
                              ? null
                              : () async {
                                  final sure = await showMuConfirm(
                                    context,
                                    title: 'Remove ${m.name}?',
                                    body: 'They come off the project team.',
                                    confirmLabel: 'Remove',
                                    destructive: true,
                                  );
                                  if (!sure || !context.mounted) return;
                                  final ok = await ref
                                      .read(projectActionsProvider.notifier)
                                      .removeMember(p.id, m.id);
                                  if (context.mounted) {
                                    await _toast(
                                      context,
                                      ref,
                                      ok: ok,
                                      done: '${m.name} removed',
                                    );
                                  }
                                },
                        )
                      : null,
                  divider: i < p.members.length - 1,
                  onTap: m.muid == null
                      ? null
                      : () =>
                            context.push(RoutePaths.publicProfilePath(m.muid!)),
                ),
            ],
          ),
          MuSectionEyebrow(
            'COMMENTS · ${comments.length}',
            top: MuSpacing.space6,
          ),
          if (comments.isEmpty)
            const MuEmptyLine('No comments yet. Say what you think.')
          else
            MuFeedGroup(
              children: [
                for (final (i, cm) in comments.indexed)
                  _CommentRow(
                    project: p,
                    comment: cm,
                    mine: cm.authorId == viewerId,
                    last: i == comments.length - 1,
                  ),
              ],
            ),
          const SizedBox(height: MuSpacing.space4),
          _Composer(projectId: p.id),
        ],
      ),
    );
  }
}

class _CommentRow extends ConsumerWidget {
  const _CommentRow({
    required this.project,
    required this.comment,
    required this.mine,
    required this.last,
  });

  final Project project;
  final ProjectComment comment;
  final bool mine;
  final bool last;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final now = ref.watch(clockProvider)();
    return MuFeedRow(
      leading: MuAvatar(name: comment.authorName, ring: false),
      subject: comment.authorName,
      time: formatAgo(comment.at, now),
      actions: [
        Text(comment.text, style: mu.text.body.copyWith(color: mu.colors.ink2)),
      ],
      trailing: mine
          ? MuIconButton(
              icon: LucideIcons.trash2,
              tooltip: 'Delete comment',
              variant: MuIconButtonVariant.sunk,
              onPressed: () async {
                final sure = await showMuConfirm(
                  context,
                  title: 'Delete your comment?',
                  body: 'It is removed for everyone.',
                  confirmLabel: 'Delete',
                  destructive: true,
                );
                if (!sure || !context.mounted) return;
                final ok = await ref
                    .read(projectActionsProvider.notifier)
                    .deleteComment(project.id, comment.id);
                if (context.mounted) {
                  await _toast(context, ref, ok: ok, done: 'Comment deleted');
                }
              },
            )
          : MuIconButton(
              icon: LucideIcons.flag,
              tooltip: 'Report or block',
              variant: MuIconButtonVariant.sunk,
              onPressed: () => unawaited(
                showModerationSheet(
                  context,
                  kind: ModerationKind.comment,
                  contentId: comment.id,
                  contentTitle: comment.text.length > 80
                      ? '${comment.text.substring(0, 80)}…'
                      : comment.text,
                  author: BlockedUser(
                    id: comment.authorId,
                    name: comment.authorName,
                  ),
                ),
              ),
            ),
      divider: !last,
    );
  }
}

class _Composer extends ConsumerStatefulWidget {
  const _Composer({required this.projectId});

  final String projectId;

  @override
  ConsumerState<_Composer> createState() => _ComposerState();
}

class _ComposerState extends ConsumerState<_Composer> {
  final _text = TextEditingController();

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final text = _text.text.trim();
    if (text.isEmpty) return;
    final ok = await ref
        .read(projectActionsProvider.notifier)
        .comment(widget.projectId, text);
    if (!mounted) return;
    if (ok) {
      _text.clear();
      FocusScope.of(context).unfocus();
    } else {
      await _toast(context, ref, ok: false, done: '');
    }
  }

  @override
  Widget build(BuildContext context) {
    final busy = ref.watch(projectActionsProvider).isLoading;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: MuTextField(
            label: 'Add a comment',
            controller: _text,
            hint: 'What stood out, or a question for the team',
            minLines: 1,
            maxLines: 4,
            textCapitalization: TextCapitalization.sentences,
          ),
        ),
        const SizedBox(width: MuSpacing.space2),
        MuIconButton(
          icon: LucideIcons.send,
          tooltip: 'Post comment',
          variant: MuIconButtonVariant.cobalt,
          onPressed: busy ? null : _send,
        ),
      ],
    );
  }
}

/// The owner's actions: edit, publish / unpublish, archive, delete.
class _OwnerMenu extends ConsumerWidget {
  const _OwnerMenu({required this.project});

  final Project project;

  static Future<void> show(BuildContext context, Project project) =>
      showMuSheet<void>(context, builder: (_) => _OwnerMenu(project: project));

  Future<void> _status(
    BuildContext context,
    WidgetRef ref,
    ProjectStatus to,
    String done,
  ) async {
    final ok = await ref
        .read(projectActionsProvider.notifier)
        .setStatus(project.id, to);
    if (!context.mounted) return;
    await _toast(context, ref, ok: ok, done: done);
    if (ok && context.mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final p = project;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        MuSpacing.space5,
        0,
        MuSpacing.space5,
        MuSpacing.space5,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(p.title, style: mu.text.title3),
          const SizedBox(height: MuSpacing.space4),
          MuFeedGroup(
            children: [
              MuFeedRow(
                leading: const MuFeedIcon(LucideIcons.pencil),
                subject: 'Edit project',
                onTap: () {
                  Navigator.of(context).pop();
                  unawaited(context.push(RoutePaths.projectEditPath(p.id)));
                },
              ),
              if (p.status != ProjectStatus.published)
                MuFeedRow(
                  leading: const MuFeedIcon(
                    LucideIcons.globe,
                    tone: MuFeedTone.karma,
                  ),
                  subject: 'Publish',
                  time: 'Everyone can see, upvote and comment',
                  onTap: () => _status(
                    context,
                    ref,
                    ProjectStatus.published,
                    'Published',
                  ),
                )
              else
                MuFeedRow(
                  leading: const MuFeedIcon(LucideIcons.eyeOff),
                  subject: 'Back to draft',
                  time: 'Only you see it',
                  onTap: () => _status(
                    context,
                    ref,
                    ProjectStatus.draft,
                    'Moved back to draft',
                  ),
                ),
              if (p.status != ProjectStatus.archived)
                MuFeedRow(
                  leading: const MuFeedIcon(LucideIcons.archive),
                  subject: 'Archive',
                  time: 'Keep it, hidden from others',
                  onTap: () =>
                      _status(context, ref, ProjectStatus.archived, 'Archived'),
                ),
              MuFeedRow(
                leading: const MuFeedIcon(
                  LucideIcons.trash2,
                  tone: MuFeedTone.problem,
                ),
                subject: 'Delete project',
                time: "This can't be undone",
                divider: false,
                onTap: () async {
                  final sure = await showMuConfirm(
                    context,
                    title: 'Delete ${p.title}?',
                    body:
                        'The project, its upvotes and comments are removed for good.',
                    confirmLabel: 'Delete',
                    destructive: true,
                  );
                  if (!sure || !context.mounted) return;
                  final ok = await ref
                      .read(projectActionsProvider.notifier)
                      .delete(p.id);
                  if (!context.mounted) return;
                  await _toast(context, ref, ok: ok, done: 'Project deleted');
                  if (ok && context.mounted) {
                    Navigator.of(context).pop();
                    context.pop();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Add a teammate by searching μLearn members (name or muid, two letters
/// or more), or add someone outside μLearn by the name typed. People
/// already on the team (owner included) aren't offered. A role is optional.
class _MemberSheet extends ConsumerStatefulWidget {
  const _MemberSheet({required this.project});

  final Project project;

  static Future<void> show(BuildContext context, Project project) =>
      showMuSheet<void>(
        context,
        builder: (_) => _MemberSheet(project: project),
      );

  @override
  ConsumerState<_MemberSheet> createState() => _MemberSheetState();
}

class _MemberSheetState extends ConsumerState<_MemberSheet> {
  final _search = TextEditingController();
  final _role = TextEditingController();
  String _query = '';
  late final _debouncer = SearchDebouncer((q) {
    if (mounted) setState(() => _query = q);
  });

  @override
  void dispose() {
    _debouncer.dispose();
    _search.dispose();
    _role.dispose();
    super.dispose();
  }

  Future<void> _add({
    required String name,
    String? muid,
    String? outsider,
  }) async {
    final ok = await ref
        .read(projectActionsProvider.notifier)
        .addMember(
          widget.project.id,
          muid: muid,
          externalName: outsider,
          role: _role.text,
        );
    if (!mounted) return;
    await _toast(context, ref, ok: ok, done: '$name joined the team');
    if (ok && mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final busy = ref.watch(projectActionsProvider).isLoading;
    final onTeam = {
      ?widget.project.ownerMuid,
      for (final m in widget.project.members) ?m.muid,
    };
    final typed = SearchDebouncer.normalize(_search.text);
    final found = ref.watch(projectPeopleSearchProvider(_query));
    final people = [
      for (final p in found.value ?? const <ProjectMember>[])
        if (!onTeam.contains(p.muid)) p,
    ];
    final outsiderName = widget.project.members.any(
      (m) => m.muid == null && m.name.toLowerCase() == typed.toLowerCase(),
    );
    return MuFormSheet(
      title: 'Add a teammate',
      lead:
          'Search μLearn members, or add someone who isn’t on μLearn by name.',
      action: MuButton(
        label: 'Done',
        variant: MuButtonVariant.outline,
        block: true,
        onPressed: () => Navigator.of(context).pop(),
      ),
      children: [
        MuSearchField(
          controller: _search,
          hint: 'Name or muid',
          autofocus: true,
          onChanged: (v) {
            setState(() {});
            _debouncer.onChanged(v);
          },
          onSubmitted: _debouncer.submit,
        ),
        MuTextField(
          label: 'Role (optional)',
          controller: _role,
          hint: 'Design, backend, research…',
        ),
        if (typed.length >= 2) ...[
          if (found.isLoading && people.isEmpty)
            const Center(child: MuDotsLoader(label: 'Searching…'))
          else if (found.hasError)
            MuEmptyLine(ApiException.messageFor(found.error!))
          else if (people.isEmpty && _query == typed)
            const MuEmptyLine('No μLearn member matches that.'),
          if (people.isNotEmpty)
            MuFeedGroup(
              children: [
                for (final (i, p) in people.indexed)
                  MuFeedRow(
                    leading: MuAvatar(
                      name: p.name,
                      url: p.photoUrl,
                      size: MuSizes.avatarMd,
                      ring: false,
                    ),
                    subject: p.name,
                    time: p.muid,
                    trailing: MuButton(
                      label: 'Add',
                      size: MuButtonSize.small,
                      variant: MuButtonVariant.outline,
                      onPressed: busy
                          ? null
                          : () => _add(muid: p.muid, name: p.name),
                    ),
                    divider: i < people.length - 1,
                  ),
              ],
            ),
          if (!outsiderName &&
              !people.any((p) => p.name.toLowerCase() == typed.toLowerCase()))
            MuFeedRow(
              leading: const MuFeedIcon(LucideIcons.userPlus),
              subject: 'Add “$typed”',
              time: 'Someone not on μLearn',
              trailing: MuButton(
                label: 'Add',
                size: MuButtonSize.small,
                variant: MuButtonVariant.ghost,
                onPressed: busy
                    ? null
                    : () => _add(outsider: typed, name: typed),
              ),
              divider: false,
            ),
        ] else
          Text('Type two letters or more to search.', style: mu.text.caption),
      ],
    );
  }
}
