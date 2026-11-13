import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:mulearn_app/core/design_system/motion/mu_spring.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// One tab of the [MuNavCapsule].
class MuNavItem {
  /// A tab root: icon and a short, specific label.
  const MuNavItem({required this.icon, required this.label});

  /// Glyph shown always.
  final IconData icon;

  /// Shown inside the pill when selected; always the semantics label.
  final String label;
}

/// The app's bottom navigation: an ink capsule floating above the home
/// indicator, where the selected tab grows into a paper pill with its label.
///
/// Drag across it to scrub between tabs (a selection click per tab); the
/// tab under the finger is chosen on release.
class MuNavCapsule extends StatefulWidget {
  /// Navigation for the tab roots.
  const MuNavCapsule({
    required this.items,
    required this.currentIndex,
    required this.onSelect,
    this.badges = const {},
    super.key,
  });

  /// The tab roots, in order (at most five).
  final List<MuNavItem> items;

  /// Selected tab.
  final int currentIndex;

  /// Called with the chosen tab (also when it's already selected: scroll to
  /// top / pop to root is the caller's job).
  final ValueChanged<int> onSelect;

  /// Tabs showing the volt "something to claim" dot.
  final Set<int> badges;

  @override
  State<MuNavCapsule> createState() => _MuNavCapsuleState();
}

class _MuNavCapsuleState extends State<MuNavCapsule> {
  int? _scrub;
  late List<GlobalKey> _tabKeys = _keys();

  List<GlobalKey> _keys() => List.generate(widget.items.length, (_) => GlobalKey());

  @override
  void didUpdateWidget(covariant MuNavCapsule old) {
    super.didUpdateWidget(old);
    if (old.items.length != widget.items.length) _tabKeys = _keys();
  }

  /// The tab whose bounds contain [global].dx (tabs differ in width).
  int? _indexAt(Offset global) {
    for (var i = 0; i < _tabKeys.length; i++) {
      final box = _tabKeys[i].currentContext?.findRenderObject() as RenderBox?;
      if (box == null) continue;
      final left = box.localToGlobal(Offset.zero).dx;
      if (global.dx >= left && global.dx < left + box.size.width) return i;
    }
    return null;
  }

  void _scrubTo(Offset global) {
    final i = _indexAt(global);
    if (i != null && i != _scrub) {
      HapticFeedback.selectionClick();
      setState(() => _scrub = i);
    }
  }

  /// Below this capsule width the selected pill shows its icon only.
  static const _labelWidth = 330.0;

  Widget _tab(int i, {required bool selected, required bool showLabel}) => _NavTab(
    key: _tabKeys[i],
    item: widget.items[i],
    selected: selected,
    showLabel: showLabel,
    badge: widget.badges.contains(i),
    onTap: () {
      HapticFeedback.selectionClick();
      widget.onSelect(i);
    },
  );

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final shown = _scrub ?? widget.currentIndex;
    final bottom = MediaQuery.paddingOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(MuSpacing.space3, 0, MuSpacing.space3, bottom + MuSpacing.space4),
      child: Center(
        heightFactor: 1,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: LayoutBuilder(
            builder: (context, constraints) => GestureDetector(
              onHorizontalDragStart: (d) => _scrubTo(d.globalPosition),
              onHorizontalDragUpdate: (d) => _scrubTo(d.globalPosition),
              onHorizontalDragEnd: (_) {
                final i = _scrub;
                setState(() => _scrub = null);
                if (i != null) widget.onSelect(i);
              },
              onHorizontalDragCancel: () => setState(() => _scrub = null),
              child: Container(
                height: MuSizes.navH,
                padding: const EdgeInsets.all(MuSpacing.space2),
                decoration: BoxDecoration(
                  color: c.night,
                  borderRadius: BorderRadius.circular(MuRadii.round),
                  boxShadow: mu.shadows.float,
                ),
                child: Row(
                  children: [
                    for (var i = 0; i < widget.items.length; i++)
                      if (i == shown)
                        _tab(i, selected: true, showLabel: constraints.maxWidth >= _labelWidth)
                      else
                        // Unselected tabs share what the pill leaves.
                        Expanded(child: _tab(i, selected: false, showLabel: false)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavTab extends StatefulWidget {
  const _NavTab({
    required this.item,
    required this.selected,
    required this.showLabel,
    required this.badge,
    required this.onTap,
    super.key,
  });

  final MuNavItem item;
  final bool selected;
  final bool showLabel;
  final bool badge;
  final VoidCallback onTap;

  @override
  State<_NavTab> createState() => _NavTabState();
}

class _NavTabState extends State<_NavTab> with SingleTickerProviderStateMixin {
  // 0 = collapsed icon, 1 = selected pill with label.
  late final AnimationController _t = AnimationController.unbounded(vsync: this, value: widget.selected ? 1 : 0);
  bool _reduceMotion = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _reduceMotion = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
  }

  @override
  void didUpdateWidget(covariant _NavTab old) {
    super.didUpdateWidget(old);
    if (old.selected == widget.selected) return;
    final target = widget.selected ? 1.0 : 0.0;
    if (_reduceMotion) {
      _t.value = target;
    } else {
      _t.animateWith(SpringSimulation(MuSprings.standard.description, _t.value, target, _t.velocity));
    }
  }

  @override
  void dispose() {
    _t.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    return Semantics(
      button: true,
      selected: widget.selected,
      label: widget.item.label,
      onTap: widget.onTap,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _t,
          builder: (context, _) {
            final t = _t.value.clamp(0.0, 1.0);
            final fg = Color.lerp(c.onNight2, c.ink, t)!;
            return Container(
              height: MuSizes.touchMin,
              constraints: widget.selected ? const BoxConstraints(minWidth: MuSizes.touchMin) : null,
              padding: widget.showLabel
                  ? EdgeInsetsDirectional.only(start: 13 * t, end: 18 * t)
                  : EdgeInsets.symmetric(horizontal: 13 * t),
              decoration: BoxDecoration(
                color: Color.lerp(c.surface.withValues(alpha: 0), c.surface, t),
                borderRadius: BorderRadius.circular(MuRadii.round),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(widget.item.icon, size: MuSizes.iconMd, color: fg),
                  if (widget.showLabel)
                    ClipRect(
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        widthFactor: _t.value.clamp(0.0, 1.2),
                        child: Opacity(
                          opacity: ((t - 0.5) * 2).clamp(0.0, 1.0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(start: MuSpacing.space2),
                            child: Text(
                              widget.item.label,
                              maxLines: 1,
                              style: mu.text.label.copyWith(color: c.ink, fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (widget.badge)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 2, bottom: 16),
                      child: Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(color: c.volt, shape: BoxShape.circle),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
