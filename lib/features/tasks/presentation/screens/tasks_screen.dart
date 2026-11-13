import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/features/tasks/domain/entities/task_catalog_item.dart';
import 'package:mulearn_app/features/tasks/presentation/providers/tasks_controller.dart';

String _categoryLabel(TaskCategory category) => switch (category) {
  TaskCategory.startJourney => 'Start your journey',
  TaskCategory.becomeExpert => 'Become an expert',
  TaskCategory.events => 'Events',
};

/// Task discovery over the real task catalog (`GET
/// /api/v1/dashboard/task/list/`), built from the design system (artifact:
/// Screen patterns → Tasks). Each task is a card with its hashtag on a tab;
/// filters are the catalog's own three categories.
class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({super.key});

  @override
  ConsumerState<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen> {
  /// `null` = "All" — every category.
  TaskCategory? _filter;

  @override
  Widget build(BuildContext context) {
    final tasksState = ref.watch(tasksControllerProvider);

    return Scaffold(
      backgroundColor: context.mu.colors.chalk,
      body: SafeArea(
        bottom: false,
        child: tasksState.when(
          skipError: true,
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => ErrorRetryView(error: error, onRetry: () => ref.invalidate(tasksControllerProvider)),
          data: (tasks) => MuRefresh(
            onRefresh: () => ref.refresh(tasksControllerProvider.future),
            child: _TasksList(
              tasks: tasks,
              filter: _filter,
              onFilterChanged: (value) => setState(() => _filter = value),
            ),
          ),
        ),
      ),
    );
  }
}

class _TasksList extends StatelessWidget {
  const _TasksList({required this.tasks, required this.filter, required this.onFilterChanged});

  final List<TaskCatalogItem> tasks;
  final TaskCategory? filter;
  final ValueChanged<TaskCategory?> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final filtered = filter == null ? tasks : tasks.where((t) => t.category == filter).toList();
    final done = filtered.where((t) => t.completed).length;

    return ListView(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      padding: const EdgeInsets.only(top: MuSpacing.space4, bottom: MuSpacing.navClearance),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MuSpacing.space5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Semantics(
                header: true,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'Pick a task, ', style: mu.text.displayLight.copyWith(fontSize: 34)),
                      TextSpan(text: 'earn karma', style: mu.text.display.copyWith(fontSize: 34)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: MuSpacing.space2),
              Text(
                "Real tasks from μLearn's Discord. Ship it, post it with the hashtag, earn karma.",
                style: mu.text.body.copyWith(color: mu.colors.ink2),
              ),
            ],
          ),
        ),
        const SizedBox(height: MuSpacing.space4),
        SizedBox(
          height: MuSizes.touchMin,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: MuSpacing.space5),
            children: [
              MuFilterChip(label: 'All', selected: filter == null, onTap: () => onFilterChanged(null)),
              for (final category in TaskCategory.values) ...[
                const SizedBox(width: MuSpacing.space2),
                MuFilterChip(
                  label: _categoryLabel(category),
                  selected: filter == category,
                  onTap: () => onFilterChanged(category),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: MuSpacing.space5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MuSpacing.space5),
          child: Text(
            done == 0 ? '${filtered.length} tasks' : '${filtered.length} tasks · $done done',
            style: mu.text.caption,
          ),
        ),
        const SizedBox(height: MuSpacing.space3),
        if (filtered.isEmpty)
          // The dashboard's μJourney tabs: "no-tasks" when there are none,
          // "no-results" when a filter left nothing (rules.md §8).
          MuStateDisplay(variant: filter == null ? MuStateVariant.noTasks : MuStateVariant.noResults)
        else
          for (final task in filtered)
            Padding(
              padding: const EdgeInsets.fromLTRB(MuSpacing.space5, 0, MuSpacing.space5, MuSpacing.space4),
              child: _TaskCard(task: task),
            ),
      ],
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({required this.task});

  final TaskCatalogItem task;

  @override
  Widget build(BuildContext context) {
    final eyebrow = [
      if (task.level != null && task.level!.isNotEmpty) task.level!,
      if (task.interestGroupName != null && task.interestGroupName!.isNotEmpty) task.interestGroupName!,
    ].join(' · ');
    return MuTaskCard(
      title: task.title,
      karma: task.karma.toInt(),
      hashtag: task.hashtag,
      eyebrow: eyebrow.isEmpty ? null : eyebrow,
      description: task.description,
      state: task.completed ? MuTaskState.done : MuTaskState.open,
      pills: [if (task.type != null && task.type!.isNotEmpty) MuPill(task.type!)],
      onTap: () => context.push(RoutePaths.taskDetailPath(task.id)),
    );
  }
}
