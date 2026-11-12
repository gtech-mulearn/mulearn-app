import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';

/// Directive empty state (rules.md §8) — tinted icon circle, title, body,
/// one ghost-button action.
class MuEmptyState extends StatelessWidget {
  const MuEmptyState({
    required this.icon,
    required this.title,
    required this.message,
    super.key,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(MuSpace.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 72,
              width: 72,
              decoration: const BoxDecoration(
                color: MuColors.primaryTint,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: MuColors.primary, size: 32),
            ),
            const SizedBox(height: MuSpace.l),
            Text(title, style: MuType.title, textAlign: TextAlign.center),
            const SizedBox(height: MuSpace.s),
            Text(
              message,
              style: MuType.body.copyWith(color: MuColors.inkSecondary),
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: MuSpace.xl),
              MuGhostButton(label: actionLabel!, onPressed: onAction, expand: false),
            ],
          ],
        ),
      ),
    );
  }
}
