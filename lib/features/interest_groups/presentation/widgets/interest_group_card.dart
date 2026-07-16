import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/features/interest_groups/domain/entities/interest_group_summary.dart';

/// A single card in the interest-group directory grid/list — name,
/// category, member count, and a joined/not-joined indicator.
class InterestGroupCard extends StatelessWidget {
  const InterestGroupCard({
    required this.group,
    required this.isJoined,
    required this.onTap,
    super.key,
  });

  final InterestGroupSummary group;
  final bool isJoined;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      group.name,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (isJoined)
                    const Icon(Icons.check_circle,
                        color: MulearnColors.rankGold, size: 18),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                group.category,
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: MulearnColors.gray600),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.people_outline, size: 16),
                  const SizedBox(width: 4),
                  Text('${group.memberCount} members',
                      style: theme.textTheme.bodySmall),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
