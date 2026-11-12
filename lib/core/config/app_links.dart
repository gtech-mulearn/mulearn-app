/// Fixed links the app shows (spec §10, §11).
abstract final class AppLinks {
  const AppLinks._();

  /// Linked from mulearn.org (HTTP 200, 2026-11-12).
  static final Uri privacyPolicy = Uri.parse('https://mulearn.org/privacy-policy');
  static final Uri terms = Uri.parse('https://mulearn.org/terms-and-conditions');

  /// The support address published on mulearn.org.
  static const String supportEmail = 'info@mulearn.org';

  /// An email to support asking to delete the account [muid]. The backend's
  /// `DELETE /dashboard/profile/` hard-deletes with cascade, so the app (like
  /// the dashboard) sends deletion through support instead (spec §11).
  static Uri deletionRequest(String muid) => Uri(
        scheme: 'mailto',
        path: supportEmail,
        query: 'subject=${Uri.encodeComponent('Account deletion request')}'
            '&body=${Uri.encodeComponent('Please delete my μLearn account.\n\nμLearn ID: $muid\n\n'
                'I understand that deletion is permanent.')}',
      );
}
