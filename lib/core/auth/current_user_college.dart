import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_paths.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_user_college.g.dart';

/// The signed-in user's own college — just `{id, code}`, not a full profile.
///
/// Lives in `core/` (rules.md §2) for the same reason [currentUserMuid]
/// does: "which college am I in" is needed by more than one feature (e.g.
/// `learning_circles` defaulting a new circle's college to the creator's
/// own, no picker) without any of them importing `features/profile`'s
/// domain layer. This is a thin, independent hit to the same real
/// `user-profile` endpoint `features/profile` also calls — mirroring the
/// dashboard/profile precedent of keeping separate minimal projections off
/// one endpoint rather than cross-importing it.
///
/// `id` is confirmed to be in the same id space `learningcircle/create/`'s
/// `org` field expects — it's set via the college-change flow's `org_id`,
/// which is itself sourced from `/api/v1/register/college/list/`, the same
/// namespace `learningcircle/create/` validates against (rules.md §3/§9).
@riverpod
Future<({String? id, String? code})> currentUserCollege(Ref ref) async {
  final response =
      await ref.watch(dioProvider).get<dynamic>(ApiPaths.userProfile);
  final json = ApiEnvelope.unwrapObject(response);
  return (
    id: json['college_id'] as String?,
    code: json['college_code'] as String?,
  );
}
