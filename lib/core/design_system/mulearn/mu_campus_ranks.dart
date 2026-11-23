import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/mulearn/mu_campus_crest.dart';
import 'package:mulearn_app/core/design_system/mulearn/mu_leaderboard.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// A campus on the leaderboard.
class MuCampusRank {
  /// A campus: its whole name, karma, and the count after it.
  const MuCampusRank({
    required this.name,
    required this.karma,
    required this.detail,
    this.code,
    this.isMine = false,
  });

  /// The whole name, never cut.
  final String name;

  /// Short code for the seal ("MBT").
  final String? code;

  /// Karma in the board's period.
  final int karma;

  /// What follows the karma: "2,671 learners", "18 active learners".
  final String detail;

  /// The viewer's own campus.
  final bool isMine;
}

String _label(int rank, MuCampusRank e) =>
    'Rank $rank, ${e.name}, ${muGrouped(e.karma)} karma, ${e.detail}'
    '${e.isMine ? ', your campus' : ''}';

/// The "Your campus" stamp.
class _MineTag extends StatelessWidget {
  const _MineTag({required this.fill, required this.ink});

  final Color fill;
  final Color ink;

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 2),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: fill,
      borderRadius: BorderRadius.circular(MuRadii.round),
    ),
    child: Text(
      'Your campus',
      style: context.mu.text.caption.copyWith(
        color: ink,
        fontSize: 11,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

/// The top campuses as podium cards (artifact Leaderboard, campus mode):
/// the podium blocks laid sideways so a whole campus name fits. #1 `volt`,
/// #2 `cobalt`, #3 `night`; the giant rank numeral, the seal, the name,
/// then karma and [MuCampusRank.detail].
class MuCampusPodium extends StatelessWidget {
  /// Cards for the first one to three campuses, in rank order.
  const MuCampusPodium({required this.top, this.onOpen, super.key});

  final List<MuCampusRank> top;

  /// Opens the campus at an index into [top].
  final ValueChanged<int>? onOpen;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final fills = [
      (c.volt, c.onVolt),
      (c.cobalt, c.onCobalt),
      (c.night, c.onNight),
    ];
    return Column(
      children: [
        for (var i = 0; i < top.length && i < 3; i++) ...[
          if (i > 0) const SizedBox(height: MuSpacing.space2),
          _card(context, i, fills[i].$1, fills[i].$2),
        ],
      ],
    );
  }

  Widget _card(BuildContext context, int i, Color fill, Color ink) {
    final mu = context.mu;
    final c = mu.colors;
    final e = top[i];
    final onDark = i > 0;
    final card = Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 16, 16, 16),
      decoration: BoxDecoration(
        color: fill,
        borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(6),
          right: Radius.circular(20),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 34,
            child: Text(
              '${i + 1}',
              textAlign: TextAlign.center,
              style: mu.text.poster.copyWith(
                fontSize: 54,
                height: 0.86,
                color: ink,
              ),
            ),
          ),
          const SizedBox(width: MuSpacing.space3),
          MuCampusSeal(code: e.code, size: 44, inverse: onDark),
          const SizedBox(width: MuSpacing.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (e.isMine)
                  _MineTag(
                    fill: onDark ? c.surface : c.night,
                    ink: onDark ? c.ink : c.onNight,
                  ),
                Text(
                  e.name,
                  style: mu.text.title3.copyWith(fontSize: 16, color: ink),
                ),
                const SizedBox(height: MuSpacing.space1),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: muGrouped(e.karma),
                        style: mu.text.code.copyWith(
                          fontWeight: FontWeight.w700,
                          color: ink,
                        ),
                      ),
                      TextSpan(text: ' karma · ${e.detail}'),
                    ],
                  ),
                  style: mu.text.caption.copyWith(
                    color: ink.withValues(alpha: 0.78),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    final open = onOpen;
    return Semantics(
      container: true,
      button: open != null,
      label: _label(i + 1, e),
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: open == null ? null : () => open(i),
        child: card,
      ),
    );
  }
}

/// A campus row under the podium: rank, seal, the whole name, karma and
/// [MuCampusRank.detail], a karma bar scaled to #1, and a chevron when it
/// opens. Your campus is tinted and tagged.
class MuCampusRankRow extends StatelessWidget {
  /// A row at [rank]; [maxKarma] is #1's karma.
  const MuCampusRankRow({
    required this.rank,
    required this.entry,
    required this.maxKarma,
    this.onTap,
    super.key,
  });

  final int rank;
  final MuCampusRank entry;
  final int maxKarma;

  /// Opens the campus; null shows no chevron.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final mine = entry.isMine;
    final share = maxKarma <= 0
        ? 0.0
        : (entry.karma / maxKarma).clamp(0.0, 1.0);
    final row = Container(
      constraints: const BoxConstraints(minHeight: MuSizes.touchMin),
      padding: EdgeInsets.symmetric(
        horizontal: mine ? MuSpacing.space3 : 0,
        vertical: 14,
      ),
      decoration: mine
          ? BoxDecoration(
              color: c.cobaltTint,
              borderRadius: BorderRadius.circular(14),
            )
          : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 26,
            height: 40,
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                '$rank',
                style: mu.text.title3.copyWith(
                  fontSize: 18,
                  color: mine ? c.cobaltText : c.ink3,
                ),
              ),
            ),
          ),
          const SizedBox(width: MuSpacing.space3),
          MuCampusSeal(code: entry.code, size: 40),
          const SizedBox(width: MuSpacing.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (mine) _MineTag(fill: c.cobalt, ink: c.onCobalt),
                Text(entry.name, style: mu.text.bodyStrong),
                const SizedBox(height: 2),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: muGrouped(entry.karma),
                        style: mu.text.code.copyWith(
                          fontWeight: FontWeight.w700,
                          color: c.ink,
                        ),
                      ),
                      TextSpan(text: ' karma · ${entry.detail}'),
                    ],
                  ),
                  style: mu.text.caption,
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: SizedBox(
                    height: 4,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ColoredBox(color: c.surfaceSunk),
                        ),
                        FractionallySizedBox(
                          alignment: AlignmentDirectional.centerStart,
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
          if (onTap != null) ...[
            const SizedBox(width: MuSpacing.space3),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Icon(
                LucideIcons.chevronRight,
                size: MuSizes.iconSm,
                color: c.ink3,
              ),
            ),
          ],
        ],
      ),
    );
    return Semantics(
      container: true,
      button: onTap != null,
      label: _label(rank, entry),
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: row,
      ),
    );
  }
}
