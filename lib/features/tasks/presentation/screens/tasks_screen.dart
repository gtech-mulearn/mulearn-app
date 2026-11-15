import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/utils/level_label.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/features/tasks/domain/entities/task_catalog_item.dart';
import 'package:mulearn_app/features/tasks/domain/task_submission.dart';
import 'package:mulearn_app/features/tasks/presentation/providers/tasks_controller.dart';

String _tabLabel(TaskCategory category) => switch (category) {
  TaskCategory.startJourney => 'Start journey',
  TaskCategory.becomeExpert => 'Become expert',
  TaskCategory.events => 'Events',
};

/// The dashboard's "Filter by" (All / Completed / Incomplete).
enum _Status { all, todo, done }

/// "Level 3" for a task's raw level ("lvl3"); null when it has none.
String? _levelOf(TaskCatalogItem task) =>
    (task.level == null || task.level!.isEmpty) ? null : levelLabel(task.level);

/// Tasks (artifact: Screen patterns → Tasks and challenges), with the
/// dashboard μJourney's logic: the catalog's three sections as segments,
/// search across title, hashtag, type, IG, channel and level, a
/// completed/incomplete filter, IG filters on Become expert, and tasks
/// grouped by level. No level is locked, as on the dashboard.
class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({super.key});

  @override
  ConsumerState<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen> {
  TaskCategory _tab = TaskCategory.startJourney;
  _Status _status = _Status.all;
  String? _ig;
  String _query = '';
  final _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _clearFilters() {
    _search.clear();
    setState(() {
      _query = '';
      _status = _Status.all;
      _ig = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tasksState = ref.watch(tasksControllerProvider);
    final levelState = ref.watch(myTaskLevelProvider);
    // Like the rest of the app (levelNumber): no level reads as Level 1.
    final myLevel = levelState.hasValue ? levelLabel(levelState.value) : null;

    return Scaffold(
      backgroundColor: context.mu.colors.chalk,
      body: SafeArea(
        bottom: false,
        child: tasksState.when(
          skipError: true,
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => ErrorRetryView(
            error: error,
            onRetry: () => ref.invalidate(tasksControllerProvider),
          ),
          data: (tasks) => MuRefresh(
            onRefresh: () {
              ref.invalidate(myTaskLevelProvider);
              return ref.refresh(tasksControllerProvider.future);
            },
            child: _body(context, tasks, myLevel),
          ),
        ),
      ),
    );
  }

  Widget _body(
    BuildContext context,
    List<TaskCatalogItem> tasks,
    String? myLevel,
  ) {
    final mu = context.mu;
    final inTab = tasks.where((t) => t.category == _tab).toList();
    final igs = <String>{
      if (_tab == TaskCategory.becomeExpert)
        for (final t in inTab)
          if (t.interestGroupName != null && t.interestGroupName!.isNotEmpty)
            t.interestGroupName!,
    }.toList()..sort();
    final ig = igs.contains(_ig) ? _ig : null;

    final shown = inTab.where((t) {
      if (_status == _Status.done && !t.completed) return false;
      if (_status == _Status.todo && t.completed) return false;
      if (ig != null && t.interestGroupName != ig) return false;
      return taskMatches(t, _query, levelText: _levelOf(t) ?? '');
    }).toList();

    // Grouped by level, Level 1 first; tasks without a level close the list.
    final groups = <String?, List<TaskCatalogItem>>{};
    for (final t in shown) {
      (groups[_levelOf(t)] ??= []).add(t);
    }
    final keys = groups.keys.toList()
      ..sort((a, b) {
        if (a == null) return 1;
        if (b == null) return -1;
        return levelNumber(a).compareTo(levelNumber(b));
      });
    final mine = myLevel;
    final done = shown.where((t) => t.completed).length;
    final filtered =
        _query.trim().isNotEmpty || _status != _Status.all || ig != null;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            MuSpacing.space5,
            MuSpacing.space4,
            MuSpacing.space5,
            0,
          ),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Semantics(
                  header: true,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Tasks for\n',
                          style: mu.text.displayLight.copyWith(fontSize: 36),
                        ),
                        TextSpan(
                          text: mine ?? 'you',
                          style: mu.text.display.copyWith(fontSize: 36),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: MuSpacing.space5),
                MuSearchField(
                  controller: _search,
                  hint: 'Search title, hashtag, IG, level…',
                  onChanged: (q) => setState(() => _query = q),
                ),
                const SizedBox(height: MuSpacing.space3),
                MuSegmented<TaskCategory>(
                  values: TaskCategory.values,
                  selected: _tab,
                  label: _tabLabel,
                  onChanged: (tab) => setState(() {
                    _tab = tab;
                    _ig = null;
                  }),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: MuSizes.touchMin + MuSpacing.space3 * 2,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: MuSpacing.space5,
                vertical: MuSpacing.space3,
              ),
              children: [
                for (final s in _Status.values) ...[
                  MuFilterChip(
                    label: switch (s) {
                      _Status.all => 'All',
                      _Status.todo => 'To do',
                      _Status.done => 'Completed',
                    },
                    selected: _status == s,
                    onTap: () => setState(() => _status = s),
                  ),
                  const SizedBox(width: MuSpacing.space2),
                ],
                if (igs.isNotEmpty) ...[
                  Center(
                    child: Container(
                      width: 1,
                      height: 24,
                      color: mu.colors.lineStrong,
                    ),
                  ),
                  const SizedBox(width: MuSpacing.space2),
                  for (final name in igs) ...[
                    MuFilterChip(
                      label: name,
                      selected: ig == name,
                      onTap: () =>
                          setState(() => _ig = ig == name ? null : name),
                    ),
                    const SizedBox(width: MuSpacing.space2),
                  ],
                ],
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            MuSpacing.space5,
            MuSpacing.space1,
            MuSpacing.space5,
            0,
          ),
          sliver: SliverToBoxAdapter(
            child: Text(
              [
                if (shown.length == 1) '1 task' else '${shown.length} tasks',
                if (done > 0) '$done completed',
              ].join(' · '),
              style: mu.text.caption,
            ),
          ),
        ),
        if (shown.isEmpty && filtered)
          SliverToBoxAdapter(
            child: MuStateDisplay(
              variant: MuStateVariant.noResults,
              description: _query.trim().isEmpty
                  ? 'No tasks match these filters.'
                  : 'No tasks match "${_query.trim()}". Try a different search.',
              action: MuButton(
                label: 'Clear filters',
                variant: MuButtonVariant.outline,
                size: MuButtonSize.small,
                onPressed: _clearFilters,
              ),
            ),
          )
        else if (shown.isEmpty)
          SliverToBoxAdapter(
            child: MuStateDisplay(
              variant: MuStateVariant.noTasks,
              description: _tab == TaskCategory.becomeExpert
                  ? 'Join an Interest Group to see its expert tasks.'
                  : null,
            ),
          )
        else
          for (final key in keys) ...[
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                MuSpacing.space5,
                MuSpacing.space8,
                MuSpacing.space5,
                MuSpacing.space3,
              ),
              sliver: SliverToBoxAdapter(
                child: _GroupHeader(
                  title: key ?? 'Any level',
                  tasks: groups[key]!,
                  here: key != null && key == mine,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: MuSpacing.space5),
              sliver: SliverList.separated(
                itemCount: groups[key]!.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: MuSpacing.space4),
                itemBuilder: (_, i) => _TaskCard(task: groups[key]![i]),
              ),
            ),
          ],
        const SliverToBoxAdapter(
          child: SizedBox(height: MuSpacing.navClearance),
        ),
      ],
    );
  }
}

