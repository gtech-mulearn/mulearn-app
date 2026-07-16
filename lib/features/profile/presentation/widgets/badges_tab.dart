import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_gradients.dart';
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
          return const Center(
            child: Text(
              'No badges earned yet.',
              style: TextStyle(color: MulearnColors.gray600),
            ),
          );
        }
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
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
        gradient: MulearnGradients.trusty,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.military_tech, color: Colors.white, size: 32),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
