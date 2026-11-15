import 'dart:math' as math;

import 'package:flutter/physics.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// A spring from Apple's two designer parameters: [damping] ratio (1 = no
/// overshoot, lower = bouncier) and [response] in seconds (lower = snappier).
SpringDescription muSpring(double damping, double response) {
  final stiffness = math.pow(2 * math.pi / response, 2).toDouble();
  return SpringDescription.withDampingRatio(
    mass: 1,
    stiffness: stiffness,
    ratio: damping,
  );
}

/// Where a flick released at [velocity] (px/s) comes to rest, relative to
/// the release point, with scroll-like deceleration. Choose snap targets from
/// `current + project(velocity)`, not from the release position.
double project(double velocity, {double decelerationRate = 0.998}) =>
    velocity / 1000 * decelerationRate / (1 - decelerationRate);

/// Progressive resistance past a boundary: how far the element follows an
/// [overshoot] of the finger, given the scroll/drag [dimension].
double rubberband(
  double overshoot,
  double dimension, {
  double constant = 0.55,
}) =>
    (overshoot * dimension * constant) /
    (dimension + constant * overshoot.abs());

/// Springs from the token set.
extension MuSpringSpecDescription on MuSpringSpec {
  /// This spec as a physics [SpringDescription].
  SpringDescription get description => muSpring(damping, response);
}
