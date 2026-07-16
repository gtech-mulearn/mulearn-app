import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';

/// Brand gradients. The trusty gradient is the 135° `#2E85FE → #AF2EE6`
/// from the landing page (rules.md §8).
abstract final class MulearnGradients {
  const MulearnGradients._();

  /// 135° top-left → bottom-right, matching the CSS `linear-gradient(135deg, …)`.
  static const LinearGradient trusty = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [MulearnColors.trustyBlue, MulearnColors.dukePurple],
  );
}
