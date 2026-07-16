import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/auth/domain/entities/registration_role.dart';

part 'register_wizard_state.freezed.dart';

/// Accumulated data from registration steps 1 (basic info) and 2 (role
/// selection), held by [RegisterWizardController] so step 3's screen (a
/// separate route) can read it without re-collecting it. UI-only ephemeral
/// state — not a domain entity.
@freezed
abstract class RegisterWizardState with _$RegisterWizardState {
  const factory RegisterWizardState({
    String? fullName,
    String? email,
    String? password,
    RegistrationRole? role,
  }) = _RegisterWizardState;
}
