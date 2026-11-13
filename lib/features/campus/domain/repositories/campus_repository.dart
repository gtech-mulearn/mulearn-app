import 'package:mulearn_app/features/campus/domain/entities/approvals.dart';
import 'package:mulearn_app/features/campus/domain/entities/campus_groups.dart';
import 'package:mulearn_app/features/campus/domain/entities/campus_student.dart';
import 'package:mulearn_app/features/campus/domain/entities/campus_summary.dart';
import 'package:mulearn_app/features/campus/domain/entities/student_activity.dart';

/// A page of campus students.
typedef StudentPage = ({List<CampusStudent> items, bool hasNext, int count});

/// The campus workspace (`api/dashboard/campus/`). Throws `ApiException`.
abstract interface class CampusRepository {
  Future<CampusSummary> getSummary();

  /// The last 7 days, oldest first.
  Future<List<KarmaDay>> getWeeklyKarma();

  /// `student-details/`; [sortBy] is the backend's key, `-` for descending.
  Future<StudentPage> getStudents({
    required int pageIndex,
    String search = '',
    String sortBy = '-karma',
    bool? alumni,
    int perPage = 20,
  });

  /// The campus's circles, most members first.
  Future<({List<CampusCircle> items, bool hasNext})> getCircles({required int pageIndex, String search = ''});

  /// Interest groups with the campus's member count, most members first.
  Future<({List<CampusIg> items, bool hasNext})> getIgs({required int pageIndex, String search = ''});

  /// Unverified college links at the campus (Campus Lead only).
  Future<List<OrgLinkRequest>> getOrgLinks();

  /// Verifies a link; returns the backend's message.
  Future<String> verifyOrgLink(String id);

  /// Campus events waiting for the campus's approval.
  Future<List<PendingCampusEvent>> getPendingEvents();

  Future<String> approveEvent(String id);

  /// A reason is required by the backend.
  Future<String> rejectEvent(String id, String reason);

  /// Pending collaboration invites for entities the caller leads.
  Future<List<CollabInvite>> getInvites();

  Future<String> acceptInvite(String eventId, String id);

  Future<String> rejectInvite(String eventId, String id, String reason);

  /// A student's karma entries, newest first.
  Future<({List<StudentActivity> items, bool hasNext})> getStudentActivity(String muid, {required int pageIndex});
}
