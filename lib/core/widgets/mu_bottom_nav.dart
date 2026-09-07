import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_shadow.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/utils/mu_haptics.dart';

class MuNavItem {
  const MuNavItem({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

/// Frosted-glass floating bottom navigation (rules.md §8, 2026-09 redesign)
/// — a translucent white pill (`BackdropFilter`), the active tab picked out
/// by a small blue indicator bar above its icon plus a darker icon color.
///
/// Also mirrors Apple's newer "liquid glass" tab bar interaction: dragging a
/// finger anywhere along the bar lets the highlight follow the touch point
/// continuously (rather than only snapping on a discrete tap), with a
/// selection-tick haptic each time the touch crosses into a new item's zone,
/// then commits (calls [onTap]) and snaps to the nearest item on release. A
/// plain tap still switches immediately, same as before.
///
/// Use with `Scaffold(extendBody: true)` so content scrolls behind it —
/// that's what the blur actually samples.
class MuBottomNav extends StatefulWidget {
  const MuBottomNav({
    required this.items,
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final List<MuNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  State<MuBottomNav> createState() => _MuBottomNavState();
}

class _MuBottomNavState extends State<MuBottomNav> {
  bool _dragging = false;
  double _dragContinuousIndex = 0;
  int _dragHoverIndex = 0;

  void _updateDrag(double localDx, double totalWidth) {
    final itemWidth = totalWidth / widget.items.length;
    final continuousIndex =
        ((localDx / itemWidth) - 0.5).clamp(0.0, widget.items.length - 1.0);
    final nearest = continuousIndex.round().clamp(0, widget.items.length - 1);
    if (nearest != _dragHoverIndex) {
      MuHaptics.selection();
    }
    setState(() {
      _dragging = true;
      _dragHoverIndex = nearest;
      _dragContinuousIndex = continuousIndex;
    });
  }

  void _commitDrag() {
    setState(() => _dragging = false);
    widget.onTap(_dragHoverIndex);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(MuRadius.tabBar),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              height: 72,
              decoration: BoxDecoration(
                color: MuColors.surface.withValues(alpha: 0.86),
                borderRadius: BorderRadius.circular(MuRadius.tabBar),
                boxShadow: MuShadow.nav,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final totalWidth = constraints.maxWidth;
                  final itemWidth = totalWidth / widget.items.length;
                  const indicatorWidth = 22.0;
                  final activeIndex = _dragging ? _dragHoverIndex : widget.currentIndex;

                  const indicator = _Indicator(width: indicatorWidth);
                  // Pixel offset, not Alignment(-1..1) — each icon is the
                  // center of its own Expanded slice of the Row, i.e. at
                  // (i+0.5)*itemWidth, not evenly spaced edge-to-edge across
                  // the full bar. Alignment's -1..1 space only matched that
                  // by coincidence for the exact middle item.
                  double leftFor(double continuousIndex) =>
                      (continuousIndex + 0.5) * itemWidth - indicatorWidth / 2;

                  final positionedIndicator = _dragging
                      ? Positioned(
                          left: leftFor(_dragContinuousIndex),
                          top: 0,
                          child: indicator,
                        )
                      : AnimatedPositioned(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOutCubic,
                          left: leftFor(activeIndex.toDouble()),
                          top: 0,
                          child: indicator,
                        );

                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTapUp: (details) {
                      final index = (details.localPosition.dx / itemWidth)
                          .floor()
                          .clamp(0, widget.items.length - 1);
                      MuHaptics.selection();
                      widget.onTap(index);
                    },
                    onHorizontalDragStart: (details) =>
                        _updateDrag(details.localPosition.dx, totalWidth),
                    onHorizontalDragUpdate: (details) =>
                        _updateDrag(details.localPosition.dx, totalWidth),
                    onHorizontalDragEnd: (_) => _commitDrag(),
                    onHorizontalDragCancel: () => setState(() => _dragging = false),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        positionedIndicator,
                        Row(
                          children: [
                            for (var i = 0; i < widget.items.length; i++)
                              Expanded(
                                child: IgnorePointer(
                                  child: Icon(
                                    widget.items[i].icon,
                                    size: 24,
                                    color: i == activeIndex
                                        ? MuColors.ink
                                        : MuColors.inkTertiary,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Small blue bar pinned to the top edge of the active tab, per the 2026-09
/// design's floating-nav treatment (indicator bar + darker icon, rather
/// than a highlight pill behind the icon).
class _Indicator extends StatelessWidget {
  const _Indicator({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        height: 3,
        width: width,
        decoration: BoxDecoration(
          color: MuColors.primary,
          borderRadius: BorderRadius.circular(MuRadius.chip),
        ),
      ),
    );
  }
}
