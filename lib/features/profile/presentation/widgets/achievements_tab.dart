import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/config/feature_flags.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
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
    this.scrollable = true,
  });

  final String muid;
  final String userName;
  final String? userEmail;
  final bool isOwnProfile;

  /// False when it sits inside another scroll (the profile page): the lists
  /// lay out in full and don't scroll on their own.
  final bool scrollable;

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
      _Section.eligible => _EligibleList(muid: widget.muid, shrink: !widget.scrollable),
      _Section.inProgress => _InProgressList(muid: widget.muid, shrink: !widget.scrollable),
    };
    if (!widget.isOwnProfile) return _EarnedList(widget: widget);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(MuSpacing.space5, MuSpacing.space4, MuSpacing.space5, 0),
          child: MuSegmented<_Section>(
            values: _Section.values,
            selected: _section,
            label: (s) => switch (s) {
              _Section.earned => 'Earned',
              _Section.eligible => 'Eligible',
              _Section.inProgress => 'In Progress',
            },
            onChanged: (s) => setState(() => _section = s),
          ),
        ),
        if (widget.scrollable) Expanded(child: list) else list,
      ],
    );
  }
}

const _listPadding = EdgeInsets.fromLTRB(MuSpacing.space5, MuSpacing.space4, MuSpacing.space5, MuSpacing.navClearance);

class _Empty extends StatelessWidget {
  const _Empty(this.message);

  final String message;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(MuSpacing.space5),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: context.mu.text.body.copyWith(color: context.mu.colors.ink2),
      ),
    ),
  );
}

class _EarnedList extends ConsumerWidget {
  const _EarnedList({required this.widget});

  final AchievementsTab widget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(userAchievementsProvider(widget.muid))
        .when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) =>
              ErrorRetryView(error: error, onRetry: () => ref.invalidate(userAchievementsProvider(widget.muid))),
          data: (achievements) {
            if (achievements.isEmpty) return const _Empty('No achievements yet.');
            return ListView.builder(
              shrinkWrap: !widget.scrollable,
              physics: widget.scrollable ? null : const NeverScrollableScrollPhysics(),
              padding: _listPadding,
              itemCount: achievements.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: MuSpacing.space3),
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
  const _EligibleList({required this.muid, required this.shrink});

  final bool shrink;

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
    return ref
        .watch(eligibleAchievementsProvider)
        .when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) =>
              ErrorRetryView(error: error, onRetry: () => ref.invalidate(eligibleAchievementsProvider)),
          data: (items) {
            if (items.isEmpty) return const _Empty('Nothing to claim yet. Keep earning karma.');
            return ListView(
              shrinkWrap: shrink,
              physics: shrink ? const NeverScrollableScrollPhysics() : null,
              padding: _listPadding,
              children: [
                for (final item in items)
                  Padding(
                    padding: const EdgeInsets.only(bottom: MuSpacing.space3),
                    child: _ProgressCard(
                      item: item,
                      description: descriptions[item.achievementId],
                      action: MuButton(
                        label: 'Claim',
                        size: MuButtonSize.small,
                        onPressed: () => _claim(context, ref, item),
                      ),
                    ),
                  ),
              ],
            );
          },
        );
  }
}

class _InProgressList extends ConsumerWidget {
  const _InProgressList({required this.muid, required this.shrink});

  final bool shrink;

  final String muid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final descriptions = ref.watch(achievementDescriptionsProvider).value ?? const {};
    final earned = ref.watch(userAchievementsProvider(muid)).value ?? const [];
    final eligible = ref.watch(eligibleAchievementsProvider).value ?? const [];
    return ref
        .watch(achievementProgressProvider)
        .when(
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
              shrinkWrap: shrink,
              physics: shrink ? const NeverScrollableScrollPhysics() : null,
              padding: _listPadding,
              children: [
                for (final item in items)
                  Padding(
                    padding: const EdgeInsets.only(bottom: MuSpacing.space3),
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
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const _AchievementIcon(),
              const SizedBox(width: MuSpacing.space3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name, style: context.mu.text.bodyStrong),
                    if (description != null)
                      Text(description!, style: context.mu.text.caption, maxLines: 2, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              if (action != null) ...[const SizedBox(width: MuSpacing.space2), action!],
            ],
          ),
          if (showProgress) ...[
            const SizedBox(height: MuSpacing.space3),
            _Track(value: (item.percentage ?? 0) / 100),
            const SizedBox(height: MuSpacing.space1),
            Text(
              current != null && required != null ? '${_number(current)} / ${_number(required)}' : (item.reason ?? ''),
              style: context.mu.text.caption.copyWith(color: context.mu.colors.ink2),
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
    decoration: BoxDecoration(color: context.mu.colors.volt, shape: BoxShape.circle),
    alignment: Alignment.center,
    child: Icon(LucideIcons.award, color: context.mu.colors.onVolt, size: MuSizes.iconMd),
  );
}

/// A surface card for one achievement.
class _Card extends StatelessWidget {
  const _Card({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(MuSpacing.space4),
    decoration: BoxDecoration(color: context.mu.colors.surface, borderRadius: BorderRadius.circular(MuRadii.card)),
    child: child,
  );
}

/// Progress toward an achievement.
class _Track extends StatelessWidget {
  const _Track({required this.value});

  final double value;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(MuRadii.round),
    child: SizedBox(
      height: 8,
      child: Stack(
        children: [
          Positioned.fill(child: ColoredBox(color: context.mu.colors.surfaceSunk)),
          FractionallySizedBox(
            // Grow from the start edge (the default centres the bar).
            alignment: AlignmentDirectional.centerStart,
            widthFactor: value.clamp(0.0, 1.0),
            child: ColoredBox(color: context.mu.colors.cobalt),
          ),
        ],
      ),
    ),
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
    return _Card(
      child: Row(
        children: [
          const _AchievementIcon(),
          const SizedBox(width: MuSpacing.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(achievement.achievement.achievementName, style: context.mu.text.bodyStrong),
                if (achievement.achievement.description != null)
                  Text(
                    achievement.achievement.description!,
                    style: context.mu.text.caption,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          if (canView || canIssue) ...[
            const SizedBox(width: MuSpacing.space2),
            MuButton(
              label: canView ? 'View' : 'Issue',
              variant: MuButtonVariant.ghost,
              size: MuButtonSize.small,
              onPressed: () => showDialog<void>(
                context: context,
                builder: (_) =>
                    IssueVcDialog(achievement: achievement, muid: muid, userName: userName, userEmail: userEmail),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
