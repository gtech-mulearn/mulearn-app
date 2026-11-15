import 'package:mulearn_app/features/campus_profile/domain/entities/public_campus.dart';

/// A college's public page. Throws [ApiException] on failure ("College not
/// found" for an id that isn't a college).
abstract interface class CampusProfileRepository {
  /// `GET campus/<org_id>/`.
  Future<PublicCampus> campus(String id);

  /// `GET campus/weekly-karma/<org_id>/`: the last seven days, oldest first.
  Future<List<CampusKarmaDay>> weeklyKarma(String id);
}
