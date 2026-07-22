import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_achievement.dart';
import 'package:mulearn_app/features/profile/presentation/providers/achievements_controller.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/issue_vc_dialog.dart';

/// Earned achievements + Verifiable Credential issuance — mirrors the
/// reference dashboard's Achievements tab. VC issuance (as opposed to
/// viewing an already-issued one) is only offered on the signed-in user's
/// own profile — pass [isOwnProfile]: false when viewing someone else's.
class AchievementsTab extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final achievementsState = ref.watch(userAchievementsProvider(muid));

    return achievementsState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) =>
          Center(child: Text(ApiException.messageFor(error))),
      data: (achievements) {
        if (achievements.isEmpty) {
          return Center(
            child: Text(
              'No achievements yet.',
              style: MuType.body.copyWith(color: MuColors.inkSecondary),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(MuSpace.screenH, MuSpace.screenH, MuSpace.screenH, MuSpace.navClearance),
          itemCount: achievements.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: MuSpace.m),
            child: _AchievementCard(
              achievement: achievements[index],
              muid: muid,
              userName: userName,
              userEmail: userEmail,
              isOwnProfile: isOwnProfile,
            ),
          ),
        );
      },
    );
  }
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
    final canShowAction = achievement.isIssued || isOwnProfile;
    return MuCard(
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: MuColors.primaryTint,
              borderRadius: BorderRadius.circular(MuRadius.inner),
            ),
            alignment: Alignment.center,
            child: const Icon(LucideIcons.award, color: MuColors.primary),
          ),
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
          if (canShowAction) ...[
            const SizedBox(width: MuSpace.s),
            MuGhostButton(
              label: achievement.isIssued ? 'View' : 'Issue',
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
