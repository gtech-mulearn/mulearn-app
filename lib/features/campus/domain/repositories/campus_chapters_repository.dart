import 'package:mulearn_app/features/campus/domain/entities/campus_chapter.dart';

/// The campus's IG chapters (`campus/ig-chapters/`). Reading is open to
/// campus staff; creating, editing and removing are for the Campus Lead and
/// Lead Enabler. Throws `ApiException`.
abstract interface class CampusChaptersRepository {
  /// Every chapter at the caller's campus, active and inactive.
  Future<List<CampusChapter>> chapters();

  /// Starts a chapter for [igId]; the lead is optional (by muid).
  Future<String> create({
    required String igId,
    String? description,
    String? leadMuid,
  });

  /// Updates a chapter. [leadMuid] is sent only when the lead changes.
  Future<String> update(
    String id, {
    required String description,
    required bool isActive,
    String? leadMuid,
  });

  /// Removes a chapter (the backend deactivates it and drops its lead role).
  Future<String> remove(String id);

  /// Active campus members matching [query], to pick a lead.
  Future<List<CampusMember>> searchMembers(String query);

  /// μLearn's interest groups, to start a chapter for.
  Future<List<ChapterIgOption>> interestGroups();
}
