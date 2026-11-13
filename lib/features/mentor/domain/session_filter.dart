import 'package:mulearn_app/features/mentor/domain/entities/mentor_session.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_enums.dart';

/// The sessions list's chips. `session/list/` filters one exact status;
/// upcoming sessions read soonest first, the rest newest first.
enum SessionFilter {
  upcoming('Upcoming', SessionStatus.scheduled, ascending: true),
  awaitingApproval('Awaiting approval', SessionStatus.pendingApproval, ascending: false),
  completed('Completed', SessionStatus.completed, ascending: false),
  all('All', null, ascending: false);

  const SessionFilter(this.label, this.status, {required this.ascending});

  final String label;
  final SessionStatus? status;
  final bool ascending;
}

DateTime _toLocal(DateTime utc) => utc.toLocal();

/// Sessions grouped under their local calendar day, in the given order.
/// [toLocal] is injectable so tests can pin a time zone.
List<({DateTime day, List<MentorSession> sessions})> groupByLocalDay(
  List<MentorSession> sessions, {
  DateTime Function(DateTime utc) toLocal = _toLocal,
}) {
  final groups = <({DateTime day, List<MentorSession> sessions})>[];
  for (final s in sessions) {
    final local = toLocal(s.startsAt);
    final day = DateTime(local.year, local.month, local.day);
    if (groups.isNotEmpty && groups.last.day == day) {
      groups.last.sessions.add(s);
    } else {
      groups.add((day: day, sessions: [s]));
    }
  }
  return groups;
}
