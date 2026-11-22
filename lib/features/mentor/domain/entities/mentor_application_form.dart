import 'package:mulearn_app/core/session/mentor_application.dart';

/// A pick in the form's lists: an IG, a company or a college.
typedef MentorChoice = ({String id, String name});

/// Weekly hours a mentor can give (`UserMentor.HoursCommitment`).
const mentorHoursChoices = ['0-1', '1-2', '2-5', '5-10', '10+'];

/// The most Interest Groups one application may name (`MAX_PREFERRED_IGS`).
const maxPreferredIgs = 5;

/// What the form sends to `POST/PATCH /dashboard/mentor/register/`, with the
/// dashboard's rules (`OnboardingFormSchema`) and the backend's
/// (`MentorRegisterSerializer`).
class MentorApplicationDraft {
  const MentorApplicationDraft({
    required this.tier,
    required this.about,
    required this.expertise,
    required this.reason,
    required this.preferredIgIds,
    this.organization,
    this.hours,
    this.linkedin = '',
  });

  final MentorTier tier;

  /// The company (Company Mentor) or college (Campus Mentor).
  final MentorChoice? organization;
  final String about;
  final List<String> expertise;
  final String reason;
  final List<String> preferredIgIds;
  final String? hours;
  final String linkedin;

  static const aboutMin = 50;
  static const aboutMax = 1000;
  static const reasonMin = 30;
  static const expertiseMin = 3;

  static final _linkedin = RegExp(
    r'^(https?://)?(www\.)?linkedin\.com/in/[\w\-.~:/?#\[\]@!$&()*+,;=]+/?$',
  );

  /// Field → what's wrong, in plain words. Empty when it can be sent.
  Map<MentorField, String> problems() => {
    if (tier.needsOrganization && organization == null)
      MentorField.organization: tier == MentorTier.campus
          ? 'Pick the college you will mentor at.'
          : 'Pick the company you mentor from.',
    if (about.trim().length < aboutMin)
      MentorField.about: 'Write at least $aboutMin characters about yourself.',
    if (about.trim().length > aboutMax)
      MentorField.about: 'Keep it under $aboutMax characters.',
    if (expertise.length < expertiseMin)
      MentorField.expertise: 'Add at least $expertiseMin areas of expertise.',
    if (reason.trim().length < reasonMin)
      MentorField.reason: 'Write at least $reasonMin characters on why.',
    if (preferredIgIds.isEmpty)
      MentorField.interestGroups: 'Pick at least one Interest Group.',
    if (preferredIgIds.length > maxPreferredIgs)
      MentorField.interestGroups: 'Pick at most $maxPreferredIgs.',
    if (linkedin.trim().isNotEmpty && !_linkedin.hasMatch(linkedin.trim()))
      MentorField.linkedin:
          'Use your profile link, like https://www.linkedin.com/in/you',
  };

  /// The body. A pending application's tier and organisation are fixed, so
  /// an edit ([applicationId]) leaves them out, as the dashboard does.
  Map<String, Object?> toBody({String? applicationId}) => {
    if (applicationId != null)
      'id': applicationId
    else ...{
      'mentor_tier': tier.value,
      if (organization != null) 'org': organization!.id,
    },
    'about': about.trim(),
    'expertise': expertise.join(', '),
    'reason': reason.trim(),
    'preferred_ig_ids': preferredIgIds,
    if (hours != null) 'hours': hours,
    if (linkedin.trim().isNotEmpty) 'linkedin': linkedin.trim(),
  };
}

enum MentorField {
  organization,
  about,
  expertise,
  reason,
  interestGroups,
  linkedin,
}

/// What the form can fill in from `GET /dashboard/mentor/profile/`: the
/// mentor's one profile (shared by all their applications) and each
/// application's own answers.
class MentorProfileSnapshot {
  const MentorProfileSnapshot({
    this.about = '',
    this.expertise = const [],
    this.hours,
    this.linkedin = '',
    this.applications = const [],
  });

  final String about;
  final List<String> expertise;
  final String? hours;
  final String linkedin;
  final List<MentorApplicationAnswers> applications;

  MentorApplicationAnswers? application(String? id) {
    for (final a in applications) {
      if (a.id == id) return a;
    }
    return null;
  }
}

class MentorApplicationAnswers {
  const MentorApplicationAnswers({
    required this.id,
    required this.tier,
    this.organization,
    this.reason = '',
    this.preferredIgIds = const [],
  });

  final String id;
  final MentorTier? tier;
  final MentorChoice? organization;
  final String reason;
  final List<String> preferredIgIds;
}
