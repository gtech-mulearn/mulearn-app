/// The backend's mentorship enums (`db/mentor.py`, `MentorshipSession`).
/// Each keeps its wire value; anything new parses as `unknown`.
library;

enum SessionType {
  igSession('IG_SESSION'),
  campusSession('CAMPUS_SESSION'),
  companySession('COMPANY_SESSION'),
  unknown('');

  const SessionType(this.wire);
  final String wire;

  static SessionType fromWire(String? value) =>
      values.firstWhere((e) => e != unknown && e.wire == value?.toUpperCase(), orElse: () => unknown);
}

enum SessionMode {
  online('ONLINE'),
  offline('OFFLINE'),
  hybrid('HYBRID'),
  unknown('');

  const SessionMode(this.wire);
  final String wire;

  static SessionMode fromWire(String? value) =>
      values.firstWhere((e) => e != unknown && e.wire == value?.toUpperCase(), orElse: () => unknown);
}

enum SessionStatus {
  requested('REQUESTED'),
  scheduled('SCHEDULED'),
  pendingApproval('PENDING_APPROVAL'),
  completed('COMPLETED'),
  cancelled('CANCELLED'),
  rejected('REJECTED'),
  unknown('');

  const SessionStatus(this.wire);
  final String wire;

  static SessionStatus fromWire(String? value) =>
      values.firstWhere((e) => e != unknown && e.wire == value?.toUpperCase(), orElse: () => unknown);
}

enum RecurrenceType {
  daily('DAILY'),
  weekly('WEEKLY'),
  monthly('MONTHLY');

  const RecurrenceType(this.wire);
  final String wire;

  static RecurrenceType? fromWire(String? value) =>
      values.where((e) => e.wire == value?.toUpperCase()).firstOrNull;
}
