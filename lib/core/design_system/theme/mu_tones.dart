import 'package:flutter/painting.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// Interest Group categories, as the backend names them.
enum IgCategory {
  /// Web Development, DSA, Devops, AI…
  coder,

  /// IoT and Robotics, Blender, Space, Civil…
  maker,

  /// UI/UX, Comics, Creative Design…
  creative,

  /// Project Management, Human Resources, Strategic Leadership…
  manager,

  /// Anything else, and unknown.
  others;

  /// Parses the backend's `category` string; unknown or null is [others].
  static IgCategory parse(String? raw) => switch (raw?.trim().toLowerCase()) {
    'coder' => coder,
    'maker' => maker,
    'creative' => creative,
    'manager' => manager,
    _ => others,
  };
}

/// Colour decisions that depend on meaning, kept out of screens.
abstract final class MuTones {
  /// Sticker / tile fill for an IG category. Printed-matter colours: the
  /// same in both themes, always with `ink-print` text.
  static Color forIgCategory(MuPalette p, IgCategory category) => switch (category) {
    IgCategory.coder => p.igCoder,
    IgCategory.maker => p.igMaker,
    IgCategory.creative => p.igCreative,
    IgCategory.manager => p.igManager,
    IgCategory.others => p.igOthers,
  };

  /// A stable category for anything keyed by text (avatars without photos,
  /// IGs whose category the public API doesn't send). Same input, same
  /// colour, on every device.
  static IgCategory hashed(String key) {
    var h = 0;
    for (final unit in key.toLowerCase().codeUnits) {
      h = (h * 31 + unit) & 0x7fffffff;
    }
    return IgCategory.values[h % IgCategory.values.length];
  }
}
