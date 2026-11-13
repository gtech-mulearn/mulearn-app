/// The dashboard's change-password rules (`ChangePasswordRequestSchema`,
/// `src/features/settings/schemas/settings.schema.ts`). The backend checks
/// only that the current password is right.
String? currentPasswordError(String current) => current.isEmpty ? 'Current password is required' : null;

String? newPasswordError({required String current, required String next}) {
  if (next.length < 8) return 'Password must be at least 8 characters';
  if (next == current) return 'The new password must be different from the current password.';
  return null;
}

String? confirmPasswordError({required String next, required String confirm}) {
  if (confirm.isEmpty) return 'Confirm password is required';
  if (confirm != next) return 'Passwords do not match';
  return null;
}

/// The first problem with a change-password form, or null when it's valid.
String? validateNewPassword({required String current, required String next, required String confirm}) =>
    currentPasswordError(current) ??
    newPasswordError(current: current, next: next) ??
    confirmPasswordError(next: next, confirm: confirm);
