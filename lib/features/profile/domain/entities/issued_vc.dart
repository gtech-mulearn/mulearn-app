import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/domain/entities/issued_vc_subject_info.dart';

part 'issued_vc.freezed.dart';

/// The result of a successful Verifiable Credential issuance — pure-Dart
/// domain entity (rules.md §2).
@freezed
abstract class IssuedVc with _$IssuedVc {
  const factory IssuedVc({
    required String message,
    required IssuedVcSubjectInfo subjectInfo,
  }) = _IssuedVc;
}
