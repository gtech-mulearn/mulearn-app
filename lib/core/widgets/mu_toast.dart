import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_shadow.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';

enum MuToastType { success, error, info }

/// Floating toast — a nicer, haptic-backed alternative to the default
/// [SnackBar] (rules.md §8). Slides up + fades in from right at the bottom
/// edge, auto-dismisses, and fires a type-appropriate haptic the moment it
/// appears. Errors additionally wobble side to side on entrance for extra
/// urgency. At most one toast shows at a time; calling [MuToast.show] again
/// replaces whatever's currently up.
class MuToast {
  MuToast._();

  static OverlayEntry? _current;

  static void show(
    BuildContext context, {
    required String message,
    MuToastType type = MuToastType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    _current?.remove();
    _current = null;

    final overlay = Overlay.of(context, rootOverlay: true);
    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => _ToastWidget(
        message: message,
        type: type,
        duration: duration,
        onDismissed: () {
          if (_current == entry) {
            _current = null;
          }
          entry.remove();
        },
      ),
    );
    _current = entry;
    overlay.insert(entry);
  }
}

class _ToastWidget extends StatefulWidget {
  const _ToastWidget({
    required this.message,
    required this.type,
    required this.duration,
    required this.onDismissed,
  });

  final String message;
  final MuToastType type;
  final Duration duration;
  final VoidCallback onDismissed;

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    duration: const Duration(milliseconds: 320),
    reverseDuration: const Duration(milliseconds: 220),
    vsync: this,
  );
  late final _slide = Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero)
      .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
  late final _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

  /// Horizontal wobble layered on top of the entrance slide, error only —
  /// a "no!" shake to make errors read as more urgent than a plain toast.
  late final _shake = TweenSequence<double>([
    TweenSequenceItem(tween: Tween(begin: 0, end: 8), weight: 1),
    TweenSequenceItem(tween: Tween(begin: 8, end: -8), weight: 1),
    TweenSequenceItem(tween: Tween(begin: -8, end: 6), weight: 1),
    TweenSequenceItem(tween: Tween(begin: 6, end: -4), weight: 1),
    TweenSequenceItem(tween: Tween(begin: -4, end: 0), weight: 1),
  ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

  (IconData, Color, Color) get _style => switch (widget.type) {
        MuToastType.success => (LucideIcons.checkCircle2, MuColors.statKarmaTint, MuColors.statKarmaAccent),
        MuToastType.error => (LucideIcons.alertCircle, const Color(0xFFFFE9E5), MuColors.coral),
        MuToastType.info => (LucideIcons.info, MuColors.primaryTint, MuColors.primary),
      };

  @override
  void initState() {
    super.initState();
    switch (widget.type) {
      case MuToastType.success:
        HapticFeedback.mediumImpact();
      case MuToastType.error:
        // A single impact reads as a generic tap — errors get a double-buzz
        // (mirrors iOS's own UINotificationFeedbackGenerator.error pattern),
        // timed against the shake's two outward peaks so the buzz and the
        // wobble land together instead of fighting each other.
        HapticFeedback.heavyImpact();
        Future.delayed(const Duration(milliseconds: 130), () {
          if (mounted) HapticFeedback.heavyImpact();
        });
      case MuToastType.info:
        HapticFeedback.lightImpact();
    }
    _controller.forward();
    Future.delayed(widget.duration, _dismiss);
  }

  Future<void> _dismiss() async {
    if (!mounted) return;
    await _controller.reverse();
    widget.onDismissed();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final (icon, tint, accent) = _style;
    return Positioned(
      bottom: MediaQuery.of(context).padding.bottom + MuSpace.s,
      left: MuSpace.screenH,
      right: MuSpace.screenH,
      child: SafeArea(
        top: false,
        bottom: false,
        child: FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: AnimatedBuilder(
              animation: _shake,
              builder: (context, child) => Transform.translate(
                offset: Offset(
                  widget.type == MuToastType.error ? _shake.value : 0,
                  0,
                ),
                child: child,
              ),
              child: GestureDetector(
                onTap: _dismiss,
                child: Material(
                  color: MuColors.surface,
                  borderRadius: BorderRadius.circular(MuRadius.inner),
                  child: Container(
                    padding: const EdgeInsets.all(MuSpace.m),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(MuRadius.inner),
                      boxShadow: MuShadow.card,
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(color: tint, shape: BoxShape.circle),
                          alignment: Alignment.center,
                          child: Icon(icon, size: 18, color: accent),
                        ),
                        const SizedBox(width: MuSpace.m),
                        Expanded(
                          child: Text(
                            widget.message,
                            style: MuType.bodyMed,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
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
