import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/domain/entities/level_task.dart';

part 'user_level.freezed.dart';

/// One level of the user's Mu-Voyage progression (e.g. "lvl1") — pure-Dart
/// domain entity (rules.md §2).
@freezed
abstract class UserLevel with _$UserLevel {
  const factory UserLevel({
    required String name,
    required num karma,
    @Default([]) List<LevelTask> tasks,
  }) = _UserLevel;
}
