/// Corner-radius tokens (rules.md §8) — 2026-07 redesign.
abstract final class MuRadius {
  const MuRadius._();

  /// Primary cards — big, soft.
  static const double card = 28;

  /// Nested cards, inputs, list tiles.
  static const double inner = 18;

  /// Full pill — chips, buttons, nav.
  static const double chip = 100;

  /// QR code container.
  static const double qr = 14;
}
