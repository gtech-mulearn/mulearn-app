import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_chip.dart';
import 'package:mulearn_app/core/widgets/mu_empty_state.dart';
import 'package:mulearn_app/features/tasks/domain/entities/task_catalog_item.dart';
import 'package:mulearn_app/features/tasks/presentation/providers/tasks_controller.dart';

String _categoryLabel(TaskCategory category) => switch (category) {
      TaskCategory.startJourney => 'Start your journey',
      TaskCategory.becomeExpert => 'Become an expert',
      TaskCategory.events => 'Events',
    };

/// Task discovery — browses the real, dedicated task catalog (`GET
/// /api/v1/dashboard/task/list/`) confirmed live. DESIGN_SPEC.md §2 "04 —
/// Task discovery", adapted to real fields: no difficulty tags or "N doing
/// this" counts (not in this response), filter chips key off the response's
/// own three categories rather than a fabricated difficulty axis, and the
/// card's tag pill shows the real `type` (e.g. "Volunteering", "IGLU").
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
      backgroundColor: MuColors.canvas,
      body: SafeArea(
        child: tasksState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => ErrorRetryView(
            error: error,
            onRetry: () => ref.invalidate(tasksControllerProvider),
          ),
          data: (tasks) => _TasksList(
            tasks: tasks,
            filter: _filter,
            onFilterChanged: (value) => setState(() => _filter = value),
          ),
        ),
      ),
    );
  }
}

class _TasksList extends StatelessWidget {
  const _TasksList({
    required this.tasks,
    required this.filter,
    required this.onFilterChanged,
  });

  final List<TaskCatalogItem> tasks;
  final TaskCategory? filter;
  final ValueChanged<TaskCategory?> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    final filtered =
        filter == null ? tasks : tasks.where((t) => t.category == filter).toList();

    final sectionLabel =
        filter == null ? 'ALL TASKS' : '${_categoryLabel(filter!).toUpperCase()} TASKS';

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        MuSpace.screenH,
        MuSpace.l,
        MuSpace.screenH,
        MuSpace.navClearance,
      ),
      children: [
        Text('Tasks', style: MuType.display.copyWith(fontSize: 28)),
        const SizedBox(height: MuSpace.xs),
        Text(
          "Real tasks from μLearn's Discord. Pick one, ship it, earn karma.",
          style: MuType.body.copyWith(color: MuColors.inkSecondary),
        ),
        const SizedBox(height: MuSpace.l),
        SizedBox(
          height: 36,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              MuFilterChip(
                label: 'All',
                selected: filter == null,
                onTap: () => onFilterChanged(null),
              ),
              for (final category in TaskCategory.values) ...[
                const SizedBox(width: MuSpace.s),
                MuFilterChip(
                  label: _categoryLabel(category),
                  selected: filter == category,
                  onTap: () => onFilterChanged(category),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: MuSpace.xl),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(sectionLabel, style: MuType.eyebrow),
            Text('${filtered.length} shown', style: MuType.caption),
          ],
        ),
        const SizedBox(height: MuSpace.m),
        if (filtered.isEmpty)
          const Padding(
            padding: EdgeInsets.only(top: MuSpace.xxl),
            child: MuEmptyState(
              icon: LucideIcons.search,
              title: 'Nothing here yet',
              message: 'Nothing here yet — try another filter.',
            ),
          )
        else
          for (final task in filtered) ...[
            _TaskCard(task: task),
            const SizedBox(height: MuSpace.m),
          ],
      ],
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({required this.task});

  final TaskCatalogItem task;

  @override
  Widget build(BuildContext context) {
    return MuCard(
      onTap: () => context.push(RoutePaths.taskDetailPath(task.id)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (task.interestGroupName != null)
                MuTagChip(label: task.interestGroupName!.toUpperCase()),
              if (task.type != null) ...[
                if (task.interestGroupName != null) const SizedBox(width: MuSpace.s),
                MuTagChip(label: task.type!.toUpperCase()),
              ],
              const Spacer(),
              if (task.completed)
                Row(
                  children: [
                    const Icon(LucideIcons.checkCircle2, size: 14, color: MuColors.success),
                    const SizedBox(width: 4),
                    Text('Done', style: MuType.caption.copyWith(color: MuColors.success)),
                  ],
                ),
            ],
          ),
          const SizedBox(height: MuSpace.s),
          Text(task.title, style: MuType.title),
          if (task.description != null && task.description!.isNotEmpty) ...[
            const SizedBox(height: MuSpace.xs),
            Text(
              task.description!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: MuType.body.copyWith(color: MuColors.inkSecondary, fontSize: 13),
            ),
          ],
          const SizedBox(height: MuSpace.m),
          Row(
            children: [
              const Icon(LucideIcons.zap, size: 16, color: MuColors.karmaAccent),
              const SizedBox(width: 4),
              Text(
                '${task.karma}',
                style: MuType.chip.copyWith(color: MuColors.ink, fontWeight: FontWeight.w800),
              ),
              if (task.level != null) ...[
                const SizedBox(width: MuSpace.m),
                Text(
                  task.level!.toUpperCase(),
                  style: MuType.caption,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
