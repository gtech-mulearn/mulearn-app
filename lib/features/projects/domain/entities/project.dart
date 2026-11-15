/// A project's visibility: drafts and archived ones only their owner sees.
enum ProjectStatus {
  draft('draft', 'Draft'),
  published('published', 'Published'),
  archived('archived', 'Archived');

  const ProjectStatus(this.wire, this.label);
  final String wire;
  final String label;

  static ProjectStatus parse(Object? v) =>
      values.firstWhere((s) => s.wire == '${v ?? ''}'.toLowerCase(), orElse: () => draft);
}

typedef ProjectLink = ({String label, String url});
typedef ProjectSkill = ({String id, String name});

/// Someone on the project: a μLearn member (with muid) or a named outsider.
class ProjectMember {
  const ProjectMember({required this.id, required this.name, this.muid, this.photoUrl, this.role});

  final String id;
  final String name;

  /// Set for μLearn members; their public profile opens from it.
  final String? muid;
  final String? photoUrl;
  final String? role;
}

class ProjectComment {
  const ProjectComment({
    required this.id,
    required this.text,
    required this.authorName,
    required this.authorId,
    required this.at,
  });

  final String id;
  final String text;
  final String authorName;
  final String? authorId;
  final DateTime at;
}

typedef ProjectVote = ({String id, bool up, String? userId});

/// A project (`ProjectSerializer`): what was built, by whom, with links,
/// skills, screenshots, upvotes and comments.
class Project {
  const Project({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.ownerName,
    required this.createdAt,
    this.ownerId,
    this.ownerMuid,
    this.logoUrl,
    this.images = const [],
    this.links = const [],
    this.skills = const [],
    this.members = const [],
    this.votes = const [],
    this.comments = const [],
  });

  final String id;
  final String title;

  /// Markdown, as written on the dashboard.
  final String description;
  final ProjectStatus status;
  final String ownerName;
  final String? ownerId;
  final String? ownerMuid;
  final DateTime createdAt;
  final String? logoUrl;
  final List<String> images;
  final List<ProjectLink> links;
  final List<ProjectSkill> skills;
  final List<ProjectMember> members;
  final List<ProjectVote> votes;

  /// Oldest first.
  final List<ProjectComment> comments;

  int get upvotes => votes.where((v) => v.up).length;

  /// The viewer's own upvote, to take it back.
  ProjectVote? upvoteBy(String? userId) =>
      userId == null ? null : votes.where((v) => v.up && v.userId == userId).firstOrNull;
}

/// What the create / edit form sends. Images replace the current ones when
/// any are picked (the backend swaps the whole set).
class ProjectDraft {
  const ProjectDraft({
    required this.title,
    required this.description,
    required this.status,
    required this.links,
    required this.skillIds,
    this.logo,
    this.images = const [],
  });

  final String title;
  final String description;
  final ProjectStatus status;
  final List<ProjectLink> links;
  final List<String> skillIds;
  final ({List<int> bytes, String name})? logo;
  final List<({List<int> bytes, String name})> images;
}

typedef ProjectPage = ({List<Project> items, bool hasNext});
