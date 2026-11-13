import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/config/feature_flags.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_chip.dart';
import 'package:mulearn_app/core/widgets/mu_progress_bars.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/features/profile/domain/achievement_sections.dart';
import 'package:mulearn_app/features/profile/domain/entities/achievement_progress.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_achievement.dart';
import 'package:mulearn_app/features/profile/presentation/providers/achievements_controller.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/issue_vc_dialog.dart';

/// Achievements (FEAT-06), like the dashboard's tab: on your own profile
/// "Earned", "Eligible" (claim) and "In Progress"; on someone else's, only
/// what they earned. Issuing a verifiable credential stays hidden
/// ([FeatureFlags.vcIssuance], SEC-04); an issued one can still be viewed.
class AchievementsTab extends StatefulWidget {
  const AchievementsTab({
    required this.muid,
    required this.userName,
    super.key,
    this.userEmail,
    this.isOwnProfile = true,
  });

  final String muid;
  final String userName;
  final String? userEmail;
  final bool isOwnProfile;

  @override
  State<AchievementsTab> createState() => _AchievementsTabState();
}

enum _Section { earned, eligible, inProgress }

class _AchievementsTabState extends State<AchievementsTab> {
  _Section _section = _Section.earned;

  @override
  Widget build(BuildContext context) {
    final list = switch (_section) {
      _Section.earned => _EarnedList(widget: widget),
      _Section.eligible => _EligibleList(muid: widget.muid),
      _Section.inProgress => _InProgressList(muid: widget.muid),
    };
    if (!widget.isOwnProfile) return _EarnedList(widget: widget);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(MuSpace.screenH, MuSpace.l, MuSpace.screenH, 0),
          child: Wrap(
            spacing: MuSpace.s,
            children: [
              for (final (section, label) in const [
                (_Section.earned, 'Earned'),
                (_Section.eligible, 'Eligible'),
                (_Section.inProgress, 'In Progress'),
              ])
                MuFilterChip(
                  label: label,
                  selected: _section == section,
                  onTap: () => setState(() => _section = section),
                ),
            ],
          ),
        ),
        Expanded(child: list),
      ],
    );
  }
}

const _listPadding = EdgeInsets.fromLTRB(MuSpace.screenH, MuSpace.screenH, MuSpace.screenH, MuSpace.navClearance);

class _Empty extends StatelessWidget {
  const _Empty(this.message);

  final String message;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(MuSpace.xl),
          child: Text(message, textAlign: TextAlign.center, style: MuType.body.copyWith(color: MuColors.inkSecondary)),
        ),
      );
}

class _EarnedList extends ConsumerWidget {
  const _EarnedList({required this.widget});

  final AchievementsTab widget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(userAchievementsProvider(widget.muid)).when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => ErrorRetryView(
            error: error,
            onRetry: () => ref.invalidate(userAchievementsProvider(widget.muid)),
          ),
          data: (achievements) {
            if (achievements.isEmpty) return const _Empty('No achievements yet.');
            return ListView.builder(
              padding: _listPadding,
              itemCount: achievements.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: MuSpace.m),
                child: _AchievementCard(
                  achievement: achievements[index],
                  muid: widget.muid,
                  userName: widget.userName,
                  userEmail: widget.userEmail,
                  isOwnProfile: widget.isOwnProfile,
                ),
              ),
            );
          },
        );
  }
}

class _EligibleList extends ConsumerWidget {
  const _EligibleList({required this.muid});

  final String muid;

  Future<void> _claim(BuildContext context, WidgetRef ref, AchievementProgress item) async {
    try {
      final result = await ref.read(achievementClaimControllerProvider.notifier).claim(item.achievementId, muid: muid);
      if (context.mounted) MuToast.show(context, message: result.message, type: MuToastType.success);
    } on Object catch (e) {
      if (context.mounted) MuToast.show(context, message: ApiException.messageFor(e), type: MuToastType.error);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final descriptions = ref.watch(achievementDescriptionsProvider).value ?? const {};
    return ref.watch(eligibleAchievementsProvider).when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => ErrorRetryView(error: error, onRetry: () => ref.invalidate(eligibleAchievementsProvider)),
          data: (items) {
            if (items.isEmpty) return const _Empty('Nothing to claim yet. Keep earning karma.');
            return ListView(
              padding: _listPadding,
              children: [
                for (final item in items)
                  Padding(
                    padding: const EdgeInsets.only(bottom: MuSpace.m),
                    child: _ProgressCard(
                      item: item,
                      description: descriptions[item.achievementId],
                      action: TextButton(onPressed: () => _claim(context, ref, item), child: const Text('Claim')),
                    ),
                  ),
              ],
            );
          },
        );
  }
}

