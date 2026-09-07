/// Parses the backend's raw level string (e.g. `"lvl6"`) into its number.
/// Shared by every place that needs just the number — [UserProfile.level]
/// is the single real source of the signed-in user's *current* level; the
/// level *name* (Initiate/Explorer/...) is separate, stable product copy
/// (DESIGN_SPEC.md §2 "06 — Level journey"), not derived from this string.
int parseLevelNumber(String? raw, {int fallback = 1}) {
  if (raw == null || raw.length <= 3) return fallback;
  return int.tryParse(raw.substring(3)) ?? fallback;
}
