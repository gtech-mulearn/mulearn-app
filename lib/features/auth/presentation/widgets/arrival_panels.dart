import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/widgets/mu_logo.dart';
import 'package:mulearn_app/features/auth/domain/entities/public_community.dart';

/// The four arrival panels (artifact Pre-login → The four beats). Each is a
/// live μLearn object you can touch, on its own colour.

bool _reduceMotion(BuildContext context) => MediaQuery.maybeDisableAnimationsOf(context) ?? false;

// ── Beat 1: the ring ─────────────────────────────────────────────────────

/// A ring of one group's name ("WEB DEV · WEB DEV…") around "You". Tap it
/// and it bursts: every Interest Group scatters as a sticker. The echo
/// chamber, broken.
class RingPanel extends StatefulWidget {
  const RingPanel({required this.groups, required this.groupCount, super.key});

  /// Real group names (falls back to a few well-known ones while loading).
  final List<GuestInterestGroup> groups;

  final int? groupCount;

  @override
  State<RingPanel> createState() => _RingPanelState();
}

class _RingPanelState extends State<RingPanel> with TickerProviderStateMixin {
  late final AnimationController _spin = AnimationController(vsync: this, duration: const Duration(seconds: 36));
  late final AnimationController _burst = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
  bool _broken = false;

  static const _fallback = [
    'Web Development',
    'AI',
    'Ui Ux',
    'Cyber Security',
    'Blender',
    'Comics',
    'Game Dev',
    'Data Science',
    'IoT and Robotics',
    'Project Management',
    'Space',
    'Creative Design',
  ];

  // Where the 12 stickers land, as fractions of the panel, with a tilt.
  static const _spots = [
    (0.08, 0.10, -6.0),
    (0.55, 0.06, 4.0),
    (0.30, 0.24, 3.0),
    (0.70, 0.27, -5.0),
    (0.04, 0.40, 5.0),
    (0.48, 0.44, -3.0),
    (0.20, 0.58, -4.0),
    (0.62, 0.62, 6.0),
    (0.06, 0.76, 3.0),
    (0.40, 0.80, -6.0),
    (0.70, 0.84, 4.0),
    (0.28, 0.94, 2.0),
  ];

