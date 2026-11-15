import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/features/problem_statements/domain/entities/problem_statement.dart';

/// "Closes in 3 days", "Closes Wed 31 Dec", "Closed", "No deadline".
String psDeadlineLabel(ProblemStatement s, DateTime now) {
  final d = s.deadline;
  if (!s.isOpen) return 'Closed';
  if (d == null) return 'No deadline';
  final days = DateTime(
    d.year,
    d.month,
    d.day,
  ).difference(DateTime(now.year, now.month, now.day)).inDays;
  if (days <= 0) return 'Closes today, ${formatTime(d)}';
  if (days == 1) return 'Closes tomorrow';
  if (days <= 14) return 'Closes in $days days';
  return 'Closes ${formatDay(d)}';
}

/// "2 trying · 1 submitted", or "Be the first to try it".
String psPeopleLabel(ProblemStatement s) {
  if (s.trying == 0 && s.submitted == 0) {
    return s.isOpen ? 'Be the first to try it' : 'No one took part';
  }
  return [
    if (s.trying > 0) '${s.trying} trying',
    if (s.submitted > 0) '${s.submitted} submitted',
  ].join(' · ');
}

/// The deadline as a pill: amber with a clock when a week or less is left.
Widget psDeadlinePill(ProblemStatement s, DateTime now) {
  final label = psDeadlineLabel(s, now);
  final d = s.deadline;
  final soon = s.isOpen && d != null && d.difference(now).inDays < 7;
  if (!s.isOpen) return MuPill(label, icon: LucideIcons.lock);
  return soon
      ? MuPill(label, tone: MuPillTone.warning, icon: LucideIcons.clock)
      : MuPill(label);
}

/// The learner's own status as a pill, or nothing.
Widget? psStatusPill(PsStatus? status) => switch (status) {
  PsStatus.trying => const MuPill(
    "You're trying it",
    tone: MuPillTone.cobalt,
    icon: LucideIcons.hammer,
  ),
  PsStatus.submitted => const MuPill(
    'Submitted',
    tone: MuPillTone.success,
    icon: LucideIcons.checkCircle2,
  ),
  null => null,
};
