import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';

/// The row at the end of a paged list: a spinner while the next page loads,
/// or a retry after it failed (the items already shown stay in place).
class MuLoadMoreFooter extends StatelessWidget {
  const MuLoadMoreFooter({
    required this.isLoading,
    required this.error,
    required this.onRetry,
    super.key,
  });

  final bool isLoading;
  final Object? error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    if (error != null && !isLoading) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: MuSpace.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Couldn't load more.",
              style: MuType.caption.copyWith(color: MuColors.inkSecondary),
            ),
            const SizedBox(height: MuSpace.s),
            MuGhostButton(
              label: 'Try again',
              icon: LucideIcons.refreshCw,
              expand: false,
              onPressed: onRetry,
            ),
          ],
        ),
      );
    }
    return const Padding(
      padding: EdgeInsets.all(MuSpace.l),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
