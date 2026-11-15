import 'package:mulearn_app/features/projects/domain/entities/project.dart';

/// Projects (`api/dashboard/projects/`). Throws `ApiException` on failure.
abstract interface class ProjectsRepository {
  /// Published projects, newest first, a page at a time.
  Future<ProjectPage> feed({String search, int pageIndex});

  /// Everything [muid] made or is a member of; for their own muid that
  /// includes drafts and archived ones.
  Future<List<Project>> byMember(String muid);

  Future<Project> detail(String id);
  Future<Project> create(ProjectDraft draft);
  Future<Project> update(String id, ProjectDraft draft);
  Future<void> delete(String id);
  Future<void> setStatus(String id, ProjectStatus status);

  /// Adds a μLearn member by [muid], or someone outside by [externalName].
  Future<void> addMember(String projectId, {String? muid, String? externalName, String? role});
  Future<void> removeMember(String projectId, String memberId);

  Future<void> upvote(String projectId);
  Future<void> removeVote(String voteId);

  Future<void> comment(String projectId, String text);
  Future<void> deleteComment(String commentId);

  /// μLearn members matching [query] (name or muid), to add to a team.
  Future<List<ProjectMember>> findPeople(String query);

  /// The skills a project can be tagged with.
  Future<List<ProjectSkill>> skills();
}
