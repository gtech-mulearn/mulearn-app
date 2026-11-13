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

  /// A student's karma entries, newest first.
  Future<({List<StudentActivity> items, bool hasNext})> getStudentActivity(String muid, {required int pageIndex});
}
