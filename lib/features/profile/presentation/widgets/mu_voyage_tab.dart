import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/features/profile/domain/entities/level_task.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_level.dart';
import 'package:mulearn_app/features/profile/presentation/providers/public_profile_controller.dart';
import 'package:mulearn_app/features/profile/presentation/providers/user_levels_controller.dart';

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
        padding: const EdgeInsets.all(16),
        children: [
          for (final level in levels) _LevelSection(level: level),
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
    final theme = Theme.of(context);
    final completed = level.tasks.where((t) => t.completed).length;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        title: Text(level.name, style: theme.textTheme.titleSmall),
        subtitle: Text('$completed / ${level.tasks.length} tasks completed'),
        trailing: Text('${level.karma} karma'),
        children: [
          for (final task in level.tasks) _TaskTile(task: task),
        ],
      ),
    );
  }
}

class _TaskTile extends StatelessWidget {
  const _TaskTile({required this.task});

  final LevelTask task;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        task.completed ? Icons.check_circle : Icons.radio_button_unchecked,
        color: task.completed ? Colors.green : MulearnColors.gray600,
      ),
      title: Text(task.taskName),
      subtitle:
          task.taskDescription != null ? Text(task.taskDescription!) : null,
      trailing: Text('+${task.karma}'),
      enabled: task.active,
    );
  }
}
