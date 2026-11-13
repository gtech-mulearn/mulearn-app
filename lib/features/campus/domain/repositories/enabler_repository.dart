import 'package:mulearn_app/features/campus/domain/entities/enabler.dart';

/// The enabler's campuses (`api/dashboard/enabler/`). Throws `ApiException`.
abstract interface class EnablerRepository {
  Future<EnablerSummary> getSummary();

  Future<List<EnablerCampus>> getCampuses();

  Future<EnablerCampus> getCampus(String id);

  /// Newest first (first 50).
  Future<List<CampusNote>> getNotes(String campusId);

  /// Returns the backend's message; the new note is not returned.
  Future<String> addNote(String campusId, {required String note, required String priority, DateTime? followUp});
}
