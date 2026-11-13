import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_scope.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_enums.dart';

part 'session_draft.freezed.dart';

/// Where a session belongs: the backend's `session_type` + `entity_id`.
@freezed
abstract class SessionTarget with _$SessionTarget {
  const factory SessionTarget({
    required SessionType type,
    required String entityId,
    required String label,
  }) = _SessionTarget;
}

/// An interest group the mentor can use (`tasks/ig-dropdown/`).
@freezed
abstract class IgOption with _$IgOption {
  const factory IgOption({required String id, required String name}) = _IgOption;
}

/// [sessionTargets] under a name that doesn't clash with the provider.
List<SessionTarget> buildSessionTargets(List<MentorScope> scopes, List<IgOption> igs) => sessionTargets(scopes, igs);

/// Each scope is a target of its own session type; a global (`MENTOR`)
/// scope expands to one IG_SESSION target per interest group (the
/// dashboard's `applySessionTarget`). Unknown scopes are skipped.
List<SessionTarget> sessionTargets(List<MentorScope> scopes, List<IgOption> igs) {
  final targets = <SessionTarget>[];
  void add(SessionTarget t) {
    if (!targets.any((x) => x.type == t.type && x.entityId == t.entityId)) targets.add(t);
  }

  for (final scope in scopes) {
    switch (scope.type) {
      case MentorScopeType.igMentor:
        add(SessionTarget(type: SessionType.igSession, entityId: scope.id, label: scope.name));
      case MentorScopeType.campusMentor:
        add(SessionTarget(type: SessionType.campusSession, entityId: scope.id, label: scope.name));
      case MentorScopeType.companyMentor:
        add(SessionTarget(type: SessionType.companySession, entityId: scope.id, label: scope.name));
      case MentorScopeType.global:
        for (final ig in igs) {
          add(SessionTarget(type: SessionType.igSession, entityId: ig.id, label: ig.name));
        }
      case MentorScopeType.unknown:
        break;
    }
  }
  return targets;
}

/// What the mentor fills in to create or edit a session. Times are local
/// wall-clock; the JSON sends UTC instants.
@freezed
abstract class SessionDraft with _$SessionDraft {
  const factory SessionDraft({
    required String title,
    required String description,
    required SessionMode mode,
    required String meetingLink,
    required String venue,
    SessionTarget? target,
    DateTime? startsLocal,
    DateTime? endsLocal,
    int? maxParticipants,
    @Default(false) bool isRecurring,
    RecurrenceType? recurrenceType,
    @Default(1) int recurrenceInterval,
    DateTime? recurrenceEndDate,
  }) = _SessionDraft;

  const SessionDraft._();

  /// The first problem the backend would reject, in its own words where it
  /// has them (`SessionCreateSerializer.validate`); null when sendable.
  String? validate() {
    if (target == null) return 'Pick where this session belongs.';
    if (title.trim().isEmpty) return 'Title is required.';
    final starts = startsLocal;
    final ends = endsLocal;
    if (starts == null || ends == null || !ends.isAfter(starts)) {
      return 'Session start time must be before end time.';
    }
    if (mode == SessionMode.hybrid) {
      if (venue.trim().isEmpty) return 'Venue is required for a hybrid session.';
      if (meetingLink.trim().isEmpty) return 'Meeting link is required for a hybrid session.';
    }
    if (isRecurring && recurrenceType == null) return 'Choose how often it repeats.';
    return null;
  }

  /// `POST session/create/`.
  Map<String, Object?> toCreateJson() => {
        'session_type': target!.type.wire,
        'entity_id': target!.entityId,
        ..._common(),
        if (maxParticipants != null) 'max_participants': maxParticipants,
        'is_recurring': isRecurring,
        if (isRecurring) ...{
          'recurrence_type': recurrenceType?.wire,
          'recurrence_interval': recurrenceInterval,
          'recurrence_end_date': recurrenceEndDate == null ? null : _date(recurrenceEndDate!),
        },
      };

  /// `PATCH session/update/<id>/`: only what `SessionUpdateSerializer`
  /// accepts. An edit changes this session only, never the series.
  Map<String, Object?> toUpdateJson() => _common();

  Map<String, Object?> _common() {
    final link = meetingLink.trim();
    final place = venue.trim();
    final about = description.trim();
    return {
      'title': title.trim(),
      if (about.isNotEmpty) 'description': about,
      'mode': mode.wire,
      'starts_at': startsLocal!.toUtc().toIso8601String(),
      'ends_at': endsLocal!.toUtc().toIso8601String(),
      // The backend refuses a venue online and a link in person.
      ...switch (mode) {
        SessionMode.online => {'venue': '', if (link.isNotEmpty) 'meeting_link': link},
        SessionMode.offline => {'meeting_link': '', if (place.isNotEmpty) 'venue': place},
        _ => {if (link.isNotEmpty) 'meeting_link': link, if (place.isNotEmpty) 'venue': place},
      },
    };
  }

  static String _date(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}
