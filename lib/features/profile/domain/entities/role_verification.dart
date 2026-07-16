import 'package:freezed_annotation/freezed_annotation.dart';

part 'role_verification.freezed.dart';

/// Whether a given role assignment has been admin-verified — pure-Dart
/// domain entity (rules.md §2).
@freezed
abstract class RoleVerification with _$RoleVerification {
  const factory RoleVerification({
    required String role,
    required bool isVerified,
  }) = _RoleVerification;
}
