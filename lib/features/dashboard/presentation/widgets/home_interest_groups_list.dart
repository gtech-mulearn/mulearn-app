import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/features/interest_groups/domain/entities/interest_group_summary.dart';
import 'package:mulearn_app/features/interest_groups/presentation/widgets/interest_group_card.dart';

/// Non-scrolling 2-column grid preview of the interest-group directory for
/// the home dashboard.
class HomeInterestGroupsList extends StatelessWidget {
  const HomeInterestGroupsList({
    required this.groups,
    required this.joinedIds,
    required this.onTap,
    super.key,
  });

  final List<InterestGroupSummary> groups;
  final Set<String> joinedIds;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    if (groups.isEmpty) return const SizedBox.shrink();
    final preview = groups.take(6).toList();
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: MuSpace.m,
        crossAxisSpacing: MuSpace.m,
        childAspectRatio: 0.8,
      ),
      itemCount: preview.length,
      itemBuilder: (context, index) {
        final group = preview[index];
        return InterestGroupCard(
          group: group,
          isJoined: joinedIds.contains(group.id),
          onTap: () => onTap(group.id),
        );
      },
    );
  }
}
