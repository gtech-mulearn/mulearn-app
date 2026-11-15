import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/motion/mu_pressable.dart';
import 'package:mulearn_app/core/design_system/motion/mu_spring.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// Selection controls (artifact SelectionControls): checkbox (a square
/// stamp), radio, switch, plus the radio card for big choices and the
/// checklist. Every one is hit-tested over its whole row, at least 48 tall.

/// A 22dp square check: `cobalt` with a white tick when on, an `ink-3`
/// outline when off.
class MuCheckbox extends StatelessWidget {
  /// A checkbox mark (no label; put it in a row).
  const MuCheckbox({required this.value, super.key});

  final bool value;

  @override
  Widget build(BuildContext context) {
    final c = context.mu.colors;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: value ? c.cobalt : null,
        borderRadius: BorderRadius.circular(MuRadii.tag),
        border: value ? null : Border.all(color: c.ink3, width: 1.5),
      ),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 160),
        opacity: value ? 1 : 0,
        child: Icon(LucideIcons.check, size: 14, color: c.onCobalt),
      ),
    );
  }
}

/// A 22dp radio: selected is a 7dp cobalt ring.
class MuRadioMark extends StatelessWidget {
  /// A radio mark (no label).
  const MuRadioMark({required this.selected, super.key});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    final c = context.mu.colors;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: selected ? c.cobalt : c.ink3, width: selected ? 7 : 1.5),
      ),
    );
  }
}

/// A row with a checkbox and a label; the whole row toggles.
class MuCheckboxTile extends StatelessWidget {
  /// A labelled checkbox.
  const MuCheckboxTile({required this.label, required this.value, required this.onChanged, this.subtitle, super.key});

  final String label;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    return _Row(
      semantics: (label, checked: value, toggled: null),
      onTap: onChanged == null ? null : () => onChanged!(!value),
      leading: MuCheckbox(value: value),
      title: label,
      subtitle: subtitle,
      titleStyle: mu.text.bodyStrong,
    );
  }
}

/// A 52×32 switch: `night` track with a `volt` knob when on, `surface-sunk`
/// with an `ink-3` knob when off. The knob springs across; settings it
/// controls apply at once, never behind a Save button.
class MuSwitch extends StatefulWidget {
  /// A switch.
  const MuSwitch({required this.value, required this.onChanged, super.key});

  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  State<MuSwitch> createState() => _MuSwitchState();
}

class _MuSwitchState extends State<MuSwitch> with SingleTickerProviderStateMixin {
  late final AnimationController _t = AnimationController.unbounded(vsync: this, value: widget.value ? 1 : 0);

  @override
  void didUpdateWidget(MuSwitch old) {
    super.didUpdateWidget(old);
    if (old.value == widget.value) return;
    final target = widget.value ? 1.0 : 0.0;
    if (MediaQuery.maybeDisableAnimationsOf(context) ?? false) {
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
    final c = context.mu.colors;
    return AnimatedBuilder(
      animation: _t,
      builder: (context, _) {
        final t = _t.value.clamp(0.0, 1.0);
        return Container(
          width: 52,
          height: 32,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Color.lerp(c.surfaceSunk, c.night, t),
            borderRadius: BorderRadius.circular(MuRadii.round),
            border: Border.all(color: c.lineStrong.withValues(alpha: 1 - t), width: 1.5),
          ),
          child: Align(
            alignment: Alignment(-1 + 2 * _t.value, 0),
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(color: Color.lerp(c.ink3, c.volt, t), shape: BoxShape.circle),
            ),
          ),
        );
      },
    );
  }
}

/// A settings row with a switch; the whole row toggles.
class MuSwitchTile extends StatelessWidget {
  /// A labelled switch.
  const MuSwitchTile({required this.label, required this.value, required this.onChanged, this.subtitle, super.key});

  final String label;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    return _Row(
      semantics: (label, checked: null, toggled: value),
      onTap: onChanged == null
          ? null
          : () {
              HapticFeedback.selectionClick();
              onChanged!(!value);
            },
      trailing: MuSwitch(value: value, onChanged: onChanged),
      title: label,
      subtitle: subtitle,
      titleStyle: mu.text.bodyStrong,
    );
  }
}

