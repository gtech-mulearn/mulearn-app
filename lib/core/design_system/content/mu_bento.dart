import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/motion/mu_pressable.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/theme/mu_tones.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// How much of the bento a tile takes.
enum MuTileSize {
  /// Two rows tall, one column (the next circle meeting, the next event).
  tall,

  /// One row, one column (a task deadline, a pending review).
  square,

  /// Content height, one column (account nudges).
  short,

  /// Full width, content height (an empty-state or role-call tile).
  wide,
}

/// A fill for tiles not tied to an Interest Group.
enum MuTileFill {
  /// Karma-earning actions (find a task).
  volt,

  /// Commitments and meetings.
  cobalt,

  /// Everything else that needs weight.
  night,
}

/// One bento tile, coloured by the Interest Group category it belongs to so
/// the board reads by colour before words.
class MuTile extends StatelessWidget {
  /// A tile. [category] picks the fill; [onTap] adds the corner arrow.
  const MuTile({
    required this.title,
    this.category = IgCategory.others,
    this.size = MuTileSize.square,
    this.pill,
    this.meta,
    this.footer,
    this.onTap,
    this.fill,
    super.key,
  });

  /// Overrides [category] for tiles not tied to an Interest Group.
  final MuTileFill? fill;

  /// Two lines at most.
  final String title;

  /// Fill colour by IG category.
  final IgCategory category;

  /// Footprint.
  final MuTileSize size;

  /// A small pill at the top (kind and day, a hashtag).
  final Widget? pill;

  /// One or two lines of facts.
  final String? meta;

  /// Pinned to the bottom (mentor row, avatars).
  final Widget? footer;

  /// Opens the item. Anything that looks like an item opens it.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final (bg, ink) = switch (fill) {
      MuTileFill.volt => (c.volt, c.onVolt),
      MuTileFill.cobalt => (c.cobalt, c.onCobalt),
      MuTileFill.night => (c.night, c.onNight),
      null => (MuTones.forIgCategory(c, category), c.inkPrint),
    };
    final minHeight = switch (size) {
      MuTileSize.tall => 252.0,
      MuTileSize.square => 120.0,
      MuTileSize.short || MuTileSize.wide => 0.0,
    };
    final tile = Container(
      constraints: BoxConstraints(minHeight: minHeight),
      padding: const EdgeInsets.all(MuSpacing.space4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(MuRadii.card)),
      child: Stack(
        // The corner arrow sits slightly into the padding; don't clip it.
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (pill != null) ...[
                Padding(
                  padding: EdgeInsetsDirectional.only(end: onTap != null ? 36 : 0),
                  child: pill,
                ),
                const SizedBox(height: 6),
              ],
              Padding(
                // Keep the title clear of the corner arrow when there's no pill above it.
                padding: EdgeInsetsDirectional.only(end: onTap != null && pill == null ? 36 : 0),
                child: Text(
                  title,
                  style: mu.text.title2.copyWith(fontSize: 20, height: 1.1, color: ink),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (meta != null) ...[
                const SizedBox(height: 6),
                Text(
                  meta!,
                  style: mu.text.label.copyWith(color: ink.withValues(alpha: 0.82), fontWeight: FontWeight.w500),
                ),
              ],
              if (footer != null) ...[
                SizedBox(height: size == MuTileSize.tall ? MuSpacing.space6 : MuSpacing.space3),
                footer!,
              ],
            ],
          ),
          if (onTap != null)
            PositionedDirectional(
              top: -4,
              end: -4,
              child: ExcludeSemantics(
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: fill == MuTileFill.night ? c.volt : c.night.withValues(alpha: 0.9),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    LucideIcons.arrowUpRight,
                    size: MuSizes.iconSm,
                    color: fill == MuTileFill.night ? c.onVolt : c.onNight,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
    if (onTap == null) return tile;
    return Semantics(
      button: true,
      child: MuPressable(onTap: onTap, pressedScale: 0.98, child: tile),
    );
  }
}

/// [MuTile]s in rows of two with 12dp gaps, so the board fills its width
/// whatever the count:
///
/// * two square or short tiles share a row, at the same height;
/// * a tall tile takes the left half with up to two tiles stacked beside it,
///   stretched to its height;
/// * a tile left alone on its row (an odd one out, a tall tile with nothing
///   to sit beside it, a wide tile) spans the whole row.
class MuBento extends StatelessWidget {
  /// A board of tiles, in reading order.
  const MuBento({required this.tiles, super.key});

  /// Tiles in reading order.
  final List<MuTile> tiles;

  static bool _pairs(MuTile t) => t.size == MuTileSize.square || t.size == MuTileSize.short;

  @override
  Widget build(BuildContext context) {
    final bands = <Widget>[];
    var i = 0;
    while (i < tiles.length) {
      final t = tiles[i];
      if (t.size == MuTileSize.tall) {
        final beside = <MuTile>[];
        var j = i + 1;
        while (j < tiles.length && beside.length < 2 && _pairs(tiles[j])) {
          beside.add(tiles[j++]);
        }
        bands.add(
          beside.isEmpty
              ? t
              : _row(
                  t,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (var k = 0; k < beside.length; k++) ...[
                        if (k > 0) const SizedBox(height: MuSpacing.space3),
                        Expanded(child: beside[k]),
                      ],
                    ],
                  ),
                ),
        );
        i = j;
      } else if (_pairs(t) && i + 1 < tiles.length && _pairs(tiles[i + 1])) {
        bands.add(_row(t, tiles[i + 1]));
        i += 2;
      } else {
        bands.add(t);
        i++;
      }
    }
    return Column(children: _gapped(bands));
  }

  /// Two halves of one row, as tall as the taller.
  static Widget _row(Widget a, Widget b) => IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: a),
        const SizedBox(width: MuSpacing.space3),
        Expanded(child: b),
      ],
    ),
  );

  static List<Widget> _gapped(List<Widget> children) => [
    for (var i = 0; i < children.length; i++) ...[
      if (i > 0) const SizedBox(height: MuSpacing.space3),
      SizedBox(width: double.infinity, child: children[i]),
    ],
  ];
}
