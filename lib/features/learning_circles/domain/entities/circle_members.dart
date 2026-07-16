import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/circle_member.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/circle_user_ref.dart';

part 'circle_members.freezed.dart';

/// Owner + members for a circle (`learningcircle/members/{id}/`).
@freezed
abstract class CircleMembers with _$CircleMembers {
  const factory CircleMembers({
    required List<CircleMember> members,
    CircleUserRef? owner,
  }) = _CircleMembers;
}
