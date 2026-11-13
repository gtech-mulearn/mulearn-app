import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/core/session/current_user.dart';
import 'package:mulearn_app/core/session/mentor_application.dart';
import 'package:mulearn_app/core/session/role_titles.dart';

part 'capabilities.freezed.dart';

/// What the signed-in user can do in the app — used only to shape the UI;
/// the backend still decides every request.
@freezed
abstract class Capabilities with _$Capabilities {
  const factory Capabilities({
    required bool isLearner,
    required bool isMentor,
    required bool isMentorApproved,
    required bool isEnabler,
    required bool isCampusLead,
    required bool isCompany,
    required bool needsDiscord,
  }) = _Capabilities;

  /// Roles from `/user/info/`; mentor approval from the user's mentor
  /// applications (the Mentor role link itself can stay unverified after
  /// approval). Who gets a role workspace is decided in
  /// `workspace_access.dart`, which also reads role verification.
  factory Capabilities.derive(CurrentUser user, List<MentorApplication> mentorApplications) {
    bool has(String title) => user.roles.contains(title);
    final isMentor = has(RoleTitles.mentor);
    final isEnabler = has(RoleTitles.enabler) || has(RoleTitles.leadEnabler);
    final isCampusLead = has(RoleTitles.campusLead) ||
        has(RoleTitles.zonalCampusLead) ||
        has(RoleTitles.districtCampusLead);
    return Capabilities(
      isLearner: has(RoleTitles.student),
      isMentor: isMentor,
      isMentorApproved: isMentor && mentorApplications.any((a) => a.status == 'APPROVED'),
      isEnabler: isEnabler,
      isCampusLead: isCampusLead,
      isCompany: has(RoleTitles.company),
      needsDiscord: !user.existInGuild,
    );
  }
}
