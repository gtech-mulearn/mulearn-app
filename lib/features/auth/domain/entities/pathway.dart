/// A learning pathway category, picked during interests onboarding
/// (pure-Dart domain entity, rules.md §2).
///
/// Enum member names match the backend's wire values exactly (`.name` is the
/// value sent to `POST /api/v1/register/select-domains/`), so no separate
/// mapping is needed.
enum Pathway { coder, maker, manager, creative }
