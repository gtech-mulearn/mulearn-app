import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:mulearn_app/core/design_system/content/mu_ig_sticker.dart';
import 'package:mulearn_app/core/design_system/foundation/mu_avatar.dart';
import 'package:mulearn_app/core/design_system/motion/mu_pressable.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/theme/mu_tones.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// Someone sitting in a circle's ring.
typedef MuRingSeat = ({String name, String? url});

/// A learning circle drawn as what it is (artifact CircleCard): members in
/// a ring with the count in the middle; beside it the IG chip, the title,
/// one caption line and the action.
///
/// [members] fills up to five seats with faces; when a list doesn't carry
/// them, the ring shows empty seats for up to five of [total].
class MuCircleCard extends StatelessWidget {
  /// A circle card.
  const MuCircleCard({
    required this.title,
    required this.total,
    this.igName,
    this.igCategory = IgCategory.others,
    this.caption,
    this.members = const [],
    this.badge,
    this.action,
    this.live = false,
    this.onTap,
    super.key,
  });

  final String title;

  /// Members counted (shown in the core).
  final int total;

  final String? igName;
  final IgCategory igCategory;

  /// "Next: Sat 10 AM · Online · 8 members".
  final String? caption;

  /// Faces for the ring, in order.
  final List<MuRingSeat> members;

  /// Beside the IG chip ("You lead").
  final Widget? badge;

  /// One button (Join circle, Open, Request sent).
  final Widget? action;

  /// A meeting is on now: the core turns volt.
  final bool live;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;

    final card = Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(MuRadii.card),
      ),
      child: Row(
        children: [
          ExcludeSemantics(
            child: _Ring(members: members, total: total, live: live),
          ),
          const SizedBox(width: MuSpacing.space4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (igName != null || badge != null)
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      if (igName != null)
                        ExcludeSemantics(
                          child: MuIgChip(name: igName!, category: igCategory),
                        ),
                      ?badge,
                    ],
                  ),
                const SizedBox(height: 6),
                Text(
                  title,
                  style: mu.text.title3,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (caption != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    caption!,
                    style: mu.text.caption,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                if (action != null) ...[
                  const SizedBox(height: MuSpacing.space3),
                  action!,
                ],
              ],
            ),
          ),
        ],
      ),
    );

    return Semantics(
      container: true,
      button: onTap != null,
      label: [
        title,
        ?igName,
        if (total == 1) '1 member' else '$total members',
        if (live) 'meeting live now',
        ?caption,
      ].join(', '),
      explicitChildNodes: true,
      child: onTap == null
          ? card
          : MuPressable(onTap: onTap, pressedScale: 0.99, child: card),
    );
  }
}

class _Ring extends StatelessWidget {
  const _Ring({required this.members, required this.total, required this.live});

  final List<MuRingSeat> members;
  final int total;
  final bool live;

  static const double _size = 96;
  static const double _seat = 30;
  static const double _orbit = 40;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final seats = members.isNotEmpty
        ? math.min(members.length, 5)
        : math.min(total, 5);

    Offset at(int i) {
      // 72° apart, the first at the top.
      final a = -math.pi / 2 + i * 2 * math.pi / 5;
      return Offset(
        _size / 2 + _orbit * math.cos(a) - _seat / 2,
        _size / 2 + _orbit * math.sin(a) - _seat / 2,
      );
    }

    return SizedBox.square(
      dimension: _size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: c.lineStrong, width: 1.5),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                decoration: BoxDecoration(
                  color: live ? c.volt : c.night,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      total > 999 ? '999+' : '$total',
                      style: mu.text.title3.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: live ? c.onVolt : c.onNight,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          for (var i = 0; i < seats; i++)
            Positioned(
              left: at(i).dx,
              top: at(i).dy,
              child: members.isNotEmpty
                  ? MuAvatar(
                      name: members[i].name,
                      url: members[i].url,
                      size: _seat,
                    )
                  : Container(
                      width: _seat,
                      height: _seat,
                      decoration: BoxDecoration(
                        color: MuTones.forIgCategory(c, MuTones.hashed('$i')),
                        shape: BoxShape.circle,
                        border: Border.all(color: c.surface, width: 2),
                      ),
                    ),
            ),
        ],
      ),
    );
  }
}
