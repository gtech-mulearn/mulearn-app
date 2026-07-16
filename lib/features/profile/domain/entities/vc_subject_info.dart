import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/domain/entities/vc_credential_type.dart';

part 'vc_subject_info.freezed.dart';

/// Request payload identifying who a Verifiable Credential is issued to —
/// pure-Dart domain entity (rules.md §2). Modeled from the reference
/// dashboard's source (not live-tested end-to-end: this account has no
/// achievements to issue a credential for) — flagged per rules.md §3/§9.
@freezed
abstract class VcSubjectInfo with _$VcSubjectInfo {
  const factory VcSubjectInfo({
    required VcCredentialType type,
    required String did,
    required String name,
    String? email,
  }) = _VcSubjectInfo;
}
