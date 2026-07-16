import 'package:freezed_annotation/freezed_annotation.dart';

part 'vc_credential_info.freezed.dart';

/// Request payload describing the credential content being issued —
/// pure-Dart domain entity (rules.md §2).
@freezed
abstract class VcCredentialInfo with _$VcCredentialInfo {
  const factory VcCredentialInfo({
    required String courseName,
    required String name,
    required String description,
    @Default([]) List<String> tags,
  }) = _VcCredentialInfo;
}
