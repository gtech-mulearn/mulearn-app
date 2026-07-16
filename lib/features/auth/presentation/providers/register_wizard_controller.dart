import 'package:mulearn_app/features/auth/domain/entities/registration_role.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_wizard_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_wizard_controller.g.dart';

/// Holds steps 1–2's data (basic info + role) across the separate screens
/// that make up the registration flow.
///
/// `keepAlive: true` because — unlike a single-screen form — this state must
/// survive navigating from the basic-info screen to the role-selection screen
/// to the role-details screen, each a separate route. [reset] is called once
/// the flow completes (or is abandoned back at sign-in).
@Riverpod(keepAlive: true)
class RegisterWizardController extends _$RegisterWizardController {
  @override
  RegisterWizardState build() => const RegisterWizardState();

  void setBasicInfo({
    required String fullName,
    required String email,
    required String password,
  }) {
    state = state.copyWith(fullName: fullName, email: email, password: password);
  }

  void setRole(RegistrationRole role) {
    state = state.copyWith(role: role);
  }

  void reset() => state = const RegisterWizardState();
}
