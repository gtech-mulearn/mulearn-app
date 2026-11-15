import 'package:flutter/material.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// What a [MuFeedIcon] stands for; sets its disc colour.
enum MuFeedTone {
  /// Karma earned: volt.
  karma,

  /// An event or session: cobalt tint.
  event,

  /// Something to fix: danger tint.
  problem,

  /// Waiting on someone: warning tint.
  pending,

  /// Done or approved: success tint.
  done,

  /// Anything else: sunk.
  neutral,
}

/// The 40dp icon disc that leads a system [MuFeedRow].
class MuFeedIcon extends StatelessWidget {
  /// A disc with [icon] in [tone].
  const MuFeedIcon(this.icon, {this.tone = MuFeedTone.neutral, super.key});

  final IconData icon;
  final MuFeedTone tone;

  @override
  Widget build(BuildContext context) {
    final c = context.mu.colors;
    final (Color bg, Color fg) = switch (tone) {
      MuFeedTone.karma => (c.volt, c.onVolt),
      MuFeedTone.event => (c.cobaltTint, c.cobaltText),
      MuFeedTone.problem => (c.dangerTint, c.danger),
      MuFeedTone.pending => (c.warningTint, c.warning),
      MuFeedTone.done => (c.successTint, c.success),
      MuFeedTone.neutral => (c.surfaceSunk, c.ink2),
    };
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      child: Icon(icon, size: MuSizes.iconSm + 2, color: fg),
    );
  }
}

/// One row for everything that happened (artifact FeedRow): notifications,
/// the karma ledger, a circle's activity. A 40dp [leading] (an avatar for
/// people, a [MuFeedIcon] for the system), the [subject] in strong ink
/// followed by the [body], the [time] as people say it, an optional
/// [trailing] amount and inline [actions]. Unread rows end with a cobalt
/// dot and say "Unread" first to screen readers.
class MuFeedRow extends StatelessWidget {
  /// A feed row.
  const MuFeedRow({
    required this.leading,
    required this.subject,
    this.body,
    this.time,
    this.trailing,
    this.actions = const [],
    this.unread = false,
    this.divider = true,
    this.onTap,
    super.key,
  });

  final Widget leading;
  final String subject;
  final String? body;

  /// "2h ago", "Today · Google Meet".
  final String? time;

  /// A karma amount (use [MuFeedAmount]) or nothing.
  final Widget? trailing;

  /// Inline buttons, only for invites and approvals.
  final List<Widget> actions;

  final bool unread;

  /// A hairline under the row (off for the last row of a group).
  final bool divider;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final text = mu.text.body.copyWith(
      fontSize: 14,
      height: 20 / 14,
      color: c.ink2,
    );

    final row = Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        border: divider ? Border(bottom: BorderSide(color: c.line)) : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          leading,
          const SizedBox(width: MuSpacing.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    style: text,
                    children: [
                      TextSpan(
                        text: subject,
                        style: text.copyWith(
                          color: c.ink,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (body != null && body!.isNotEmpty)
                        TextSpan(text: ' $body'),
                      if (unread)
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: Container(
                              width: 7,
                              height: 7,
                              decoration: BoxDecoration(
                                color: c.cobalt,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                if (time != null) ...[
                  const SizedBox(height: 2),
                  Text(time!, style: mu.text.caption),
                ],
                if (actions.isNotEmpty) ...[
                  const SizedBox(height: MuSpacing.space2),
                  Wrap(
                    spacing: MuSpacing.space2,
                    runSpacing: MuSpacing.space2,
                    children: actions,
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: MuSpacing.space2),
            trailing!,
          ],
        ],
      ),
    );

    final label = [if (unread) 'Unread', subject, ?body, ?time].join(', ');
    return Semantics(
      container: true,
      button: onTap != null,
      label: label,
      excludeSemantics: actions.isEmpty,
      child: onTap == null ? row : InkWell(onTap: onTap, child: row),
    );
  }
}

/// A karma amount at the end of a [MuFeedRow]: "+150" in mono volt text.
class MuFeedAmount extends StatelessWidget {
  /// An amount, already signed ("+150").
  const MuFeedAmount(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    return Text(
      text,
      style: mu.text.code.copyWith(
        color: mu.colors.voltText,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

/// A group of [MuFeedRow]s on one `surface` card.
class MuFeedGroup extends StatelessWidget {
  /// Rows on a card.
  const MuFeedGroup({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: MuSpacing.space4,
        vertical: MuSpacing.space1,
      ),
      decoration: BoxDecoration(
        color: context.mu.colors.surface,
        borderRadius: BorderRadius.circular(MuRadii.card),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(children: children),
    );
  }
}
