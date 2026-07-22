import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_avatar_stack.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_chip.dart';

/// Task-card pattern (rules.md §8) — reused for μLearn's Learning Circle
/// meetings, since the app has no generic "task" concept.
class MuTaskTile extends StatelessWidget {
  const MuTaskTile({
    required this.title,
    required this.subtitle,
    required this.onTap,
    super.key,
    this.tags = const [],
    this.avatarNames = const [],
    this.avatarUrls = const [],
    this.extraAvatarCount = 0,
    this.trailingLabel,
    this.onTrailingTap,
  });

  final String title;
  final String subtitle;
  final List<MuTagChip> tags;
  final List<String> avatarNames;
  final List<String?> avatarUrls;
  final int extraAvatarCount;
  final String? trailingLabel;
  final VoidCallback? onTrailingTap;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MuCard(
      onTap: onTap,
      padding: const EdgeInsets.all(MuSpace.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (tags.isNotEmpty) ...[
            Wrap(spacing: MuSpace.s, runSpacing: MuSpace.xs, children: tags),
            const SizedBox(height: MuSpace.s),
          ],
          Text(title, style: MuType.title, maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: MuType.caption,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: MuSpace.m),
          Row(
            children: [
              if (avatarNames.isNotEmpty)
                MuAvatarStack(
                  names: avatarNames,
                  urls: avatarUrls,
                  extraCount: extraAvatarCount,
                ),
              const Spacer(),
              if (trailingLabel != null)
                _TrailingButton(label: trailingLabel!, onTap: onTrailingTap ?? onTap),
            ],
          ),
        ],
      ),
    );
  }
}

class _TrailingButton extends StatelessWidget {
  const _TrailingButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF0B0F1A),
      borderRadius: BorderRadius.circular(100),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(100),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            label,
            style: MuType.chip.copyWith(color: Colors.white, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
