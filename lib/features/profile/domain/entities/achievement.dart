import 'package:freezed_annotation/freezed_annotation.dart';

part 'achievement.freezed.dart';

/// An achievement definition (the template, not a user's earned instance) —
/// pure-Dart domain entity (rules.md §2).
@freezed
abstract class Achievement with _$Achievement {
  const factory Achievement({
    required String id,
    required String achievementName,
    String? description,
    String? icon,
    String? levelId,
    @Default([]) List<String> tags,
    String? templateId,
  }) = _Achievement;
}
