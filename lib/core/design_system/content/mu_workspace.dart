/// Building blocks for the role workspaces (campus, enabler, mentor):
/// the page frame, section eyebrows with an action, stat tiles, bars and
/// labelled bar lists, surface cards, empty lines and rank discs.
library;

import 'package:flutter/material.dart';
import 'package:mulearn_app/core/design_system/input/mu_button.dart';
import 'package:mulearn_app/core/design_system/mulearn/mu_leaderboard.dart'
    show muGrouped;
import 'package:mulearn_app/core/design_system/navigation/mu_top_bar.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// The frame of a campus workspace screen: `chalk`, the detail top bar
/// (with an optional [title] and [action]), then [body].
class MuWorkspacePage extends StatelessWidget {
  const MuWorkspacePage({
    required this.body,
    this.title,
    this.action,
    this.bottom,
    super.key,
  });

  final String? title;
  final Widget? action;
  final Widget body;

  /// Pinned under the body (a primary action).
  final Widget? bottom;

  @override
  Widget build(BuildContext context) {
    final c = context.mu.colors;
    return Scaffold(
      backgroundColor: c.chalk,
      body: SafeArea(
        bottom: bottom == null,
        child: Column(
          children: [
            MuTopBar.detail(title: title, action: action),
            Expanded(child: body),
            if (bottom != null)
              DecoratedBox(
                decoration: BoxDecoration(
                  color: c.chalk,
                  border: Border(top: BorderSide(color: c.line)),
                ),
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      MuSpacing.space5,
                      MuSpacing.space3,
                      MuSpacing.space5,
                      MuSpacing.space3,
                    ),
                    child: bottom,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// The standard scrolling list padding for workspace screens.
const muListPadding = EdgeInsets.fromLTRB(
  MuSpacing.space5,
  MuSpacing.space2,
  MuSpacing.space5,
  MuSpacing.space8,
);

/// A section heading in eyebrow caps, with an optional small action on the
/// right ("All students").
class MuSectionEyebrow extends StatelessWidget {
  const MuSectionEyebrow(
    this.text, {
    this.action,
    this.onAction,
    this.top = MuSpacing.space8,
    super.key,
  });

  final String text;
  final String? action;
  final VoidCallback? onAction;
  final double top;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: top,
        bottom: action == null ? MuSpacing.space3 : MuSpacing.space1,
      ),
      child: Row(
        children: [
          Expanded(
            child: Semantics(
              header: true,
              child: Text(text.toUpperCase(), style: context.mu.text.eyebrow),
            ),
          ),
          if (action != null)
            Flexible(
              child: MuButton(
                label: action!,
                variant: MuButtonVariant.ghost,
                size: MuButtonSize.small,
                onPressed: onAction,
              ),
            ),
        ],
      ),
    );
  }
}

/// A headline number on `surface`: the label in eyebrow caps, the value as
/// a numeral, an optional change line under it ([up] green, otherwise red).
class MuStatTile extends StatelessWidget {
  const MuStatTile({
    required this.label,
    required this.value,
    this.change,
    this.up = true,
    super.key,
  });

  final String label;
  final String value;
  final String? change;
  final bool up;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    return Semantics(
      container: true,
      label: [label, value, ?change].join(', '),
      excludeSemantics: true,
      child: Container(
        padding: const EdgeInsets.all(MuSpacing.space4),
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: BorderRadius.circular(MuRadii.card),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label.toUpperCase(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: mu.text.eyebrow,
            ),
            const SizedBox(height: MuSpacing.space2),
            Text(value, style: mu.text.numeral.copyWith(fontSize: 28)),
            if (change != null) ...[
              const SizedBox(height: 2),
              Text(
                change!,
                style: mu.text.caption.copyWith(
                  color: up ? c.success : c.danger,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Lays [tiles] out two to a row.
class MuStatGrid extends StatelessWidget {
  const MuStatGrid({required this.tiles, super.key});

  final List<Widget> tiles;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        const gap = MuSpacing.space3;
        final width = (box.maxWidth - gap) / 2;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [for (final t in tiles) SizedBox(width: width, child: t)],
        );
      },
    );
  }
}

/// A thin progress bar: [value] 0–1 of `cobalt` on `surface-sunk`.
class MuBar extends StatelessWidget {
  const MuBar({required this.value, this.color, super.key});

  final double value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = context.mu.colors;
    return ClipRRect(
      borderRadius: BorderRadius.circular(MuRadii.round),
      child: SizedBox(
        height: 6,
        child: Stack(
          children: [
            Positioned.fill(child: ColoredBox(color: c.surfaceSunk)),
            FractionallySizedBox(
              widthFactor: value.clamp(0, 1).toDouble(),
              child: ColoredBox(color: color ?? c.cobalt),
            ),
          ],
        ),
      ),
    );
  }
}

/// A card on `surface` with the standard padding.
class MuSurfaceCard extends StatelessWidget {
  const MuSurfaceCard({
    required this.child,
    this.padding = const EdgeInsets.all(MuSpacing.space4),
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) => Container(
    padding: padding,
    decoration: BoxDecoration(
      color: context.mu.colors.surface,
      borderRadius: BorderRadius.circular(MuRadii.card),
    ),
    child: child,
  );
}

/// A muted line for an empty section.
class MuEmptyLine extends StatelessWidget {
  const MuEmptyLine(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: context.mu.text.body.copyWith(color: context.mu.colors.ink3),
  );
}

/// A rank badge for a feed row's leading slot ("#3").
class MuRankDisc extends StatelessWidget {
  const MuRankDisc(this.rank, {super.key});

  final int? rank;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final top = rank != null && rank! <= 3;
    return Container(
      width: MuSizes.avatarMd,
      height: MuSizes.avatarMd,
      decoration: BoxDecoration(
        color: top ? c.volt : c.surfaceSunk,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        rank == null ? '–' : '#$rank',
        style: mu.text.label.copyWith(
          fontWeight: FontWeight.w800,
          color: top ? c.onVolt : c.ink2,
        ),
      ),
    );
  }
}

/// One row of a [MuBarList].
typedef MuBarItem = ({String label, int value, IconData? icon, String? note});

/// Magnitudes as labelled horizontal bars in one hue, compared by length
/// (no colour coding, so it reads the same in any colour vision): each row
/// is the label (with an optional icon), the value, an optional [note]
/// ("38%"), and a bar scaled to the largest value.
class MuBarList extends StatelessWidget {
  const MuBarList({required this.items, super.key});

  final List<MuBarItem> items;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final peak = items.fold<int>(0, (m, i) => i.value > m ? i.value : m);
    return MuSurfaceCard(
      child: Column(
        children: [
          for (var i = 0; i < items.length; i++)
            Padding(
              padding: EdgeInsets.only(
                bottom: i == items.length - 1 ? 0 : MuSpacing.space4,
              ),
              child: Semantics(
                label: [
                  items[i].label,
                  '${items[i].value}',
                  ?items[i].note,
                ].join(', '),
                excludeSemantics: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (items[i].icon != null) ...[
                          Icon(
                            items[i].icon,
                            size: MuSizes.iconSm,
                            color: c.ink2,
                          ),
                          const SizedBox(width: MuSpacing.space2),
                        ],
                        Expanded(
                          child: Text(items[i].label, style: mu.text.body),
                        ),
                        Text(
                          muGrouped(items[i].value),
                          style: mu.text.bodyStrong,
                        ),
                        if (items[i].note != null) ...[
                          const SizedBox(width: MuSpacing.space2),
                          SizedBox(
                            width: 44,
                            child: Text(
                              items[i].note!,
                              style: mu.text.caption,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: MuSpacing.space2),
                    MuBar(value: peak <= 0 ? 0 : items[i].value / peak),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
