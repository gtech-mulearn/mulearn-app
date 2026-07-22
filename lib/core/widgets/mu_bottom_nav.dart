import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mulearn_app/core/theme/mu_shadow.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';

class MuNavItem {
  const MuNavItem({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

/// Apple-style frosted-glass floating bottom navigation (rules.md §8) — a
/// strongly blurred, mostly-transparent light pill (`BackdropFilter`),
/// mirroring iOS's actual `.systemMaterial` tab-bar glass (light, not a
/// tinted-black panel) with dark content-color icons on top, a bright glass-
/// edge border, and a subtle inner highlight. The active item is a sliding
/// frosted-white capsule with its own soft shadow for depth. Use with
/// `Scaffold(extendBody: true)` so content scrolls behind it — that's what
/// the blur actually samples.
class MuBottomNav extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 32, sigmaY: 32),
            child: Container(
              height: 64,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withValues(alpha: 0.45),
                    Colors.white.withValues(alpha: 0.28),
                  ],
                ),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Colors.white.withValues(alpha: 0.65)),
                boxShadow: MuShadow.nav,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final itemWidth = constraints.maxWidth / items.length;
                  return Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      AnimatedAlign(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOutCubic,
                        alignment: Alignment(
                          items.length == 1
                              ? 0
                              : -1 + (2 * currentIndex / (items.length - 1)),
                          0,
                        ),
                        child: Container(
                          height: 48,
                          width: 48,
                          margin: EdgeInsets.symmetric(
                            horizontal: (itemWidth - 48) / 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.85),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white.withValues(alpha: 0.9)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          for (var i = 0; i < items.length; i++)
                            Expanded(
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  HapticFeedback.selectionClick();
                                  onTap(i);
                                },
                                child: Icon(
                                  items[i].icon,
                                  size: 22,
                                  color: i == currentIndex
                                      ? MuColors.primary
                                      : MuColors.inkSecondary,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
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