class _GroupHeader extends StatelessWidget {
  const _GroupHeader({
    required this.title,
    required this.tasks,
    required this.here,
  });

  final String title;
  final List<TaskCatalogItem> tasks;
  final bool here;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final done = tasks.where((t) => t.completed).length;
    final karma = tasks.fold<num>(0, (sum, t) => sum + t.karma).toInt();
    return Semantics(
      header: true,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: mu.text.title2),
                const SizedBox(height: 2),
                Text(
                  [
                    '$done of ${tasks.length} done',
                    '${muGrouped(karma)} karma',
                  ].join(' · '),
                  style: mu.text.caption,
                ),
              ],
            ),
          ),
          if (here) const MuPill("You're here", tone: MuPillTone.volt),
        ],
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({required this.task});

  final TaskCatalogItem task;

  @override
  Widget build(BuildContext context) {
    // The level is the group header already; the eyebrow names the IG.
    final eyebrow = task.interestGroupName ?? '';
    return MuTaskCard(
      title: task.title,
      karma: task.karma.toInt(),
      hashtag: task.hashtag,
      eyebrow: eyebrow.isEmpty ? null : eyebrow,
      state: task.completed ? MuTaskState.done : MuTaskState.open,
      onTap: () => context.push(RoutePaths.taskDetailPath(task.id)),
    );
  }
}
