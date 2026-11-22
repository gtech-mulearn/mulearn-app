import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/moderation/blocked_user.dart';
import 'package:mulearn_app/core/moderation/blocked_users.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/utils/search_debouncer.dart';
import 'package:mulearn_app/core/widgets/mu_load_more_footer.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/features/projects/domain/entities/project.dart';
import 'package:mulearn_app/features/projects/presentation/providers/projects_providers.dart';

enum _Tab { explore, yours }

/// Projects, as on the dashboard: Explore what learners published (search,
/// upvotes, comments), or Yours — everything you made or are on, drafts
/// included. New project is pinned at the bottom.
class ProjectsScreen extends ConsumerStatefulWidget {
  const ProjectsScreen({super.key});

  @override
  ConsumerState<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends ConsumerState<ProjectsScreen> {
  final _search = TextEditingController();
  _Tab _tab = _Tab.explore;
  String _query = '';
  late final _debouncer = SearchDebouncer((q) {
    if (mounted) setState(() => _query = q);
  });

  @override
  void dispose() {
    _debouncer.dispose();
    _search.dispose();
    super.dispose();
  }

  bool _onScroll(ScrollNotification n) {
    if (_tab != _Tab.explore) return false;
    final feed = ref.read(projectsFeedProvider(_query)).value;
    if (n.metrics.extentAfter < 600 &&
        feed != null &&
        feed.hasMore &&
        feed.loadMoreError == null) {
      unawaited(ref.read(projectsFeedProvider(_query).notifier).loadMore());
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final mine = ref.watch(myProjectsProvider);
    return Scaffold(
      backgroundColor: c.chalk,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: MuRefresh(
                onRefresh: () => Future.wait([
                  ref.refresh(projectsFeedProvider(_query).future),
                  ref.refresh(myProjectsProvider.future),
                ]),
                child: NotificationListener<ScrollNotification>(
                  onNotification: _onScroll,
                  child: ListView(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsets.fromLTRB(
                      MuSpacing.space5,
                      MuSpacing.space2,
                      MuSpacing.space5,
                      MuSpacing.space8,
                    ),
                    children: [
                      if (Navigator.of(context).canPop()) ...[
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: MuIconButton(
                            icon: LucideIcons.arrowLeft,
                            tooltip: 'Back',
                            onPressed: () => context.pop(),
                          ),
                        ),
                        const SizedBox(height: MuSpacing.space3),
                      ],
                      Semantics(
                        header: true,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Built by\n',
                                style: mu.text.displayLight.copyWith(
                                  fontSize: 36,
                                ),
                              ),
                              TextSpan(
                                text: 'learners',
                                style: mu.text.display.copyWith(fontSize: 36),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: MuSpacing.space2),
                      Text(
                        'Projects μLearners made. Upvote what you like, say what you think, and show yours.',
                        style: mu.text.body.copyWith(color: c.ink2),
                      ),
                      const SizedBox(height: MuSpacing.space5),
                      MuSegmented<_Tab>(
                        values: _Tab.values,
                        selected: _tab,
                        label: (t) => t == _Tab.explore
                            ? 'Explore'
                            : ((mine.value?.isEmpty ?? true)
                                  ? 'Yours'
                                  : 'Yours · ${mine.value!.length}'),
                        onChanged: (t) => setState(() => _tab = t),
                      ),
                      const SizedBox(height: MuSpacing.space4),
                      if (_tab == _Tab.explore) ...[
                        MuSearchField(
                          controller: _search,
                          hint: 'Search projects',
                          onChanged: _debouncer.onChanged,
                          onSubmitted: _debouncer.submit,
                        ),
                        const SizedBox(height: MuSpacing.space4),
                        ..._explore(),
                      ] else
                        ..._yours(mine),
                    ],
                  ),
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: c.chalk,
                border: Border(top: BorderSide(color: c.line)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  MuSpacing.space5,
                  MuSpacing.space3,
                  MuSpacing.space5,
                  MuSpacing.space3,
                ),
                child: MuButton(
                  label: 'New project',
                  icon: LucideIcons.plus,
                  block: true,
                  onPressed: () => context.push(RoutePaths.projectNew),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _explore() {
    final blocked = ref.watch(blockedUsersProvider);
    List<Project> visible(List<Project> items) => [
      for (final p in items)
        if (!blocked.blocks(id: p.ownerId, muid: p.ownerMuid)) p,
    ];
    return ref
        .watch(projectsFeedProvider(_query))
        .when(
          skipError: true,
          loading: () => const [_Loading()],
          error: (e, _) => [
            _Problem(
              error: e,
              onRetry: () => ref.invalidate(projectsFeedProvider(_query)),
            ),
          ],
          data: (paged) => [
            if (visible(paged.items).isEmpty)
              MuEmptyLine(
                _query.isEmpty
                    ? 'No projects yet. Yours could be the first.'
                    : 'No project matches "$_query".',
              )
            else
              for (final p in visible(paged.items)) ...[
                ProjectCard(project: p),
                const SizedBox(height: MuSpacing.space4),
              ],
            if (paged.hasMore || paged.loadMoreError != null)
              MuLoadMoreFooter(
                isLoading: paged.isLoadingMore,
                error: paged.loadMoreError,
                onRetry: () =>
                    ref.read(projectsFeedProvider(_query).notifier).loadMore(),
              ),
          ],
        );
  }

  List<Widget> _yours(AsyncValue<List<Project>> mine) => mine.when(
    skipError: true,
    loading: () => const [_Loading()],
    error: (e, _) => [
      _Problem(error: e, onRetry: () => ref.invalidate(myProjectsProvider)),
    ],
    data: (items) => items.isEmpty
        ? const [
            MuEmptyLine(
              'Nothing here yet. Start one: a draft stays yours until you publish it.',
            ),
          ]
        : [
            MuFeedGroup(
              children: [
                for (var i = 0; i < items.length; i++)
                  MuFeedRow(
                    leading: _Logo(project: items[i], size: MuSizes.avatarMd),
                    subject: items[i].title,
                    time: [
                      '${items[i].upvotes} upvote${items[i].upvotes == 1 ? '' : 's'}',
                      '${items[i].comments.length} comment${items[i].comments.length == 1 ? '' : 's'}',
                    ].join(' · '),
                    actions: [_statusPill(items[i].status)],
                    trailing: Icon(
                      LucideIcons.chevronRight,
                      size: MuSizes.iconSm + 2,
                      color: context.mu.colors.ink3,
                    ),
                    divider: i < items.length - 1,
                    onTap: () =>
                        context.push(RoutePaths.projectPath(items[i].id)),
                  ),
              ],
            ),
          ],
  );
}

Widget _statusPill(ProjectStatus s) => switch (s) {
  ProjectStatus.published => const MuPill(
    'Published',
    tone: MuPillTone.success,
    icon: LucideIcons.globe,
  ),
  ProjectStatus.draft => const MuPill('Draft', icon: LucideIcons.pencil),
  ProjectStatus.archived => const MuPill('Archived', icon: LucideIcons.archive),
};

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsets.symmetric(vertical: MuSpacing.space8),
    child: Center(child: MuDotsLoader()),
  );
}

class _Problem extends StatelessWidget {
  const _Problem({required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(child: MuEmptyLine(ApiException.messageFor(error))),
      MuButton(
        label: 'Retry',
        variant: MuButtonVariant.ghost,
        size: MuButtonSize.small,
        onPressed: onRetry,
      ),
    ],
  );
}

/// The project's logo, or its initials on a generated tile.
class _Logo extends StatelessWidget {
  const _Logo({required this.project, required this.size});

  final Project project;
  final double size;

  @override
  Widget build(BuildContext context) => MuAvatar(
    name: project.title,
    url: project.logoUrl,
    size: size,
    ring: false,
  );
}

/// A published project as a card: its first screenshot (or a generated
/// poster), title, who made it, skills, upvotes and comments. Opens it.
class ProjectCard extends StatelessWidget {
  const ProjectCard({required this.project, super.key});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final p = project;
    final cover = p.images.isNotEmpty ? p.images.first : p.logoUrl;
    return Semantics(
      button: true,
      label: '${p.title}, by ${p.ownerName}, ${p.upvotes} upvotes',
      excludeSemantics: true,
      child: MuPressable(
        onTap: () => context.push(RoutePaths.projectPath(p.id)),
        pressedScale: 0.98,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: c.surface,
            borderRadius: BorderRadius.circular(MuRadii.card),
            border: Border.all(color: c.line),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: cover == null
                    ? MuGeneratedPoster(text: p.title, fontSize: 30)
                    : CachedNetworkImage(
                        imageUrl: cover,
                        fit: BoxFit.cover,
                        errorWidget: (_, _, _) =>
                            MuGeneratedPoster(text: p.title, fontSize: 30),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(MuSpacing.space4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p.title,
                      style: mu.text.title3,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text('by ${p.ownerName}', style: mu.text.caption),
                    if (p.skills.isNotEmpty) ...[
                      const SizedBox(height: MuSpacing.space3),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          for (final s in p.skills.take(4)) MuPill(s.name),
                        ],
                      ),
                    ],
                    const SizedBox(height: MuSpacing.space3),
                    Row(
                      children: [
                        Icon(
                          LucideIcons.arrowBigUp,
                          size: MuSizes.iconSm + 2,
                          color: c.ink2,
                        ),
                        const SizedBox(width: 4),
                        Text('${p.upvotes}', style: mu.text.label),
                        const SizedBox(width: MuSpacing.space4),
                        Icon(
                          LucideIcons.messageCircle,
                          size: MuSizes.iconSm,
                          color: c.ink2,
                        ),
                        const SizedBox(width: 4),
                        Text('${p.comments.length}', style: mu.text.label),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
