/// Fixed links the app shows (spec §10, §11).
abstract final class AppLinks {
  const AppLinks._();

  /// Linked from mulearn.org (HTTP 200, 2026-11-12).
  static final Uri privacyPolicy = Uri.parse(
    'https://mulearn.org/privacy-policy',
  );
  static final Uri terms = Uri.parse(
    'https://mulearn.org/terms-and-conditions',
  );

  /// The support address published on mulearn.org.
  static const String supportEmail = 'info@mulearn.org';

  /// An email to support asking to delete the account [muid]. The backend's
  /// `DELETE /dashboard/profile/` hard-deletes with cascade, so the app (like
  /// the dashboard) sends deletion through support instead (spec §11).
  static Uri deletionRequest(String muid) => Uri(
    scheme: 'mailto',
    path: supportEmail,
    query:
        'subject=${Uri.encodeComponent('Account deletion request')}'
        '&body=${Uri.encodeComponent('Please delete my μLearn account.\n\nμLearn ID: $muid\n\n'
        'I understand that deletion is permanent.')}',
  );

  /// An email to support reporting [kind] content ([contentId]) by [author].
  /// There is no report endpoint, so the report goes to the support inbox.
  static Uri contentReport({
    required String kind,
    required String reason,
    String? contentId,
    String? contentTitle,
    String? author,
    String? note,
  }) => Uri(
    scheme: 'mailto',
    path: supportEmail,
    query:
        'subject=${Uri.encodeComponent('Report: $kind')}'
        '&body=${Uri.encodeComponent(['Reason: $reason', if (contentTitle != null && contentTitle.isNotEmpty) 'About: $contentTitle', if (contentId != null && contentId.isNotEmpty) 'Reference: $contentId', if (author != null && author.isNotEmpty) 'Posted by: $author', if (note != null && note.trim().isNotEmpty) 'Note: ${note.trim()}', '', 'Sent from the μLearn app.'].join('\n'))}',
  );
}
