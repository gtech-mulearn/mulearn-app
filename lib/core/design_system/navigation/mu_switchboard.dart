import 'package:flutter/material.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/theme/mu_tones.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// One door of a [MuSwitchboard].
class MuDoor {
  /// A door: label, icon, the IG colour of its icon well, where it goes.
  const MuDoor({
    required this.label,
    required this.icon,
    required this.tone,
    required this.onTap,
  });

  /// "Events", "Interest Groups"…
  final String label;

  /// Glyph in the well.
  final IconData icon;

  /// Well colour.
  final IgCategory tone;

  /// Opens the place.
  final VoidCallback onTap;
}

/// The community's doors as a ruled 2×2 directory, closed by a live pulse
/// strip. Four doors, never more.
class MuSwitchboard extends StatelessWidget {
  /// A switchboard of exactly four [doors]; [pulse] items tick below.
  const MuSwitchboard({required this.doors, this.pulse = const [], super.key})
    : assert(doors.length == 4, 'a switchboard has four doors');

  /// Doors in reading order.
  final List<MuDoor> doors;

  /// Live facts for the pulse strip ("73,953 learners").
  final List<String> pulse;

  @override
  Widget build(BuildContext context) {
    final c = context.mu.colors;
    final rule = BorderSide(color: c.ink, width: 1.5);
    Widget door(int i) => _Door(
      door: doors[i],
      border: Border(right: i.isEven ? rule : BorderSide.none, bottom: rule),
    );
    return DecoratedBox(
      decoration: BoxDecoration(
        color: c.surface,
        border: Border.fromBorderSide(rule),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(child: door(0)),
              Expanded(child: door(1)),
            ],
          ),
          Row(
            children: [
              Expanded(child: door(2)),
              Expanded(child: door(3)),
            ],
          ),
          if (pulse.isNotEmpty) MuPulseStrip(items: pulse),
        ],
      ),
    );
  }
}

class _Door extends StatefulWidget {
  const _Door({required this.door, required this.border});

  final MuDoor door;
  final Border border;

  @override
  State<_Door> createState() => _DoorState();
}

class _DoorState extends State<_Door> {
  bool _down = false;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    return Semantics(
      button: true,
      label: widget.door.label,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => setState(() => _down = true),
        onTapCancel: () => setState(() => _down = false),
        onTapUp: (_) => setState(() => _down = false),
        onTap: widget.door.onTap,
        child: Container(
          height: 76,
          padding: const EdgeInsets.symmetric(horizontal: MuSpacing.space4),
          decoration: BoxDecoration(
            color: _down ? c.surfaceSunk : null,
            border: widget.border,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.door.label,
                  style: mu.text.title3.copyWith(fontSize: 15, height: 1.2),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: MuSpacing.space2),
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: MuTones.forIgCategory(c, widget.door.tone),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(widget.door.icon, size: 18, color: c.inkPrint),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A night strip that scrolls live community facts, each led by a volt dot.
/// Pauses while touched; still (showing the first items) under reduced
/// motion. Screen readers get the whole list once.
class MuPulseStrip extends StatefulWidget {
  /// A strip of [items].
  const MuPulseStrip({required this.items, this.speed = 36, super.key});

  /// Facts, in order.
  final List<String> items;

  /// Logical pixels per second.
  final double speed;

  @override
  State<MuPulseStrip> createState() => _MuPulseStripState();
}

class _MuPulseStripState extends State<MuPulseStrip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ticker = AnimationController(
    vsync: this,
    duration: const Duration(days: 1),
  );
  final _scroll = ScrollController();
  bool _paused = false;
  Duration _last = Duration.zero;

  @override
  void initState() {
    super.initState();
    _ticker.addListener(_tick);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final still = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    if (still) {
      _ticker.stop();
    } else if (!_ticker.isAnimating) {
      _ticker.repeat();
    }
  }

  void _tick() {
    final now = _ticker.lastElapsedDuration ?? Duration.zero;
    final dt = (now - _last).inMicroseconds / 1e6;
    _last = now;
    if (_paused || !_scroll.hasClients || dt <= 0 || dt > 0.1) return;
    final max = _scroll.position.maxScrollExtent;
    if (max <= 0) return;
    // The list holds the items twice; wrap at the halfway point.
    var next = _scroll.offset + widget.speed * dt;
    if (next >= max / 2) next -= max / 2;
    _scroll.jumpTo(next);
  }

  @override
  void dispose() {
    _ticker.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final looped = [...widget.items, ...widget.items];
    return Semantics(
      label: widget.items.join('. '),
      excludeSemantics: true,
      child: Listener(
        onPointerDown: (_) => _paused = true,
        onPointerUp: (_) => _paused = false,
        onPointerCancel: (_) => _paused = false,
        child: Container(
          height: 40,
          color: c.night,
          child: ListView.separated(
            controller: _scroll,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: MuSpacing.space4),
            itemCount: looped.length,
            separatorBuilder: (_, _) => const SizedBox(width: 28),
            itemBuilder: (_, i) => Row(
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: c.volt,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  looped[i],
                  style: mu.text.label.copyWith(color: c.onNight),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