  static const _tones = [
    IgCategory.coder,
    IgCategory.creative,
    IgCategory.maker,
    IgCategory.manager,
    IgCategory.others,
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_reduceMotion(context)) {
      _spin.stop();
    } else if (!_spin.isAnimating && !_broken) {
      unawaited(_spin.repeat());
    }
  }

  @override
  void dispose() {
    _spin.dispose();
    _burst.dispose();
    super.dispose();
  }

  void _break() {
    if (_broken) return;
    HapticFeedback.mediumImpact();
    setState(() => _broken = true);
    _spin.stop();
    if (_reduceMotion(context)) {
      _burst.value = 1;
    } else {
      unawaited(_burst.forward());
    }
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final names = widget.groups.isEmpty ? _fallback : [for (final g in widget.groups.take(12)) g.name];
    final count = widget.groupCount ?? widget.groups.length;

    return ColoredBox(
      color: c.cobalt,
      child: LayoutBuilder(
        builder: (context, box) {
          final w = box.maxWidth;
          final h = box.maxHeight;
          final top = MediaQuery.paddingOf(context).top;
          final stage = Rect.fromLTRB(16, top + 56, w - 16, h - 52);
          return Stack(
            children: [
              Positioned(
                left: MuSpacing.space6,
                top: top + MuSpacing.space4,
                child: const ExcludeSemantics(child: MuLogo.wordmarkOnBrand(height: 26)),
              ),
              // The ring, until it breaks.
              Positioned.fromRect(
                rect: stage,
                child: AnimatedBuilder(
                  animation: _burst,
                  builder: (context, child) => Opacity(
                    opacity: (1 - _burst.value * 2).clamp(0.0, 1.0),
                    child: Transform.scale(scale: 1 + _burst.value * 0.6, child: child),
                  ),
                  child: Semantics(
                    container: true,
                    button: true,
                    label: 'Tap to break the ring and see every Interest Group',
                    excludeSemantics: true,
                    onTap: _break,
                    child: GestureDetector(
                      onTap: _break,
                      onPanStart: (_) => _break(),
                      child: Center(
                        child: SizedBox.square(
                          dimension: 250,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              AnimatedBuilder(
                                animation: _spin,
                                builder: (context, _) => Transform.rotate(
                                  angle: _spin.value * 2 * math.pi,
                                  child: CustomPaint(
                                    size: const Size.square(250),
                                    painter: _RingTextPainter(
                                      text: 'WEB DEV · ',
                                      style: mu.text.label.copyWith(
                                        color: c.volt,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 2,
                                      ),
                                      ring: c.onCobalt.withValues(alpha: 0.22),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 80,
                                height: 80,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: c.onCobalt,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: c.onCobalt.withValues(alpha: 0.2), width: 8),
                                ),
                                child: Text('You', style: mu.text.title3.copyWith(color: c.inkPrint)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // The stickers it breaks into.
              if (_broken)
                for (var i = 0; i < math.min(names.length, _spots.length); i++)
                  AnimatedBuilder(
                    animation: _burst,
                    builder: (context, child) {
                      final t = Curves.easeOutBack.transform(((_burst.value - i * 0.035) / 0.6).clamp(0.0, 1.0));
                      final from = stage.center;
                      final to = Offset(
                        stage.left + _spots[i].$1 * stage.width,
                        stage.top + _spots[i].$2 * stage.height,
                      );
                      final at = Offset.lerp(from, to, t)!;
                      return Positioned(
                        left: at.dx,
                        top: at.dy,
                        child: Opacity(
                          opacity: t.clamp(0.0, 1.0),
                          child: Transform.rotate(angle: _spots[i].$3 * t * math.pi / 180, child: child),
                        ),
                      );
                    },
                    child: MuIgChip(name: names[i], category: _tones[i % _tones.length]),
                  ),
              Positioned(
                left: 0,
                right: 0,
                bottom: MuSpacing.space5,
                child: Text(
                  _broken ? (count > 0 ? '$count Interest Groups. Pick any.' : 'Pick any group.') : 'Tap the ring',
                  textAlign: TextAlign.center,
                  style: mu.text.bodyStrong.copyWith(color: c.onCobalt.withValues(alpha: 0.86)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Text set around a circle, with a hairline ring under it.
class _RingTextPainter extends CustomPainter {
  _RingTextPainter({required this.text, required this.style, required this.ring});

  final String text;
  final TextStyle style;
  final Color ring;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2 - 14;
    canvas.drawCircle(
      center,
      radius + 12,
      Paint()
        ..color = ring
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    // Measure one repeat, then fit as many whole repeats as the circle holds.
    double widthOf(String s) => (TextPainter(
      text: TextSpan(text: s, style: style),
      textDirection: TextDirection.ltr,
    )..layout()).width;
    final circumference = 2 * math.pi * radius;
    final repeats = math.max(1, (circumference / widthOf(text)).floor());
    final full = List.filled(repeats, text).join();
    final scale = circumference / widthOf(full);

    var angle = -math.pi / 2;
    for (final ch in full.characters) {
      final tp = TextPainter(
        text: TextSpan(text: ch, style: style),
        textDirection: TextDirection.ltr,
      )..layout();
      final sweep = tp.width * scale / radius;
      final mid = angle + sweep / 2;
      canvas
        ..save()
        ..translate(center.dx + radius * math.cos(mid), center.dy + radius * math.sin(mid))
        ..rotate(mid + math.pi / 2);
      tp.paint(canvas, Offset(-tp.width / 2, -tp.height / 2));
      canvas.restore();
      angle += sweep;
    }
  }

  @override
  bool shouldRepaint(_RingTextPainter old) => old.text != text || old.style != style || old.ring != ring;
}

// ── Beat 2: a task, then karma ───────────────────────────────────────────

/// A real-looking task card. Posting it on Discord (a tap) gets it reviewed:
/// the tab turns green and karma rolls up, and the level route shows where
/// that karma takes you.
class TaskPanel extends StatefulWidget {
  const TaskPanel({super.key});

  @override
  State<TaskPanel> createState() => _TaskPanelState();
}

class _TaskPanelState extends State<TaskPanel> {
  bool _posted = false;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final top = MediaQuery.paddingOf(context).top;
    final reduce = _reduceMotion(context);

    return ColoredBox(
      color: c.night,
      child: Padding(
        padding: EdgeInsets.fromLTRB(MuSpacing.space5, top + MuSpacing.space8, MuSpacing.space5, MuSpacing.space5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MuTaskCard(
              title: 'Build a React to-do list',
              hashtag: '#cl-react-todo',
              eyebrow: 'Level 3 · Web Development',
              karma: 150,
              state: _posted ? MuTaskState.done : MuTaskState.open,
              footer: MuButton(
                label: _posted ? 'Reviewed by a peer' : 'Post on Discord with the hashtag',
                icon: _posted ? LucideIcons.check : LucideIcons.send,
                size: MuButtonSize.small,
                block: true,
                onPressed: _posted
                    ? null
                    : () {
                        HapticFeedback.mediumImpact();
                        setState(() => _posted = true);
                      },
              ),
            ),
            const SizedBox(height: MuSpacing.space5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text('YOUR KARMA', style: mu.text.eyebrow.copyWith(color: c.onNight2)),
                ),
                TweenAnimationBuilder<double>(
                  tween: Tween(end: _posted ? 12480 : 12330),
                  duration: reduce ? Duration.zero : const Duration(milliseconds: 900),
                  curve: Curves.easeOutCubic,
                  builder: (context, v, _) =>
                      Text(muGrouped(v.round()), style: mu.text.numeralXl.copyWith(fontSize: 46, color: c.volt)),
                ),
              ],
            ),
            const SizedBox(height: MuSpacing.space3),
            ExcludeSemantics(
              child: Row(
                children: [
                  for (var i = 1; i <= 7; i++) ...[
                    if (i > 1) const SizedBox(width: 6),
                    Expanded(
                      child: Container(
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: i < 4 ? c.cobalt : (i == 4 ? c.volt : c.onNight.withValues(alpha: 0.08)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '$i',
                          style: mu.text.title3.copyWith(color: i < 4 ? c.onCobalt : (i == 4 ? c.onVolt : c.onNight2)),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Beat 3: a learning circle ────────────────────────────────────────────

/// A learning circle: five peers around the circle, voices you can flick
/// away. The ring turns slowly.
class CirclePanel extends StatefulWidget {
  const CirclePanel({super.key});

  @override
  State<CirclePanel> createState() => _CirclePanelState();
}

class _CirclePanelState extends State<CirclePanel> with SingleTickerProviderStateMixin {
  late final AnimationController _spin = AnimationController(vsync: this, duration: const Duration(seconds: 48));

  static const _peers = ['Arjun R', 'Sneha N', 'Fathima R', 'Nikhil K', 'Jishnu M'];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_reduceMotion(context)) {
      _spin.stop();
    } else if (!_spin.isAnimating) {
      unawaited(_spin.repeat());
    }
  }

  @override
  void dispose() {
    _spin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final top = MediaQuery.paddingOf(context).top;

    return ColoredBox(
      color: c.igMaker,
      child: LayoutBuilder(
        builder: (context, box) {
          final center = Offset(box.maxWidth / 2, top + (box.maxHeight - top) * 0.47);
          const r = 78.0;
          return Stack(
            children: [
              Positioned(
                left: center.dx - r,
                top: center.dy - r,
                child: Container(
                  width: r * 2,
                  height: r * 2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: c.inkPrint.withValues(alpha: 0.35), width: 2),
                  ),
                ),
              ),
              Positioned(
                left: center.dx - 32,
                top: center.dy - 32,
                child: Container(
                  width: 64,
                  height: 64,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: c.night, shape: BoxShape.circle),
                  child: Text('8', style: mu.text.title2.copyWith(color: c.onNight)),
                ),
              ),
              AnimatedBuilder(
                animation: _spin,
                builder: (context, _) => Stack(
                  children: [
                    for (var i = 0; i < _peers.length; i++)
                      Builder(
                        builder: (context) {
                          final a = -math.pi / 2 + i * 2 * math.pi / _peers.length + _spin.value * 2 * math.pi;
                          return Positioned(
                            left: center.dx + r * math.cos(a) - 22,
                            top: center.dy + r * math.sin(a) - 22,
                            child: MuAvatar(name: _peers[i], size: 44),
                          );
                        },
                      ),
                  ],
                ),
              ),
              Positioned(
                left: MuSpacing.space5,
                top: top + MuSpacing.space8,
                child: const MuFlickable(child: MuVoiceBubble('Stuck on hooks?')),
              ),
              Positioned(
                right: MuSpacing.space4,
                top: center.dy - r - 24,
                child: const MuFlickable(
                  child: MuVoiceBubble("I'll pair with you", tone: MuVoiceTone.volt, tailRight: true),
                ),
              ),
              const Positioned(
                left: MuSpacing.space6,
                bottom: MuSpacing.space8,
                child: MuFlickable(child: MuVoiceBubble('Thursday, 6 PM?', tone: MuVoiceTone.cobalt)),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ── Beat 4: tickets ──────────────────────────────────────────────────────

/// Two tilted tickets: the featured event and Career Lab. Toss them aside;
/// they come back.
class TicketsPanel extends StatelessWidget {
  const TicketsPanel({required this.event, required this.companies, super.key});

  final GuestEvent? event;
  final int? companies;

  static const _months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

  static String _when(GuestEvent e) {
    final s = e.start;
    final end = e.end;
    if (s == null) return e.place.toUpperCase();
    final from = '${s.day} ${_months[s.month - 1]}';
    final range = end == null || (end.day == s.day && end.month == s.month)
        ? from
        : '$from – ${end.day} ${_months[end.month - 1]}';
    return '$range · ${e.place}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.mu.colors;
    final top = MediaQuery.paddingOf(context).top;
    final e = event;

    return ColoredBox(
      color: c.igManager,
      child: Padding(
        padding: EdgeInsets.only(top: top + MuSpacing.space6),
        child: Stack(
          children: [
            Positioned(
              left: MuSpacing.space5,
              right: 64,
              top: MuSpacing.space8,
              child: MuFlickable(
                toss: true,
                child: Transform.rotate(
                  angle: -4 * math.pi / 180,
                  child: _MiniTicket(
                    eyebrow: e == null ? 'FEATURED EVENT' : _when(e),
                    title: e?.title ?? 'Learning Fest',
                    pill: MuPill(
                      e == null ? 'Open to everyone' : '${muGrouped(e.interested)} interested',
                      tone: MuPillTone.volt,
                      icon: LucideIcons.zap,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 96,
              right: MuSpacing.space4,
              top: 170,
              child: MuFlickable(
                toss: true,
                child: Transform.rotate(
                  angle: 5 * math.pi / 180,
                  child: _MiniTicket(
                    eyebrow: 'CAREER LAB',
                    title: 'Hiring calls',
                    pill: MuPill(
                      companies == null ? 'Partner companies' : '${muGrouped(companies!)} partner companies',
                      tone: MuPillTone.night,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniTicket extends StatelessWidget {
  const _MiniTicket({required this.eyebrow, required this.title, required this.pill});

  final String eyebrow;
  final String title;
  final Widget pill;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    // Printed matter: white paper and print ink in both themes.
    return Container(
      decoration: ShapeDecoration(
        color: c.onCobalt,
        shape: const MuTicketBorder(perforationFromBottom: 62, radius: 22, notch: 13),
        shadows: mu.shadows.lift,
      ),
      padding: const EdgeInsets.fromLTRB(MuSpacing.space5, 18, MuSpacing.space5, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            eyebrow,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: mu.text.eyebrow.copyWith(color: c.ink3),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: mu.text.title2.copyWith(color: c.inkPrint, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 28),
          pill,
        ],
      ),
    );
  }
}

/// Lets a small object be grabbed and flicked: it follows the finger 1:1,
/// and on release springs home carrying the throw's velocity. With [toss],
/// a hard throw sends it off along the projected path, and it fades back in
/// at home a moment later. Static under reduced motion.
class MuFlickable extends StatefulWidget {
  const MuFlickable({required this.child, this.toss = false, super.key});

  final Widget child;
  final bool toss;

  @override
  State<MuFlickable> createState() => _MuFlickableState();
}

class _MuFlickableState extends State<MuFlickable> with TickerProviderStateMixin {
  late final AnimationController _x = AnimationController.unbounded(vsync: this);
  late final AnimationController _y = AnimationController.unbounded(vsync: this);
  late final AnimationController _fade = AnimationController(
    vsync: this,
    value: 1,
    duration: const Duration(milliseconds: 260),
  );
  Timer? _return;

  @override
  void dispose() {
    _return?.cancel();
    _x.dispose();
    _y.dispose();
    _fade.dispose();
    super.dispose();
  }

  void _home(Velocity v) {
    final spring = MuSprings.momentum.description;
    unawaited(_x.animateWith(SpringSimulation(spring, _x.value, 0, v.pixelsPerSecond.dx)));
    unawaited(_y.animateWith(SpringSimulation(spring, _y.value, 0, v.pixelsPerSecond.dy)));
  }

  void _end(DragEndDetails d) {
    final v = d.velocity.pixelsPerSecond;
    if (widget.toss && v.distance > 1400) {
      HapticFeedback.lightImpact();
      // Off along where the throw was going, then back home, faded in.
      final to = Offset(_x.value + project(v.dx), _y.value + project(v.dy));
      final spring = MuSprings.momentum.description;
      unawaited(_x.animateWith(SpringSimulation(spring, _x.value, to.dx, v.dx)));
      unawaited(_y.animateWith(SpringSimulation(spring, _y.value, to.dy, v.dy)));
      unawaited(_fade.reverse());
      _return = Timer(const Duration(milliseconds: 1100), () {
        if (!mounted) return;
        _x.value = 0;
        _y.value = 0;
        unawaited(_fade.forward());
      });
      return;
    }
    _home(d.velocity);
  }

  @override
  Widget build(BuildContext context) {
    if (_reduceMotion(context)) return widget.child;
    return GestureDetector(
      onPanStart: (_) {
        _return?.cancel();
        _x.stop();
        _y.stop();
        _fade.value = 1;
      },
      onPanUpdate: (d) {
        _x.value += d.delta.dx;
        _y.value += d.delta.dy;
      },
      onPanEnd: _end,
      child: AnimatedBuilder(
        animation: Listenable.merge([_x, _y, _fade]),
        builder: (context, child) => Opacity(
          opacity: _fade.value,
          child: Transform.translate(offset: Offset(_x.value, _y.value), child: child),
        ),
        child: widget.child,
      ),
    );
  }
}
