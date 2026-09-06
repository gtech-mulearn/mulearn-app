/// Corner-radius tokens (rules.md §8) — 2026-09 redesign (Phase 1 of the
/// Claude Design import).
abstract final class MuRadius {
  const MuRadius._();

  /// Standard content card — resume card, task list card, steps card, about
  /// card, journey level card, activity/distribution cards.
  static const double card = 24;

  /// Big hero cards — karma card, IG detail hero, current-level card.
  static const double hero = 30;

  /// Nested cards, inputs, list tiles.
  static const double inner = 18;

  /// Full pill — chips, buttons, badges, tab-bar items, avatars, progress
  /// bars.
  static const double chip = 99;

  /// QR code container.
  static const double qr = 14;

  /// Floating bottom tab-bar container.
  static const double tabBar = 28;
}
