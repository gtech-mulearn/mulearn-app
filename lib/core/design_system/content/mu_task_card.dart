import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/input/mu_pill.dart';
import 'package:mulearn_app/core/design_system/motion/mu_pressable.dart';
import 'package:mulearn_app/core/design_system/mulearn/mu_leaderboard.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// Where a task stands for the viewer. The tab colour carries it, always
/// with a word or icon too.
enum MuTaskState {
  /// Not done yet: night tab, karma reward.
  open,

  /// Submitted, waiting for a peer review.
  review,

  /// Accepted: karma earned.
  done,

  /// Sent back with a note.
  rejected,

  /// Above the viewer's level.
  locked,
}

/// A task as a card with its hashtag printed on a tab, because the hashtag
/// is how a μLearn task is submitted (on Discord) and recognised.
class MuTaskCard extends StatelessWidget {
  /// A task card.
  const MuTaskCard({
    required this.title,
    required this.karma,
    this.hashtag,
    this.eyebrow,
    this.description,
    this.state = MuTaskState.open,
    this.lockedLabel,
    this.pills = const [],
    this.footer,
    this.onTap,
    super.key,
  });

  /// Task name.
  final String title;

  /// Karma reward.
  final int karma;

  /// "#cl-react-todo"; null prints "task".
  final String? hashtag;

  /// "LEVEL 3 · WEB DEVELOPMENT" (set in capitals by the card).
  final String? eyebrow;

  /// Up to two lines.
  final String? description;

  /// Open, in review, done, rejected, locked.
  final MuTaskState state;

  /// The pill on a locked task ("Level 6").
  final String? lockedLabel;

  /// Extra facts (type, channel).
  final List<Widget> pills;

  /// Bottom row (peers who finished, an action).
  final Widget? footer;

  /// Opens the task.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    // Artifact `.mu-task`: the tab's background carries the state; its text
    // stays `on-night` except on the locked (sunk) tab.
    final (tabBg, tabFg) = switch (state) {
      MuTaskState.open => (c.night, c.onNight),
      MuTaskState.review => (c.warning, c.onNight),
      MuTaskState.done => (c.success, c.onNight),
      MuTaskState.rejected => (c.danger, c.onNight),
      MuTaskState.locked => (c.surfaceSunk, c.ink3),
    };
    final status = switch (state) {
      MuTaskState.open => _KarmaBadge(karma: karma),
      MuTaskState.review => const MuPill(
        'In review',
        tone: MuPillTone.warning,
        icon: LucideIcons.clock,
      ),
      MuTaskState.done => MuPill(
        '+${muGrouped(karma)} earned',
        tone: MuPillTone.success,
        icon: LucideIcons.check,
      ),
      MuTaskState.rejected => const MuPill(
        'Needs changes',
        tone: MuPillTone.danger,
        icon: LucideIcons.x,
      ),
      MuTaskState.locked => MuPill(
        lockedLabel ?? 'Locked',
        icon: LucideIcons.lock,
      ),
    };
    final tag = (hashtag == null || hashtag!.trim().isEmpty)
        ? 'task'
        : hashtag!.trim();
    final locked = state == MuTaskState.locked;
    const gap = SizedBox(height: 10);

    final body = Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        MuSpacing.space5,
        18,
        MuSpacing.space5,
        MuSpacing.space5,
      ),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(MuRadii.card),
          bottomLeft: Radius.circular(MuRadii.card),
          bottomRight: Radius.circular(MuRadii.card),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (eyebrow != null && eyebrow!.isNotEmpty) ...[
                      Text(
                        eyebrow!.toUpperCase(),
                        style: mu.text.eyebrow.copyWith(color: c.ink3),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: MuSpacing.space1),
                    ],
                    Text(
                      title,
                      style: mu.text.title3.copyWith(
                        fontSize: 19,
                        color: locked ? c.ink2 : c.ink,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: MuSpacing.space3),
              status,
            ],
          ),
          if (description != null && description!.trim().isNotEmpty) ...[
            gap,
            Text(
              description!.trim(),
              style: mu.text.body.copyWith(color: c.ink2),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          if (pills.isNotEmpty) ...[
            gap,
            Wrap(spacing: 6, runSpacing: 6, children: pills),
          ],
          if (footer != null) ...[gap, footer!],
        ],
      ),
    );

    // The tab is stamped onto the card: 28 tall, its lower half over the
    // body's flattened top-left corner, 20 in from the left edge.
    final card = Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(padding: const EdgeInsets.only(top: 14), child: body),
        PositionedDirectional(
          start: MuSpacing.space5,
          top: 0,
          child: Container(
            height: 28,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            alignment: AlignmentDirectional.centerStart,
            decoration: BoxDecoration(
              color: tabBg,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(MuRadii.tag),
              ),
            ),
            child: Text(
              tag,
              style: mu.text.code.copyWith(
                color: tabFg,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 1,
              ),
              maxLines: 1,
            ),
          ),
        ),
      ],
    );

    final stateWord = switch (state) {
      MuTaskState.open => '${muGrouped(karma)} karma',
      MuTaskState.review => 'in review',
      MuTaskState.done => 'done, ${muGrouped(karma)} karma earned',
      MuTaskState.rejected => 'needs changes',
      MuTaskState.locked =>
        'locked${lockedLabel == null ? '' : ', $lockedLabel'}',
    };
    return Semantics(
      container: true,
      button: onTap != null,
      label: '$title, $tag, $stateWord',
      excludeSemantics: footer == null,
      child: onTap == null
          ? card
          : MuPressable(onTap: onTap, pressedScale: 0.98, child: card),
    );
  }
}

/// The open task's reward: mono 13 bold on volt, a little larger than a
/// status pill (artifact `.mu-task .karma`).
class _KarmaBadge extends StatelessWidget {
  const _KarmaBadge({required this.karma});

  final int karma;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
      decoration: BoxDecoration(
        color: mu.colors.volt,
        borderRadius: BorderRadius.circular(MuRadii.round),
      ),
      child: Text(
        '+${muGrouped(karma)}',
        style: mu.text.code.copyWith(
          color: mu.colors.onVolt,
          fontSize: 13,
          fontWeight: FontWeight.w700,
          height: 1,
        ),
      ),
    );
  }
}