class _InProgressList extends ConsumerWidget {
  const _InProgressList({required this.muid});

  final String muid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final descriptions = ref.watch(achievementDescriptionsProvider).value ?? const {};
    final earned = ref.watch(userAchievementsProvider(muid)).value ?? const [];
    final eligible = ref.watch(eligibleAchievementsProvider).value ?? const [];
    return ref.watch(achievementProgressProvider).when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => ErrorRetryView(error: error, onRetry: () => ref.invalidate(achievementProgressProvider)),
          data: (progress) {
            final items = inProgressAchievements(
              progress,
              earnedIds: {for (final e in earned) e.achievement.id},
              eligibleIds: {for (final e in eligible) e.achievementId},
            );
            if (items.isEmpty) return const _Empty('Nothing in progress right now.');
            return ListView(
              padding: _listPadding,
              children: [
                for (final item in items)
                  Padding(
                    padding: const EdgeInsets.only(bottom: MuSpace.m),
                    child: _ProgressCard(item: item, description: descriptions[item.achievementId], showProgress: true),
                  ),
              ],
            );
          },
        );
  }
}

String _number(num n) => n == n.roundToDouble() ? '${n.toInt()}' : '$n';

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({required this.item, this.description, this.action, this.showProgress = false});

  final AchievementProgress item;
  final String? description;
  final Widget? action;
  final bool showProgress;

  @override
  Widget build(BuildContext context) {
    final current = item.current;
    final required = item.required;
    return MuCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const _AchievementIcon(),
              const SizedBox(width: MuSpace.m),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name, style: MuType.bodyMed),
                    if (description != null)
                      Text(description!, style: MuType.caption, maxLines: 2, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              if (action != null) ...[const SizedBox(width: MuSpace.s), action!],
            ],
          ),
          if (showProgress) ...[
            const SizedBox(height: MuSpace.m),
            MuLinearProgress(value: (item.percentage ?? 0) / 100),
            const SizedBox(height: MuSpace.xs),
            Text(
              current != null && required != null ? '${_number(current)} / ${_number(required)}' : (item.reason ?? ''),
              style: MuType.caption.copyWith(color: MuColors.inkSecondary),
            ),
          ],
        ],
      ),
    );
  }
}

class _AchievementIcon extends StatelessWidget {
  const _AchievementIcon();

  @override
  Widget build(BuildContext context) => Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          color: MuColors.primaryTint,
          borderRadius: BorderRadius.circular(MuRadius.inner),
        ),
        alignment: Alignment.center,
        child: const Icon(LucideIcons.award, color: MuColors.primary),
      );
}

class _AchievementCard extends StatelessWidget {
  const _AchievementCard({
    required this.achievement,
    required this.muid,
    required this.userName,
    required this.isOwnProfile,
    this.userEmail,
  });

  final UserAchievement achievement;
  final String muid;
  final String userName;
  final String? userEmail;
  final bool isOwnProfile;

  @override
  Widget build(BuildContext context) {
    final vcUrl = achievement.vcUrl ?? '';
    final canView = achievement.isIssued && vcUrl.isNotEmpty;
    final canIssue = FeatureFlags.vcIssuance && isOwnProfile && !canView;
    return MuCard(
      child: Row(
        children: [
          const _AchievementIcon(),
          const SizedBox(width: MuSpace.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(achievement.achievement.achievementName, style: MuType.bodyMed),
                if (achievement.achievement.description != null)
                  Text(
                    achievement.achievement.description!,
                    style: MuType.caption,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          if (canView || canIssue) ...[
            const SizedBox(width: MuSpace.s),
            MuGhostButton(
              label: canView ? 'View' : 'Issue',
              expand: false,
              onPressed: () => showDialog<void>(
                context: context,
                builder: (_) => IssueVcDialog(
                  achievement: achievement,
                  muid: muid,
                  userName: userName,
                  userEmail: userEmail,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
