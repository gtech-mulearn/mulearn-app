import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// Two or three equal views of the same data (Students / Colleges): a
/// `surface-sunk` pill track where the selected segment is a raised
/// `surface` pill that slides between positions.
class MuSegmented<T> extends StatelessWidget {
  /// A control over [values], showing [label] for each.
  const MuSegmented({
    required this.values,
    required this.selected,
    required this.label,
    required this.onChanged,
    super.key,
  }) : assert(
         values.length >= 2 && values.length <= 3,
         'segmented controls hold 2 or 3 options',
       );

  /// Options, in order.
  final List<T> values;

  /// The selected option.
  final T selected;

  /// Text for an option.
  final String Function(T) label;

  /// Called with the tapped option.
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final index = values.indexOf(selected).clamp(0, values.length - 1);
    final reduce = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    return Container(
      height: MuSizes.touchMin,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: c.surfaceSunk,
        borderRadius: BorderRadius.circular(MuRadii.round),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: reduce
                ? Duration.zero
                : const Duration(milliseconds: 320),
            curve: Curves.easeOutCubic,
            alignment: Alignment(
              values.length == 1 ? 0 : -1 + 2 * index / (values.length - 1),
              0,
            ),
            child: FractionallySizedBox(
              widthFactor: 1 / values.length,
              heightFactor: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: c.surface,
                  borderRadius: BorderRadius.circular(MuRadii.round),
                  boxShadow: [
                    BoxShadow(
                      color: c.ink.withValues(alpha: 0.12),
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              for (final v in values)
                Expanded(
                  child: Semantics(
                    container: true,
                    button: true,
                    selected: v == selected,
                    label: label(v),
                    excludeSemantics: true,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        if (v == selected) return;
                        HapticFeedback.selectionClick();
                        onChanged(v);
                      },
                      child: Center(
                        child: Text(
                          label(v),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: mu.text.label.copyWith(
                            fontSize: 14,
                            color: v == selected ? c.ink : c.ink2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
