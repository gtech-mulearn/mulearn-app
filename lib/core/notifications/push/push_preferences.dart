/// The user's push settings, as the backend stores them
/// (`/api/v1/push/preferences/`).
class PushPreferences {
  const PushPreferences({
    this.pushEnabled = true,
    this.engagementEnabled = true,
    this.mutedCategories = const [],
    this.quietStart = 22,
    this.quietEnd = 8,
    this.timezone = 'Asia/Kolkata',
  });

  factory PushPreferences.fromJson(Map<String, dynamic> json) {
    int hour(Object? v, int fallback) =>
        v is int && v >= 0 && v <= 23 ? v : fallback;
    final muted = json['muted_categories'];
    return PushPreferences(
      pushEnabled: json['push_enabled'] != false,
      engagementEnabled: json['engagement_enabled'] != false,
      mutedCategories: [
        if (muted is List)
          for (final c in muted)
            if (c is String) c,
      ],
      quietStart: hour(json['quiet_start'], 22),
      quietEnd: hour(json['quiet_end'], 8),
      timezone: json['timezone'] is String
          ? json['timezone'] as String
          : 'Asia/Kolkata',
    );
  }

  /// Pushes at all (activity, nudges and announcements).
  final bool pushEnabled;

  /// Nudges: reminders to keep a streak or come back.
  final bool engagementEnabled;

  /// Notification categories the user muted (backend `Category` values).
  final List<String> mutedCategories;

  /// Local hours with no pushes: from [quietStart] to [quietEnd].
  final int quietStart;
  final int quietEnd;
  final String timezone;

  PushPreferences copyWith({
    bool? pushEnabled,
    bool? engagementEnabled,
    List<String>? mutedCategories,
    int? quietStart,
    int? quietEnd,
  }) => PushPreferences(
    pushEnabled: pushEnabled ?? this.pushEnabled,
    engagementEnabled: engagementEnabled ?? this.engagementEnabled,
    mutedCategories: mutedCategories ?? this.mutedCategories,
    quietStart: quietStart ?? this.quietStart,
    quietEnd: quietEnd ?? this.quietEnd,
    timezone: timezone,
  );
}

/// Categories the user can mute, with the words the app shows for them.
const pushCategoryLabels = {
  'LC': 'Learning circles',
  'EVENTS': 'Events',
  'KARMA': 'Karma',
  'JOBS': 'Jobs and applications',
  'MEDIA_CONTENT': 'Weekly Twitches',
};
