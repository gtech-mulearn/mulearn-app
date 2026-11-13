/// The role picked in registration step 2 — pure-Dart domain entity
/// (rules.md §2). Drives which fields step 3 asks for. Company accounts are
/// not created in the app: they need a verification document upload
/// (CompanyRegisterSerializer), so company POCs use the web dashboard.
enum RegistrationRole { student, mentor, enabler }

/// The role's DB title, as listed by `GET /api/v1/register/role/list/` — role
/// UUIDs are resolved by a case-insensitive match against this title.
extension RegistrationRoleTitle on RegistrationRole {
  String get apiTitle => switch (this) {
        RegistrationRole.student => 'Student',
        RegistrationRole.mentor => 'Mentor',
        RegistrationRole.enabler => 'Enabler',
      };
}
