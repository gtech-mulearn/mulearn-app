import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/learning_circle.dart';

class LearningCircleTile extends StatelessWidget {
  const LearningCircleTile({required this.circle, required this.onTap, super.key});

  final LearningCircle circle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(child: Text(circle.title.isNotEmpty ? circle.title[0].toUpperCase() : '?')),
      title: Text(circle.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        [circle.ig, if (circle.org != null) circle.org].join(' · '),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('${circle.totalMembers}',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const Text('members',
              style: TextStyle(fontSize: 10, color: MulearnColors.gray600)),
        ],
      ),
    );
  }
}
