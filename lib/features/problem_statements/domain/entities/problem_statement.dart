/// Where a learner stands with a statement (`ProblemStatementInteraction`).
enum PsStatus {
  /// "I'm trying it".
  trying,

  /// A solution link is in.
  submitted;

  static PsStatus? parse(Object? v) => switch ('${v ?? ''}'.toLowerCase()) {
    'trying' => trying,
    'submitted' => submitted,
    _ => null,
  };
}

/// A published problem statement (`ProblemStatementSerializer`): a real
/// problem from a company or μLearn that learners try and answer with a
/// link to their solution.
class ProblemStatement {
  /// A statement.
  const ProblemStatement({
    required this.id,
    required this.title,
    required this.description,
    required this.isOpen,
    required this.companyName,
    required this.trying,
    required this.submitted,
    this.category,
    this.skills = const [],
    this.deadline,
    this.companyLogo,
    this.myStatus,
    this.publishedAt,
  });

  final String id;
  final String title;

  /// Markdown, as the dashboard renders it.
  final String description;
  final String? category;
  final List<String> skills;

  /// Local time; null when there is none (open until unpublished).
  final DateTime? deadline;

  /// Published and before its deadline: new tries and submissions allowed.
  final bool isOpen;

  /// The company, or "muLearn" for statements μLearn posted.
  final String companyName;
  final String? companyLogo;
  final int trying;
  final int submitted;

  /// The caller's own status, or null when not participating.
  final PsStatus? myStatus;
  final DateTime? publishedAt;
}

/// The caller's own interaction (`GET <id>/interaction/`).
class MyPsParticipation {
  const MyPsParticipation({this.status, this.submissionUrl, this.submittedAt});

  /// Null when not participating.
  final PsStatus? status;
  final String? submissionUrl;
  final DateTime? submittedAt;
}

/// A page of statements.
typedef PsPage = ({List<ProblemStatement> items, bool hasNext, int totalPages});
