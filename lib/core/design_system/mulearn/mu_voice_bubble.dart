import 'package:flutter/material.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// Fill of a [MuVoiceBubble].
enum MuVoiceTone {
  /// White.
  paper,

  /// Volt.
  volt,

  /// Cobalt, white text (only on a non-cobalt ground).
  cobalt,

  /// IG creative pink.
  creative,

  /// IG manager sun.
  manager,

  /// IG maker orange.
  maker,
}

/// A pill speech bubble with a tail: what the community says to each other
/// ("Ask in the circle"). Pre-login, invites and circle welcomes only.
class MuVoiceBubble extends StatelessWidget {
  /// A bubble saying [text].
  const MuVoiceBubble(
    this.text, {
    this.tone = MuVoiceTone.paper,
    this.tailRight = false,
    this.compact = false,
    super.key,
  });

  /// Short peer imperative, sentence case.
  final String text;

  /// Fill.
  final MuVoiceTone tone;

  /// Tail at the bottom right instead of left.
  final bool tailRight;

  /// 44dp tall instead of 52dp.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final (bg, fg) = switch (tone) {
      MuVoiceTone.paper => (c.onCobalt, c.inkPrint),
      MuVoiceTone.volt => (c.volt, c.onVolt),
      MuVoiceTone.cobalt => (c.cobalt, c.onCobalt),
      MuVoiceTone.creative => (c.igCreative, c.inkPrint),
      MuVoiceTone.manager => (c.igManager, c.inkPrint),
      MuVoiceTone.maker => (c.igMaker, c.inkPrint),
    };
    final height = compact ? 44.0 : 52.0;
    return CustomPaint(
      painter: _Tail(color: bg, right: tailRight),
      child: Container(
        height: height,
        padding: EdgeInsets.symmetric(horizontal: compact ? 18 : 22),
        alignment: Alignment.center,
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(MuRadii.round)),
        child: Text(
          text,
          maxLines: 1,
          style: mu.text.bodyLg.copyWith(
            fontSize: compact ? 16 : 19,
            fontWeight: FontWeight.w500,
            color: fg,
            height: 1,
          ),
        ),
      ),
    );
  }
}

class _Tail extends CustomPainter {
  _Tail({required this.color, required this.right});

  final Color color;
  final bool right;

  @override
  void paint(Canvas canvas, Size size) {
    final y = size.height;
    final x = right ? size.width - 26 : 10.0;
    final path = Path()
      ..moveTo(x, y - 8)
      ..lineTo(x + 16, y - 8)
      ..lineTo(right ? x + 16 : x, y + 6)
      ..close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_Tail old) => old.color != color || old.right != right;
}
