import 'package:mulearn_app/features/profile/domain/entities/achievement_progress.dart';

/// "In Progress": achievements the user has neither earned nor can claim
/// yet. `progress/` lists every achievement, so the dashboard filters out
/// eligible and earned ones (`profile/components/achievements.tsx`).
List<AchievementProgress> inProgressAchievements(
  List<AchievementProgress> progress, {
  required Set<String> earnedIds,
  required Set<String> eligibleIds,
}) =>
    [
      for (final p in progress)
        if (!p.eligible && !p.claimed && !earnedIds.contains(p.achievementId) && !eligibleIds.contains(p.achievementId))
          p,
    ];
