import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/domain/entities/org_ref.dart';

part 'user_preferences.freezed.dart';

/// The user's preferences — pure-Dart domain entity (rules.md §2). Confirmed
/// against a real `GET /api/v1/dashboard/user/preferences/` response;
/// `domains`/`endgoals`/`orgs` are absent (not just empty) for accounts that
/// haven't set them, hence nullable rather than defaulted.
@freezed
abstract class UserPreferences with _$UserPreferences {
  const factory UserPreferences({
    required bool interestedInWork,
    required bool interestedInGigWork,
    List<String>? domains,
    List<String>? endgoals,
    List<OrgRef>? orgs,
  }) = _UserPreferences;
}
