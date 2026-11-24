import 'package:mulearn_app/core/models/reference_option.dart';
import 'package:mulearn_app/core/utils/no_retry.dart';
import 'package:mulearn_app/core/utils/recent_results.dart';
import 'package:mulearn_app/features/team/presentation/providers/team_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'audience_options_providers.g.dart';

/// Every role. A role audience is matched by `title`, not id.
@Riverpod(retry: noRetry)
Future<List<ReferenceOption>> teamRoleOptions(Ref ref) =>
    ref.watch(teamRepositoryProvider).roles();

/// Every interest group (`title` is the group's name).
@Riverpod(retry: noRetry)
Future<List<ReferenceOption>> teamIgOptions(Ref ref) =>
    ref.watch(teamRepositoryProvider).interestGroups();

/// Colleges matching [query] (two letters or more), for a college audience.
/// Each query is kept a while, so retyping costs no request.
@Riverpod(retry: noRetry)
Future<List<ReferenceOption>> teamCollegeSearch(Ref ref, String query) async {
  if (query.trim().length < 2) return const [];
  ref.keepRecent();
  return ref.watch(teamRepositoryProvider).searchColleges(query.trim());
}
