import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/features/profile/presentation/providers/badges_controller.dart';

/// Completed-task (TFP) badges — mirrors the reference dashboard's Badges
/// tab.
class BadgesTab extends ConsumerWidget {
  const BadgesTab({required this.muid, super.key});

  final String muid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final badgesState = ref.watch(badgesProvider(muid));

    return badgesState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) =>
          Center(child: Text(ApiException.messageFor(error))),
      data: (badges) {
        if (badges.completedTasks.isEmpty) {
          return Center(
            child: Text(
              'No badges earned yet.',
              style: MuType.body.copyWith(color: MuColors.inkSecondary),
            ),
          );
        }
        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(MuSpace.screenH, MuSpace.screenH, MuSpace.screenH, MuSpace.navClearance),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: MuSpace.m,
            crossAxisSpacing: MuSpace.m,
            childAspectRatio: 1.2,
          ),
          itemCount: badges.completedTasks.length,
          itemBuilder: (context, index) => _BadgeCard(
            title: badges.completedTasks[index],
          ),
        );
      },
    );
  }
}

class _BadgeCard extends StatelessWidget {
  const _BadgeCard({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: MuColors.heroGradient,
        borderRadius: BorderRadius.circular(MuRadius.inner),
      ),
      padding: const EdgeInsets.all(MuSpace.m),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(LucideIcons.medal, color: Colors.white, size: 32),
          const SizedBox(height: MuSpace.s),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: MuType.bodyMed.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
