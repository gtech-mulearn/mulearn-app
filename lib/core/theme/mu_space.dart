/// Spacing tokens on a 4pt grid (rules.md §8) — 2026-07 redesign.
abstract final class MuSpace {
  const MuSpace._();

  static const double xs = 4;
  static const double s = 8;
  static const double m = 12;
  static const double l = 16;
  static const double xl = 20;
  static const double xxl = 28;

  /// Horizontal screen padding, everywhere.
  static const double screenH = 20;

  /// Bottom clearance for scrollable content on the 4 tab-root screens
  /// (Home/Circles/Leaderboard/Profile) — big enough to clear
  /// `MuBottomNav`'s floating glass pill (64 tall + its own margin) so the
  /// last item isn't hidden behind it. Only needed where the bottom nav is
  /// actually visible, not on pushed sub-screens.
  static const double navClearance = 100;
}
