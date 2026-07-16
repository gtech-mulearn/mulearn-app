import 'package:freezed_annotation/freezed_annotation.dart';

part 'circle_member.freezed.dart';

@freezed
abstract class CircleMember with _$CircleMember {
  const factory CircleMember({
    required String id,
    required String fullName,
    required String muid,
    String? profilePicUrl,
    int? igKarma,
    @Default(false) bool isLeader,
  }) = _CircleMember;
}
