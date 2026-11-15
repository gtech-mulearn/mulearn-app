import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// The frame every filled field shares (artifact `.mu-field` + `.mu-input`):
/// label above in `label`/`ink-2`; a 56-tall `radius-control` box,
/// `surface-sunk` at rest, `surface` with a 2px cobalt ring when focused,
/// `danger-tint` with a 2px danger ring on error, no fill when read-only;
/// then the error (danger, with an icon) or the help line (`ink-3`).
class MuFieldChrome extends StatelessWidget {
  /// A field frame around [child].
  const MuFieldChrome({
    required this.label,
    required this.child,
    this.help,
    this.error,
    this.focused = false,
    this.readOnly = false,
    this.enabled = true,
    this.multiline = false,
    this.trailing,
    this.onTap,
    super.key,
  });

  /// Label above the box.
  final String label;

  /// The input itself.
  final Widget child;

  /// Help under the box, hidden while [error] shows.
  final String? help;

  /// How to fix the value; turns the box red.
  final String? error;

  final bool focused;
  final bool readOnly;
  final bool enabled;

  /// Grows with its text instead of staying 56 tall.
  final bool multiline;

  /// Inside the box, at the end.
  final Widget? trailing;

  /// Tapping the box (focuses the input or opens a picker).
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final hasError = error != null && error!.isNotEmpty;

    final (Color fill, Color ring) = switch ((hasError, focused, readOnly)) {
      (true, _, _) => (c.dangerTint, c.danger),
      (_, true, _) => (c.surface, c.cobalt),
      (_, _, true) => (c.chalk, c.line),
      _ => (c.surfaceSunk, c.surfaceSunk),
    };

    final box = AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      constraints: const BoxConstraints(minHeight: MuSizes.fieldH),
      padding: EdgeInsetsDirectional.only(
        start: 18,
        end: trailing == null ? 18 : 4,
        top: multiline ? 16 : 0,
        bottom: multiline ? 16 : 0,
      ),
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(MuRadii.control),
        border: Border.all(color: ring, width: focused || hasError ? 2 : 1.5),
      ),
      child: Row(
        crossAxisAlignment: multiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Expanded(child: child),
          ?trailing,
        ],
      ),
    );

    return Opacity(
      opacity: enabled ? 1 : MuOpacity.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: mu.text.label.copyWith(color: c.ink2)),
          const SizedBox(height: 6),
          if (onTap == null) box else GestureDetector(behavior: HitTestBehavior.translucent, onTap: onTap, child: box),
          if (hasError) ...[
            const SizedBox(height: 6),
            Semantics(
              liveRegion: true,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: Icon(LucideIcons.alertCircle, size: 14, color: c.danger),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      error!,
                      style: mu.text.caption.copyWith(color: c.danger, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ] else if (help != null && help!.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(help!, style: mu.text.caption.copyWith(color: c.ink3)),
          ],
        ],
      ),
    );
  }
}
