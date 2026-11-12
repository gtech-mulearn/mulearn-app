import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';

class MuChecklistItem {
  const MuChecklistItem({required this.label, required this.checked});

  final String label;
  final bool checked;
}

/// Rounded-square checkbox rows (rules.md §8) — checked text becomes
/// tertiary + strikethrough.
class MuChecklist extends StatelessWidget {
  const MuChecklist({
    required this.items,
    required this.onToggle,
    super.key,
  });

  final List<MuChecklistItem> items;
  final ValueChanged<int> onToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < items.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: MuSpace.xs),
            child: GestureDetector(
              onTap: () => onToggle(i),
              behavior: HitTestBehavior.opaque,
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    height: 22,
                    width: 22,
                    decoration: BoxDecoration(
                      color: items[i].checked ? MuColors.primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(7),
                      border: items[i].checked
                          ? null
                          : Border.all(color: MuColors.divider, width: 1.5),
                    ),
                    child: items[i].checked
                        ? const Icon(Icons.check, size: 15, color: MuColors.surface)
                        : null,
                  ),
                  const SizedBox(width: MuSpace.m),
                  Expanded(
                    child: Text(
                      items[i].label,
                      style: MuType.body.copyWith(
                        color: items[i].checked ? MuColors.inkTertiary : MuColors.ink,
                        decoration: items[i].checked ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
