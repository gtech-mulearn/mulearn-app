import 'package:mulearn_app/features/dashboard/domain/entities/featured_event.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/karma_feed.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/my_progress_summary.dart';

/// Home-dashboard repository contract (rules.md §2/§5). Throws
/// [ApiException] on failure.
abstract interface class DashboardRepository {
  /// `GET /api/v1/dashboard/profile/karma-feed/`.
  Future<KarmaFeed> getKarmaFeed();

  /// `GET /api/v1/dashboard/events/featured/`.
  Future<List<FeaturedEvent>> getFeaturedEvents();

  /// `GET /api/v1/dashboard/profile/user-profile/`, projected down to just
  /// the fields the home summary card needs.
  Future<MyProgressSummary> getMyProgressSummary();
}
