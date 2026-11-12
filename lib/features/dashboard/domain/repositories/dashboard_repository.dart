import 'package:mulearn_app/features/dashboard/domain/entities/featured_event.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/my_progress_summary.dart';

/// Home-dashboard repository contract (rules.md §2/§5). Throws
/// [ApiException] on failure.
abstract interface class DashboardRepository {

  /// `GET /api/v1/dashboard/events/featured/`.
  Future<List<FeaturedEvent>> getFeaturedEvents();

  /// Maps the shared `user-profile` payload (`myProfilePayloadProvider`).
  MyProgressSummary summaryFromPayload(Map<String, dynamic> payload);
}
