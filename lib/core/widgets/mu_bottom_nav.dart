import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mulearn_app/core/theme/mu_shadow.dart';

class MuNavItem {
  const MuNavItem({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

/// Dark frosted-glass floating bottom navigation (rules.md §8) — a strongly
/// blurred, near-black pill (`BackdropFilter`), mirroring the "X/Instagram"
/// dark tab-bar style: white icons throughout, the active one picked out by
/// a soft translucent rounded-rect highlight (not a solid circle) that
/// slides between items.
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
  double _dragAlignmentX = 0;
  int _dragHoverIndex = 0;

  double _alignmentXFor(int index) => widget.items.length == 1
      ? 0
      : -1 + (2 * index / (widget.items.length - 1));

  void _updateDrag(double localDx, double totalWidth) {
    final itemWidth = totalWidth / widget.items.length;
    final continuousIndex =
        ((localDx / itemWidth) - 0.5).clamp(0, widget.items.length - 1.0);
    final nearest = continuousIndex.round().clamp(0, widget.items.length - 1);
    if (nearest != _dragHoverIndex) {
      HapticFeedback.selectionClick();
    }
    setState(() {
      _dragging = true;
      _dragHoverIndex = nearest;
      _dragAlignmentX = widget.items.length == 1
          ? 0
          : -1 + (2 * continuousIndex / (widget.items.length - 1));
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
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 46, sigmaY: 46),
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.38),
                    Colors.black.withValues(alpha: 0.28),
                  ],
                ),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
                boxShadow: MuShadow.nav,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final totalWidth = constraints.maxWidth;
                  final itemWidth = totalWidth / widget.items.length;
                  const indicatorWidth = 46.0;
                  final activeIndex = _dragging ? _dragHoverIndex : widget.currentIndex;

                  final indicator = _Indicator(
                    width: indicatorWidth,
                    margin: (itemWidth - indicatorWidth) / 2,
                  );
                  final positionedIndicator = _dragging
                      ? Align(
                          alignment: Alignment(_dragAlignmentX, 0),
                          child: indicator,
                        )
                      : AnimatedAlign(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOutCubic,
                          alignment: Alignment(_alignmentXFor(activeIndex), 0),
                          child: indicator,
                        );

                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTapUp: (details) {
                      final index = (details.localPosition.dx / itemWidth)
                          .floor()
                          .clamp(0, widget.items.length - 1);
                      HapticFeedback.selectionClick();
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
                                        ? Colors.white
                                        : Colors.white.withValues(alpha: 0.6),
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

class _Indicator extends StatelessWidget {
  const _Indicator({required this.width, required this.margin});

  final double width;
  final double margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      width: width,
      margin: EdgeInsets.symmetric(horizontal: margin),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(13),
      ),
    );
  }
}
