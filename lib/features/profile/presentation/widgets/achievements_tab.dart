import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
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
          return const Center(
            child: Text(
              'No achievements yet.',
              style: TextStyle(color: MulearnColors.gray600),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: achievements.length,
          itemBuilder: (context, index) => _AchievementCard(
            achievement: achievements[index],
            muid: muid,
            userName: userName,
            userEmail: userEmail,
            isOwnProfile: isOwnProfile,
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
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.emoji_events, color: MulearnColors.primary),
        title: Text(achievement.achievement.achievementName),
        subtitle: achievement.achievement.description != null
            ? Text(achievement.achievement.description!)
            : null,
        trailing: !canShowAction
            ? null
            : FilledButton.tonal(
                onPressed: () => showDialog<void>(
                  context: context,
                  builder: (_) => IssueVcDialog(
                    achievement: achievement,
                    muid: muid,
                    userName: userName,
                    userEmail: userEmail,
                  ),
                ),
                child: Text(achievement.isIssued ? 'View' : 'Issue'),
              ),
      ),
    );
  }
}
