import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';

/// Labeled value block (rules.md §8) — e.g. "KARMA" / "1,204". Grid these
/// 2-up inside cards. Pass a pre-styled [valueStyle] (usually
/// `MuType.stat`) so callers can choose Space Grotesk vs. a smaller variant.
class MuStatBlock extends StatelessWidget {
  const MuStatBlock({
    required this.label,
    required this.value,
    super.key,
    this.valueStyle,
    this.valueColor,
  });

  final String label;
  final String value;
  final TextStyle? valueStyle;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label.toUpperCase(), style: MuType.label),
        const SizedBox(height: 4),
        Text(
          value,
          style: (valueStyle ?? MuType.stat).copyWith(color: valueColor),
        ),
      ],
    );
  }
}
