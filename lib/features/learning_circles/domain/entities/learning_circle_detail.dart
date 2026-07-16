import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/circle_user_ref.dart';

part 'learning_circle_detail.freezed.dart';

/// Full detail for one circle (`learningcircle/info/{id}/`) — pure-Dart
/// domain entity (rules.md §2).
@freezed
abstract class LearningCircleDetail with _$LearningCircleDetail {
  const factory LearningCircleDetail({
    required String id,
    required String ig,
    required String title,
    required String description,
    required CircleUserRef createdBy,
    String? org,
    bool? isRecurring,
    int? rank,
    int? totalKarma,
    int? totalMembers,
    bool? nextMeetupScheduled,
    String? nextMeetupTime,
  }) = _LearningCircleDetail;
}
