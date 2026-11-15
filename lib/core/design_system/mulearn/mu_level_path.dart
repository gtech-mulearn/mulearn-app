import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/input/mu_pill.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// Where a member is relative to a level.
enum MuStopState {
  /// Travelled.
  done,

  /// The member's current level.
  now,

  /// Not reached yet but open: its tasks can be done now.
  ahead,

  /// Not reached yet and closed.
  locked,
}

/// One station on the [MuLevelPath].
class MuLevelStop {
  /// A level station.
  const MuLevelStop({required this.number, required this.title, required this.state, this.meta, this.progress});

  /// Level number (1–7).
  final int number;

  /// "Level 4" or "Level 4 · you're here".
  final String title;

  /// Done / now / ahead / locked.
  final MuStopState state;

  /// "264 tasks · 1,520 karma to go".
  final String? meta;

  /// 0–1 progress through the current level (now only).
  final double? progress;
}

/// The learning journey as a route: seven stations on one line. Travelled
/// line and stations in cobalt, the current station a volt node with a halo,
/// stations ahead outlined, locked stations hatched.
class MuLevelPath extends StatelessWidget {
  /// A route of [stops]; [onOpen] opens a level's tasks.
  const MuLevelPath({required this.stops, this.onOpen, super.key});

  /// Stations in order.
  final List<MuLevelStop> stops;

  /// Opens a level.
  final ValueChanged<MuLevelStop>? onOpen;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < stops.length; i++)
          _Stop(
            stop: stops[i],
            first: i == 0,
            last: i == stops.length - 1,
            arrived: i > 0 && stops[i - 1].state == MuStopState.done,
            onOpen: onOpen,
          ),
      ],
    );
  }
}

class _Stop extends StatelessWidget {
  const _Stop({
    required this.stop,
    required this.first,
    required this.last,
    required this.arrived,
    required this.onOpen,
  });

  final MuLevelStop stop;
  final bool first;
  final bool last;
  final bool arrived;
  final ValueChanged<MuLevelStop>? onOpen;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final locked = stop.state == MuStopState.locked;
    final travelled = c.cobalt;
    final ahead = c.lineStrong;

    final node = switch (stop.state) {
      MuStopState.done => Container(
        width: 44,
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: c.cobalt, shape: BoxShape.circle),
        child: Text('${stop.number}', style: mu.text.title3.copyWith(color: c.onCobalt)),
      ),
      MuStopState.now => Container(
        width: 44,
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: c.volt,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: c.chalk, spreadRadius: 6),
            BoxShadow(color: c.volt, spreadRadius: 8),
          ],
        ),
        child: Text('${stop.number}', style: mu.text.title3.copyWith(color: c.onVolt)),
      ),
      MuStopState.ahead => Container(
        width: 44,
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: c.surface,
          shape: BoxShape.circle,
          border: Border.all(color: c.lineStrong, width: 2),
        ),
        child: Text('${stop.number}', style: mu.text.title3.copyWith(color: c.ink)),
      ),
      MuStopState.locked => SizedBox.square(
        dimension: 44,
        child: CustomPaint(
          painter: _HatchedDisc(fill: c.surface, stripe: c.surfaceSunk, ring: c.lineStrong),
          child: Center(
            child: Text('${stop.number}', style: mu.text.title3.copyWith(color: c.ink3)),
          ),
        ),
      ),
    };

    final trailing = switch (stop.state) {
      MuStopState.done => const MuPill('', tone: MuPillTone.success, icon: LucideIcons.check),
      MuStopState.now => MuPill(
        stop.progress == null ? "You're here" : "You're here · ${(stop.progress! * 100).round()}%",
        tone: MuPillTone.volt,
      ),
      MuStopState.ahead => Icon(LucideIcons.chevronRight, size: MuSizes.iconSm, color: c.ink3),
      MuStopState.locked => Icon(LucideIcons.lock, size: MuSizes.iconSm, color: c.ink3),
    };

    final row = SizedBox(
      height: 68,
      child: Stack(
        children: [
          // Line: the half above the node is travelled once the previous
          // stop is done; the half below once this one is.
          if (!first)
            Positioned(left: 20.5, width: 3, top: 0, height: 34, child: ColoredBox(color: arrived ? travelled : ahead)),
          if (!last)
            Positioned(
              left: 20.5,
              width: 3,
              top: 34,
              bottom: 0,
              child: ColoredBox(color: stop.state == MuStopState.done ? travelled : ahead),
            ),
          Row(
            children: [
              node,
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stop.title,
                      style: mu.text.title3.copyWith(fontSize: 16, color: locked ? c.ink2 : c.ink),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (stop.meta != null)
                      Text(stop.meta!, style: mu.text.caption, maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              trailing,
            ],
          ),
        ],
      ),
    );

    final stateWord = switch (stop.state) {
      MuStopState.done => 'done',
      MuStopState.now => "you're here",
      MuStopState.ahead => 'ahead',
      MuStopState.locked => 'locked',
    };
    return Semantics(
      container: true,
      button: onOpen != null,
      label: [stop.title, stateWord, ?stop.meta].join(', '),
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onOpen == null ? null : () => onOpen!(stop),
        child: row,
      ),
    );
  }
}

class _HatchedDisc extends CustomPainter {
  _HatchedDisc({required this.fill, required this.stripe, required this.ring});

  final Color fill;
  final Color stripe;
  final Color ring;

  @override
  void paint(Canvas canvas, Size size) {
    final r = size.shortestSide / 2;
    final center = size.center(Offset.zero);
    final clip = Path()..addOval(Rect.fromCircle(center: center, radius: r));
    canvas
      ..save()
      ..clipPath(clip)
      ..drawPaint(Paint()..color = fill);
    final p = Paint()
      ..color = stripe
      ..strokeWidth = 4;
    for (var x = -size.height; x < size.width; x += 8) {
      canvas.drawLine(Offset(x, size.height), Offset(x + size.height, 0), p);
    }
    canvas
      ..restore()
      ..drawCircle(
        center,
        r - 1,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = ring,
      );
  }

  @override
  bool shouldRepaint(_HatchedDisc old) => old.fill != fill || old.stripe != stripe || old.ring != ring;
}
