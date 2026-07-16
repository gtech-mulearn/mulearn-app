import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_details.freezed.dart';

/// Everything collected by the Company role's 4-step details form — pure-Dart
/// domain entity (rules.md §2). Sent to `POST /api/v1/dashboard/company/register/`
/// after the POC user account is created via [RegisterRepository.registerUser].
///
/// Only [companyName] and [companyDescription] are required; every other
/// field is optional and blank/unset values are omitted from the request
/// (mirrors the reference client stripping empty-string optionals).
@freezed
abstract class CompanyDetails with _$CompanyDetails {
  const factory CompanyDetails({
    required String companyName,
    required String companyDescription,
    String? logo,
    String? shortPitch,
    String? industrySector,
    String? companySize,
    String? websiteLink,
    String? email,
    String? linkedinUrl,
    String? location,
    String? countryId,
    String? stateId,
    String? districtId,
    String? legalName,
    String? registrationNumber,
    String? taxId,
    int? foundedYear,
    String? remotePolicy,
    String? cultureText,
  }) = _CompanyDetails;
}
