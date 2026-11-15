import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:mulearn_app/core/design_system/motion/mu_pressable.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/theme/mu_tones.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// An Interest Group as a sticker: category colour, one sharp "peel"
/// corner, a slight tilt fixed by its position in the list.
class MuIgSticker extends StatelessWidget {
  /// A sticker. [index] fixes the tilt (−3°, +2.5°, 0°, repeating).
  const MuIgSticker({
    required this.name,
    required this.category,
    this.code,
    this.members,
    this.joined = false,
    this.joining = false,
    this.selected = false,
    this.index = 0,
    this.onTap,
    this.onJoin,
    this.width = 156,
    super.key,
  });

  /// 156 in a 2-up row on a 360 screen; null fills the cell it is given.
  final double? width;

  /// IG name ("Web Development").
  final String name;

  /// Fill.
  final IgCategory category;

  /// Short code ("WEB"); shown with the category.
  final String? code;

  /// Member count, when the backend sends it.
  final int? members;

  /// Shows "Joined".
  final bool joined;

  /// The join request is in flight.
  final bool joining;

  /// Picker mode: outlined with a check.
  final bool selected;

  /// Position in its list; sets the tilt.
  final int index;

  /// Opens the IG.
  final VoidCallback? onTap;

  /// Join (or, when [joined], leave). Null hides the button.
  final VoidCallback? onJoin;

  static const _tilts = [-3.0, 2.5, 0.0];

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final ink = c.inkPrint;
    final tilt = _tilts[index % _tilts.length] * math.pi / 180;
    final label = [
      if (code != null) code!.toUpperCase(),
      category.name.toUpperCase(),
    ].join(' · ');

    final body = Container(
      width: width,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: MuTones.forIgCategory(c, category),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
          bottomLeft: Radius.circular(MuRadii.tag),
        ),
        border: selected ? Border.all(color: c.night, width: 2) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ExcludeSemantics(
            child: Text(
              label,
              style: mu.text.codeSm.copyWith(
                color: ink.withValues(alpha: 0.75),
              ),
            ),
          ),
          const SizedBox(height: MuSpacing.space5),
          ExcludeSemantics(
            child: Text(
              name,
              style: mu.text.title2.copyWith(
                fontSize: 19,
                height: 1.05,
                fontWeight: FontWeight.w800,
                color: ink,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: MuSpacing.space5),
          Row(
            children: [
              Expanded(
                child: ExcludeSemantics(
                  child: Text(
                    members == null
                        ? ''
                        : (members == 1
                              ? '1 member'
                              : '${_compact(members!)} members'),
                    style: mu.text.caption.copyWith(color: ink),
                  ),
                ),
              ),
              if (onJoin != null)
                _JoinButton(
                  joined: joined,
                  joining: joining,
                  name: name,
                  onPressed: onJoin!,
                ),
              if (selected) Icon(Icons.check_circle, size: 22, color: c.night),
            ],
          ),
        ],
      ),
    );

    return Semantics(
      container: true,
      button: onTap != null,
      selected: selected,
      label: [
        '$name, ${category.name} Interest Group',
        if (members != null) '$members members',
        if (joined) 'joined',
      ].join(', '),
      child: Transform.rotate(
        angle: tilt,
        child: onTap == null ? body : MuPressable(onTap: onTap, child: body),
      ),
    );
  }

  static String _compact(int n) =>
      n >= 1000 ? '${(n / 1000).toStringAsFixed(n >= 10000 ? 0 : 1)}k' : '$n';
}

class _JoinButton extends StatelessWidget {
  const _JoinButton({
    required this.joined,
    required this.joining,
    required this.name,
    required this.onPressed,
  });

  final bool joined;
  final bool joining;
  final String name;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final bg = joined
        ? c.onCobalt.withValues(alpha: 0.75)
        : c.inkPrint.withValues(alpha: 0.9);
    final fg = joined ? c.inkPrint : c.onCobalt;
    return Semantics(
      container: true,
      button: true,
      label: joined ? 'Leave $name' : 'Join $name',
      excludeSemantics: true,
      child: MuPressable(
        onTap: joining ? null : onPressed,
        pressedScale: 0.94,
        child: Container(
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: MuSpacing.space3),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(MuRadii.round),
          ),
          child: joining
              ? SizedBox.square(
                  dimension: 14,
                  child: CircularProgressIndicator(strokeWidth: 2, color: fg),
                )
              : Text(
                  joined ? 'Joined' : 'Join',
                  style: mu.text.label.copyWith(color: fg, fontSize: 12),
                ),
        ),
      ),
    );
  }
}

/// A small Interest Group chip (profile interests, event "for" lines).
class MuIgChip extends StatelessWidget {
  /// A chip for [name] in its [category] colour.
  const MuIgChip({
    required this.name,
    required this.category,
    this.onTap,
    super.key,
  });

  /// IG name.
  final String name;

  /// Fill.
  final IgCategory category;

  /// Opens the IG.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final chip = Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: MuTones.forIgCategory(c, category),
        borderRadius: BorderRadius.circular(MuRadii.round),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              name,
              style: mu.text.label.copyWith(color: c.inkPrint),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
    return Semantics(
      button: onTap != null,
      label: '$name Interest Group',
      excludeSemantics: true,
      child: onTap == null ? chip : MuPressable(onTap: onTap, child: chip),
    );
  }
}
