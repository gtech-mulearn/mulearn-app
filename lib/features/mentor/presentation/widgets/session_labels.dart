import 'package:mulearn_app/features/mentor/domain/entities/mentor_scope.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_enums.dart';

/// How a session's mode reads.
String sessionModeLabel(SessionMode mode) => switch (mode) {
      SessionMode.online => 'Online',
      SessionMode.offline => 'In person',
      SessionMode.hybrid => 'Hybrid',
      SessionMode.unknown => 'Session',
    };

/// How a scope's type reads.
String scopeTypeLabel(MentorScopeType type) => switch (type) {
      MentorScopeType.igMentor => 'IG mentor',
      MentorScopeType.campusMentor => 'Campus mentor',
      MentorScopeType.companyMentor => 'Company mentor',
      MentorScopeType.global => 'Global mentor',
      MentorScopeType.unknown => 'Mentor',
    };
