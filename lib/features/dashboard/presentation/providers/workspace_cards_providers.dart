import 'package:mulearn_app/core/utils/no_retry.dart';
import 'package:mulearn_app/features/dashboard/presentation/providers/dashboard_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'workspace_cards_providers.g.dart';

/// Upcoming sessions for the Home mentor card; watched only when the mentor
/// workspace is open, so other users make no call.
@Riverpod(retry: noRetry)
Future<int> mentorUpcomingCount(Ref ref) => ref.watch(dashboardRepositoryProvider).getMentorUpcomingCount();

/// The Home campus card's line; watched only when the campus workspace is
/// open.
@Riverpod(retry: noRetry)
Future<({String code, String college, String? statLabel, num? statValue})> campusHeadline(Ref ref) =>
    ref.watch(dashboardRepositoryProvider).getCampusHeadline();
