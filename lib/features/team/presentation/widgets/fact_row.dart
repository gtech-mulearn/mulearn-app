import 'package:flutter/material.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';

/// One "label  value" line of a details card. The last one in a card passes
/// `last: true` to drop its hairline.
class FactRow extends StatelessWidget {
  const FactRow(this.label, this.value, {this.last = false, super.key});

  final String label;
  final String value;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: MuSpacing.space3),
      decoration: BoxDecoration(
        border: last ? null : Border(bottom: BorderSide(color: c.line)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 104,
            child: Text(label, style: mu.text.label.copyWith(color: c.ink3)),
          ),
          Expanded(
            child: Text(value, style: mu.text.body.copyWith(color: c.ink)),
          ),
        ],
      ),
    );
  }
}
