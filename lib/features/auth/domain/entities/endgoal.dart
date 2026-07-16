/// An end goal, picked during interests onboarding (pure-Dart domain entity,
/// rules.md §2).
enum Endgoal {
  job,
  researchAndDevelopment,
  entrepreneurship,
  gigWork,
  higherEducation,
  socialImpact,
}

/// The exact wire value sent to `POST /api/v1/register/select-endgoals/` —
/// not derivable from the enum name (`researchAndDevelopment` → `"r&d"`,
/// snake_case for the rest), so mapped explicitly.
extension EndgoalApiValue on Endgoal {
  String get apiValue => switch (this) {
        Endgoal.job => 'job',
        Endgoal.researchAndDevelopment => 'r&d',
        Endgoal.entrepreneurship => 'entrepreneurship',
        Endgoal.gigWork => 'gig_work',
        Endgoal.higherEducation => 'higher_education',
        Endgoal.socialImpact => 'social_impact',
      };
}
