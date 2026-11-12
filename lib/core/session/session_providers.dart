import 'package:dio/dio.dart';
import 'package:mulearn_app/core/auth/app_auth_controller.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/session/capabilities.dart';
import 'package:mulearn_app/core/session/current_user.dart';
import 'package:mulearn_app/core/session/current_user_dto.dart';
import 'package:mulearn_app/core/session/mentor_application.dart';
import 'package:mulearn_app/core/session/mentor_application_dto.dart';
import 'package:mulearn_app/core/session/role_titles.dart';
import 'package:mulearn_app/core/session/session_remote_datasource.dart';
import 'package:mulearn_app/core/utils/no_retry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_providers.g.dart';

// Every provider here is user-scoped and kept alive for the session. Each
// watches the auth state first, so signing out (or in as someone else)
// resets it — nothing from one account survives into the next. None is
// auto-retried ([noRetry]): a failure surfaces at once as an error.

@riverpod
SessionRemoteDataSource sessionRemoteDataSource(Ref ref) =>
    SessionRemoteDataSource(ref.watch(dioProvider));

/// The signed-in user (`/dashboard/user/info/`); `null` when signed out.
@Riverpod(keepAlive: true, retry: noRetry)
Future<CurrentUser?> currentUser(Ref ref) async {
  final datasource = ref.watch(sessionRemoteDataSourceProvider);
  if (!await ref.watch(appAuthControllerProvider.future)) return null;
  final json = await _guard(datasource.fetchUserInfo);
  return CurrentUserDto.fromJson(json).toDomain();
}

/// The user's mentor applications — fetched only for users with the Mentor
/// role (others get `[]` without a request).
@Riverpod(keepAlive: true, retry: noRetry)
Future<List<MentorApplication>> mentorApplications(Ref ref) async {
  final datasource = ref.watch(sessionRemoteDataSourceProvider);
  final user = await ref.watch(currentUserProvider.future);
  if (user == null || !user.roles.contains(RoleTitles.mentor)) return const [];
  final items = await _guard(datasource.fetchMentorApplications);
  return items
      .map((j) => MentorApplicationDto.fromJson(j as Map<String, dynamic>).toDomain())
      .toList();
}

/// What the signed-in user can do; `null` when signed out. A failure to
/// load either source is an error, never a silent downgrade.
@Riverpod(keepAlive: true, retry: noRetry)
Future<Capabilities?> capabilities(Ref ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user == null) return null;
  final applications = await ref.watch(mentorApplicationsProvider.future);
  return Capabilities.derive(user, applications);
}

Future<T> _guard<T>(Future<T> Function() action) async {
  try {
    return await action();
  } on DioException catch (e) {
    throw ApiException.fromDioException(e);
  }
}
