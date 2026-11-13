import 'package:flutter/material.dart';
import 'package:mulearn_app/core/design_system/foundation/mu_avatar.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// Someone on the leaderboard.
class MuRankEntry {
  /// An entry: name, karma, and where they're from.
  const MuRankEntry({required this.name, required this.karma, this.subtitle, this.photoUrl});

  /// Full name.
  final String name;

  /// Total karma in the board's period.
  final int karma;

  /// Campus or institution.
  final String? subtitle;

  /// Photo.
  final String? photoUrl;
}

/// "12,480".
String muGrouped(int n) {
  final s = n.abs().toString();
  final b = StringBuffer(n < 0 ? '-' : '');
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) b.write(',');
    b.write(s[i]);
  }
  return b.toString();
}

/// The top three on podium blocks (2 · 1 · 3) with giant rank numerals:
/// #1 volt, #2 cobalt, #3 night.
class MuPodium extends StatelessWidget {
  /// A podium of exactly three [top] entries in rank order.
  const MuPodium({required this.top, this.onOpen, super.key});

  /// Ranks 1, 2, 3.
  final List<MuRankEntry> top;

  /// Opens a person.
  final ValueChanged<MuRankEntry>? onOpen;

  @override
  Widget build(BuildContext context) {
    assert(top.length == 3, 'a podium has three places');
    final mu = context.mu;
    final c = mu.colors;
    Widget place(int rank, int flex, double height, Color fill, Color fg) {
      final e = top[rank - 1];
      return Expanded(
        flex: flex,
        child: Semantics(
          container: true,
          button: onOpen != null,
          label: 'Rank $rank, ${e.name}, ${muGrouped(e.karma)} karma',
          excludeSemantics: true,
          child: GestureDetector(
            onTap: onOpen == null ? null : () => onOpen!(e),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MuAvatar(name: e.name, url: e.photoUrl, size: MuSizes.avatarMd),
                const SizedBox(height: 6),
                Text(
                  e.name,
                  style: mu.text.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                Text(muGrouped(e.karma), style: mu.text.codeSm.copyWith(color: c.ink3)),
                const SizedBox(height: 6),
                Container(
                  height: height,
                  width: double.infinity,
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: fill,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20), bottom: Radius.circular(6)),
                  ),
                  child: Text('$rank', style: mu.text.poster.copyWith(fontSize: 54, height: 1, color: fg)),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        place(2, 100, 112, c.cobalt, c.onCobalt),
        const SizedBox(width: MuSpacing.space2),
        place(1, 115, 150, c.volt, c.onVolt),
        const SizedBox(width: MuSpacing.space2),
        place(3, 100, 88, c.night, c.onNight),
      ],
    );
  }
}

/// A leaderboard row with a karma bar scaled to the board's #1, so the gap
/// is visible, not just stated. The viewer's own row is tinted.
class MuRankRow extends StatelessWidget {
  /// A row at [rank]; [maxKarma] is #1's karma.
  const MuRankRow({
    required this.rank,
    required this.entry,
    required this.maxKarma,
    this.isMe = false,
    this.onTap,
    super.key,
  });

  /// Position.
  final int rank;

  /// Who.
  final MuRankEntry entry;

  /// The board's top karma (bar scale).
  final int maxKarma;

  /// The viewer's own row.
  final bool isMe;

  /// Opens the person.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final share = maxKarma <= 0 ? 0.0 : (entry.karma / maxKarma).clamp(0.0, 1.0);
    final name = isMe ? 'You · ${entry.name}' : entry.name;
    final row = Container(
      padding: EdgeInsets.symmetric(horizontal: isMe ? MuSpacing.space4 : 0, vertical: MuSpacing.space3),
      decoration: isMe ? BoxDecoration(color: c.cobaltTint, borderRadius: BorderRadius.circular(14)) : null,
      child: Row(
        children: [
          SizedBox(
            width: 34,
            child: Text('$rank', style: mu.text.title3.copyWith(fontSize: 18, color: isMe ? c.cobaltText : c.ink3)),
          ),
          MuAvatar(name: entry.name, url: entry.photoUrl, size: MuSizes.avatarMd, ring: false),
          const SizedBox(width: MuSpacing.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(name, style: mu.text.bodyStrong, maxLines: 1, overflow: TextOverflow.ellipsis),
                    ),
                    const SizedBox(width: MuSpacing.space2),
                    Text(muGrouped(entry.karma), style: mu.text.code.copyWith(fontWeight: FontWeight.w700)),
                  ],
                ),
                if (entry.subtitle != null)
                  Text(entry.subtitle!, style: mu.text.caption, maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: SizedBox(
                    height: 4,
                    child: Stack(
                      children: [
                        Positioned.fill(child: ColoredBox(color: c.surfaceSunk)),
                        FractionallySizedBox(
                          widthFactor: share,
                          child: ColoredBox(color: c.cobalt),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    return Semantics(
      container: true,
      button: onTap != null,
      label: 'Rank $rank, $name${entry.subtitle == null ? '' : ', ${entry.subtitle}'}, ${muGrouped(entry.karma)} karma',
      excludeSemantics: true,
      child: GestureDetector(behavior: HitTestBehavior.opaque, onTap: onTap, child: row),
    );
  }
}
