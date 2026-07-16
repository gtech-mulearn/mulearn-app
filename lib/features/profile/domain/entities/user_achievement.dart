import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/domain/entities/achievement.dart';

part 'user_achievement.freezed.dart';

/// A user's earned (or issuable) achievement instance — pure-Dart domain
/// entity (rules.md §2).
@freezed
abstract class UserAchievement with _$UserAchievement {
  const factory UserAchievement({
    required String id,
    required String userId,
    required Achievement achievement,
    required bool isIssued,
    String? vcUrl,
  }) = _UserAchievement;
}
