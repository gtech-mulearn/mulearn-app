import 'package:dio/dio.dart';
import 'package:mulearn_app/core/auth/app_auth_controller.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/network/api_paths.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/utils/no_retry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

export 'package:mulearn_app/core/utils/no_retry.dart' show noRetry;

part 'my_profile_payload.g.dart';

/// The signed-in user's own `GET /dashboard/profile/user-profile/` object,
/// fetched once and shared: Profile, Home's progress summary, interest-group
/// membership and the user's college each map it with their own DTO.
///
/// Mutations that change the user's profile invalidate this provider, which
/// refreshes every reader at once. It watches the auth state, so signing out
/// discards it. Rejected when signed out (no reader runs then).
///
/// Neither this nor its readers is auto-retried ([noRetry]): a failure
/// surfaces at once so screens show their error state and Retry, which
/// invalidates this provider.
@Riverpod(keepAlive: true, retry: noRetry)
Future<Map<String, dynamic>> myProfilePayload(Ref ref) async {
  final dio = ref.watch(dioProvider);
  if (!await ref.watch(appAuthControllerProvider.future)) {
    throw const ApiException(message: 'Not signed in.', statusCode: 401);
  }
  try {
    return ApiEnvelope.unwrapObject(await dio.get<dynamic>(ApiPaths.userProfile));
  } on DioException catch (e) {
    throw ApiException.fromDioException(e);
  }
}
