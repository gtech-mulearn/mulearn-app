import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';

/// Which illustrated state to show. Mirrors the dashboard's StateDisplay
/// variants (`src/components/ui/state-display.tsx`):
/// - [noTasks] only for genuinely empty task/learning-activity lists;
/// - [noResults] for search/filter misses and empty content lists;
/// - [notFound] for page-level "doesn't exist".
enum MuStateVariant { notFound, noResults, noTasks }

/// Illustration width presets: the dashboard's `max-w-45/65/90`.
enum MuStateSize { sm, md, lg }

typedef _StateConfig = ({String asset, double width, double height, String title, String description});

/// The dashboard's `STATE_ILLUSTRATIONS` registry: the same SVGs (copied
/// unchanged into `assets/illustrations/`) and the same default copy.
const Map<MuStateVariant, _StateConfig> _states = {
  MuStateVariant.notFound: (
    asset: 'assets/illustrations/not-found.svg',
    width: 1607,
    height: 979,
    title: 'Looks like you wandered off the path.',
    description: "That's how new paths are discovered. But this one doesn't exist yet.",
  ),
  MuStateVariant.noResults: (
    asset: 'assets/illustrations/no-results.svg',
    width: 1536,
    height: 1024,
    title: 'Nothing here. Yet.',
    description: "Curiosity doesn't always find answers on the first try. Try a different path and keep exploring.",
  ),
  MuStateVariant.noTasks: (
    asset: 'assets/illustrations/no-tasks.svg',
    width: 1536,
    height: 1024,
    title: 'No tasks available',
    description: 'There are currently no tasks listed in this view. New tasks will appear here once created.',
  ),
};

const Map<MuStateSize, double> _maxWidth = {
  MuStateSize.sm: 180,
  MuStateSize.md: 260,
  MuStateSize.lg: 360,
};

/// An illustrated empty / no-results / no-tasks / not-found state, as on the
/// dashboard: illustration, title, description and an optional action.
/// Screens may override the copy per context (using the dashboard's own
/// wording for that screen). Not for compact UI (sheets, small cards, tabs
/// inside a profile), where the dashboard keeps plain text too.
class MuStateDisplay extends StatelessWidget {
  const MuStateDisplay({
    required this.variant,
    this.title,
    this.description,
    this.action,
    this.size = MuStateSize.md,
    super.key,
  });

  final MuStateVariant variant;

  /// Overrides the variant's default heading.
  final String? title;

  /// Overrides the variant's default description.
  final String? description;

  /// A contextual action, e.g. "Clear filters" or "Back to Home".
  final Widget? action;
  final MuStateSize size;

  @override
  Widget build(BuildContext context) {
    final config = _states[variant]!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MuSpace.l, vertical: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Decorative: the title and description carry the state.
          ExcludeSemantics(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: _maxWidth[size]!),
              child: AspectRatio(
                aspectRatio: config.width / config.height,
                child: SvgPicture.asset(config.asset),
              ),
            ),
          ),
          const SizedBox(height: MuSpace.l),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 448),
            child: Column(
              children: [
                Text(title ?? config.title, style: MuType.title, textAlign: TextAlign.center),
                const SizedBox(height: MuSpace.xs),
                Text(
                  description ?? config.description,
                  style: MuType.body.copyWith(fontSize: 14, color: MuColors.inkSecondary),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          if (action != null) ...[
            const SizedBox(height: MuSpace.l),
            action!,
          ],
        ],
      ),
    );
  }
}
