import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/input/mu_icon_button.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// The top of a screen. Sits on the screen's own ground (no fill, no
/// hairline). Back is always top-left and always a 44dp circle.
class MuTopBar extends StatelessWidget {
  /// Home's bar: avatar, greeting, a date/level line, then up to two tools.
  const MuTopBar.greeting({
    required this.greeting,
    required this.subtitle,
    this.avatar,
    this.actions = const [],
    super.key,
  }) : title = null,
       onBack = null,
       action = null;

  /// A pushed screen's bar: back, centred title, one contextual action.
  const MuTopBar.detail({this.title, this.onBack, this.action, super.key})
    : greeting = null,
      subtitle = null,
      avatar = null,
      actions = const [];

  /// Greeting line ("Hey Aysha").
  final String? greeting;

  /// Second line ("Thursday, 13 Nov · Level 4").
  final String? subtitle;

  /// Leading avatar on the greeting bar.
  final Widget? avatar;

  /// Trailing tools on the greeting bar (at most two).
  final List<Widget> actions;

  /// Detail title; one line, ellipsized.
  final String? title;

  /// Back handler; defaults to popping the route.
  final VoidCallback? onBack;

  /// One trailing action on the detail bar.
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final Widget row;
    if (greeting != null) {
      row = Row(
        children: [
          if (avatar != null) ...[avatar!, const SizedBox(width: MuSpacing.space3)],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(greeting!, style: mu.text.bodyStrong, maxLines: 1, overflow: TextOverflow.ellipsis),
                Text(subtitle!, style: mu.text.caption, maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          for (final a in actions) ...[const SizedBox(width: MuSpacing.space1), a],
        ],
      );
    } else {
      final canPop = onBack != null || (ModalRoute.of(context)?.canPop ?? false);
      row = Row(
        children: [
          if (canPop)
            MuIconButton(
              icon: LucideIcons.arrowLeft,
              tooltip: 'Back',
              onPressed: onBack ?? () => Navigator.of(context).maybePop(),
            )
          else
            const SizedBox(width: MuSizes.touchMin),
          Expanded(
            child: Semantics(
              header: true,
              child: Text(
                title ?? '',
                textAlign: TextAlign.center,
                style: mu.text.title3.copyWith(color: c.ink),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          action ?? const SizedBox(width: MuSizes.touchMin),
        ],
      );
    }
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 56),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: MuSpacing.space5 - 4),
        child: row,
      ),
    );
  }
}

/// The collapsed bar that appears over scrolling content once a hero leaves:
/// translucent `glass` with a 24px blur, the title and the screen's primary
/// action (so the action never scrolls away).
class MuGlassBar extends StatelessWidget {
  /// A glass bar at [visibility] (0 hidden … 1 shown; drive it from scroll).
  const MuGlassBar({required this.title, this.visibility = 1, this.onBack, this.action, super.key});

  /// One line, ellipsized.
  final String title;

  /// Opacity of the bar; below 0.01 it neither paints nor takes taps.
  final double visibility;

  /// Back handler; defaults to popping the route.
  final VoidCallback? onBack;

  /// Trailing action (e.g. a small "Joined" or "Register" button).
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final v = visibility.clamp(0.0, 1.0);
    final top = MediaQuery.paddingOf(context).top;
    return IgnorePointer(
      ignoring: v < 0.01,
      child: Opacity(
        opacity: v,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(18)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            child: ColoredBox(
              color: c.glass,
              child: Padding(
                padding: EdgeInsets.fromLTRB(MuSpacing.space3, top, MuSpacing.space3, 0),
                child: SizedBox(
                  height: 56,
                  child: Row(
                    children: [
                      MuIconButton(
                        icon: LucideIcons.arrowLeft,
                        tooltip: 'Back',
                        variant: MuIconButtonVariant.sunk,
                        onPressed: onBack ?? () => Navigator.of(context).maybePop(),
                      ),
                      const SizedBox(width: MuSpacing.space2),
                      Expanded(
                        child: Text(
                          title,
                          style: mu.text.title3.copyWith(fontSize: 16),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (action != null) ...[const SizedBox(width: MuSpacing.space2), action!],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
