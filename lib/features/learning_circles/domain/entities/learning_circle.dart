import 'package:freezed_annotation/freezed_annotation.dart';

part 'learning_circle.freezed.dart';

/// A row in the circle catalog (`learningcircle/list/`) — pure-Dart domain
/// entity (rules.md §2).
@freezed
abstract class LearningCircle with _$LearningCircle {
  const factory LearningCircle({
    required String id,
    required String ig,
    required String title,
    required int totalMembers,
    String? org,
  }) = _LearningCircle;
}
