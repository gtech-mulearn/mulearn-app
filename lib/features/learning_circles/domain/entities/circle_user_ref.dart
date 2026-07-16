import 'package:freezed_annotation/freezed_annotation.dart';

part 'circle_user_ref.freezed.dart';

/// A minimal user reference embedded in circle/meeting responses (creator,
/// owner, invitee) — pure-Dart domain entity (rules.md §2).
@freezed
abstract class CircleUserRef with _$CircleUserRef {
  const factory CircleUserRef({
    required String fullName,
    String? id,
    String? muid,
    String? profilePicUrl,
  }) = _CircleUserRef;
}
