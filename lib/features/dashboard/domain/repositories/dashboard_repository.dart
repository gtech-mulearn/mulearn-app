import 'package:mulearn_app/features/dashboard/domain/entities/featured_event.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/learner_summary.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/my_progress_summary.dart';

/// Home-dashboard repository contract (rules.md §2/§5). Throws
/// [ApiException] on failure.
abstract interface class DashboardRepository {

  /// `GET /api/v1/dashboard/events/featured/`.
  Future<List<FeaturedEvent>> getFeaturedEvents();

  /// An approved mentor's upcoming sessions across their scopes, for the
  /// Home workspace card (the mentor feature has the full overview).
  Future<int> getMentorUpcomingCount();

  /// The campus code and its first headline number, for the Home campus
  /// card (the campus feature has the full overview).
  Future<({String code, String college, String? statLabel, num? statValue})> getCampusHeadline();

  /// The learner's week: weekly karma, streak, next circle meeting.
  Future<LearnerSummary> getLearnerSummary();

  /// Maps the shared `user-profile` payload (`myProfilePayloadProvider`).
  MyProgressSummary summaryFromPayload(Map<String, dynamic> payload);
}
