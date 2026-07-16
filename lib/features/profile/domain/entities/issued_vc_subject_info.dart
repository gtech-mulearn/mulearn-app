import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/domain/entities/vc_credential_type.dart';

part 'issued_vc_subject_info.freezed.dart';

/// The issued-credential details returned after a successful VC issuance —
/// pure-Dart domain entity (rules.md §2). Modeled from the reference
/// dashboard's source (rules.md §3/§9 — not live-tested, see
/// [VcSubjectInfo]'s doc comment).
@freezed
abstract class IssuedVcSubjectInfo with _$IssuedVcSubjectInfo {
  const factory IssuedVcSubjectInfo({
    required String courseName,
    required String credentialId,
    required VcCredentialType credentialType,
    required String did,
    required String fullName,
    required String s3Url,
    required String templateId,
    required VcCredentialType type,
    String? completedDate,
    String? description,
    String? email,
  }) = _IssuedVcSubjectInfo;
}
