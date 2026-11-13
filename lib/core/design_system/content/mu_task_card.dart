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
    final (tabBg, tabFg) = switch (state) {
      MuTaskState.open => (c.night, c.onNight),
      MuTaskState.review => (c.warning, c.surface),
      MuTaskState.done => (c.success, c.surface),
      MuTaskState.rejected => (c.danger, c.surface),
      MuTaskState.locked => (c.surfaceSunk, c.ink3),
    };
    final status = switch (state) {
      MuTaskState.open => MuPill('+${muGrouped(karma)}', tone: MuPillTone.volt, mono: true),
      MuTaskState.review => const MuPill('In review', tone: MuPillTone.warning, icon: LucideIcons.clock),
      MuTaskState.done => MuPill('+${muGrouped(karma)} earned', tone: MuPillTone.success, icon: LucideIcons.check),
      MuTaskState.rejected => const MuPill('Needs changes', tone: MuPillTone.danger, icon: LucideIcons.x),
      MuTaskState.locked => MuPill(lockedLabel ?? 'Locked', icon: LucideIcons.lock),
    };
    final tag = (hashtag == null || hashtag!.trim().isEmpty) ? 'task' : hashtag!.trim();
    final locked = state == MuTaskState.locked;

    final body = Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(MuSpacing.space5, 18, MuSpacing.space5, MuSpacing.space5),
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
                        style: mu.text.eyebrow,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: MuSpacing.space1),
                    ],
                    Text(
                      title,
                      style: mu.text.title3.copyWith(fontSize: 18, color: locked ? c.ink2 : c.ink),
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
            const SizedBox(height: MuSpacing.space2),
            Text(
              description!.trim(),
              style: mu.text.body.copyWith(color: c.ink2, fontSize: 14, height: 20 / 14),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          if (pills.isNotEmpty) ...[
            const SizedBox(height: MuSpacing.space3),
            Wrap(spacing: 6, runSpacing: 6, children: pills),
          ],
          if (footer != null) ...[const SizedBox(height: MuSpacing.space3), footer!],
        ],
      ),
    );

    final card = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: MuSpacing.space5),
          child: Container(
            height: 28,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tabBg,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(MuRadii.tag)),
            ),
            child: Text(
              tag,
              style: mu.text.code.copyWith(color: tabFg, fontWeight: FontWeight.w600, height: 1),
            ),
          ),
        ),
        // The tab sits on the card's flattened top-left corner.
        Transform.translate(offset: const Offset(0, -0.5), child: body),
      ],
    );

    final stateWord = switch (state) {
      MuTaskState.open => '${muGrouped(karma)} karma',
      MuTaskState.review => 'in review',
      MuTaskState.done => 'done, ${muGrouped(karma)} karma earned',
      MuTaskState.rejected => 'needs changes',
      MuTaskState.locked => 'locked${lockedLabel == null ? '' : ', $lockedLabel'}',
    };
    return Semantics(
      container: true,
      button: onTap != null,
      label: '$title, $tag, $stateWord',
      excludeSemantics: footer == null,
      child: onTap == null ? card : MuPressable(onTap: onTap, pressedScale: 0.98, child: card),
    );
  }
}