/// A full-width choice card (sign-up roles: Student, Mentor, Enabler…): a
/// `surface` card with an icon well, title and line, a radio at the end;
/// selected gets a 2px cobalt ring and a `cobalt-tint` well.
class MuRadioCard<T> extends StatelessWidget {
  /// A radio card for [value] within a group whose choice is [groupValue].
  const MuRadioCard({
    required this.value,
    required this.groupValue,
    required this.title,
    required this.onChanged,
    this.subtitle,
    this.icon,
    super.key,
  });

  final T value;
  final T? groupValue;
  final String title;
  final String? subtitle;
  final IconData? icon;
  final ValueChanged<T>? onChanged;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final on = value == groupValue;
    return Semantics(
      inMutuallyExclusiveGroup: true,
      checked: on,
      button: true,
      label: [title, ?subtitle].join(', '),
      excludeSemantics: true,
      onTap: onChanged == null ? null : () => onChanged!(value),
      child: MuPressable(
        onTap: onChanged == null ? null : () => onChanged!(value),
        pressedScale: 0.98,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.all(MuSpacing.space4),
          decoration: BoxDecoration(
            color: c.surface,
            borderRadius: BorderRadius.circular(MuRadii.card),
            border: Border.all(color: on ? c.cobalt : c.line, width: on ? 2 : 1),
          ),
          child: Row(
            children: [
              if (icon != null) ...[
                AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(color: on ? c.cobaltTint : c.surfaceSunk, shape: BoxShape.circle),
                  child: Icon(icon, size: MuSizes.iconMd, color: on ? c.cobaltText : c.ink2),
                ),
                const SizedBox(width: MuSpacing.space3),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: mu.text.title3),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(subtitle!, style: mu.text.body.copyWith(fontSize: 14, color: c.ink2)),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: MuSpacing.space3),
              MuRadioMark(selected: on),
            ],
          ),
        ),
      ),
    );
  }
}

/// One step of a [MuChecklist].
class MuChecklistItem {
  /// A step.
  const MuChecklistItem(this.label, {this.done = false});

  final String label;
  final bool done;
}

/// Steps with checkboxes; done steps strike through in `ink-3`. Rows are
/// divided by hairlines. [onToggle] null makes it read-only.
class MuChecklist extends StatelessWidget {
  /// A checklist.
  const MuChecklist({required this.items, this.onToggle, super.key});

  final List<MuChecklistItem> items;
  final ValueChanged<int>? onToggle;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    return Column(
      children: [
        for (var i = 0; i < items.length; i++)
          DecoratedBox(
            decoration: BoxDecoration(
              border: i == items.length - 1 ? null : Border(bottom: BorderSide(color: c.line)),
            ),
            child: _Row(
              semantics: (items[i].label, checked: items[i].done, toggled: null),
              onTap: onToggle == null ? null : () => onToggle!(i),
              leading: MuCheckbox(value: items[i].done),
              title: items[i].label,
              titleStyle: mu.text.body.copyWith(
                fontWeight: FontWeight.w500,
                color: items[i].done ? c.ink3 : c.ink,
                decoration: items[i].done ? TextDecoration.lineThrough : null,
                decorationColor: c.ink3,
              ),
            ),
          ),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.semantics,
    required this.onTap,
    required this.title,
    required this.titleStyle,
    this.leading,
    this.trailing,
    this.subtitle,
  });

  final (String, {bool? checked, bool? toggled}) semantics;
  final VoidCallback? onTap;
  final String title;
  final String? subtitle;
  final TextStyle titleStyle;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    return Semantics(
      container: true,
      label: semantics.$1,
      checked: semantics.checked,
      toggled: semantics.toggled,
      enabled: onTap != null,
      excludeSemantics: true,
      onTap: onTap,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: MuSizes.touchMin),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: MuSpacing.space3),
            child: Row(
              children: [
                if (leading != null) ...[leading!, const SizedBox(width: MuSpacing.space3)],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: titleStyle),
                      if (subtitle != null) ...[const SizedBox(height: 2), Text(subtitle!, style: mu.text.caption)],
                    ],
                  ),
                ),
                if (trailing != null) ...[const SizedBox(width: MuSpacing.space3), trailing!],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
