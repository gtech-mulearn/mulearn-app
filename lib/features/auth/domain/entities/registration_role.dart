/// The role picked in registration step 2 — pure-Dart domain entity
/// (rules.md §2). Drives which fields step 3 asks for.
enum RegistrationRole { student, mentor, enabler, company }

/// The role's DB title, as listed by `GET /api/v1/register/role/list/` — role
/// UUIDs are resolved by a case-insensitive match against this title.
extension RegistrationRoleTitle on RegistrationRole {
  String get apiTitle => switch (this) {
        RegistrationRole.student => 'Student',
        RegistrationRole.mentor => 'Mentor',
        RegistrationRole.enabler => 'Enabler',
        RegistrationRole.company => 'Company',
      };
}
