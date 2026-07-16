import 'package:freezed_annotation/freezed_annotation.dart';

part 'socials.freezed.dart';

/// The user's linked social profile URLs — pure-Dart domain entity
/// (rules.md §2). All nullable strings; confirmed exact 9-field shape
/// against a real `GET /api/v1/dashboard/profile/socials/` response. Note
/// the confirmed key is `dribble`, not the more common `dribbble` spelling.
@freezed
abstract class Socials with _$Socials {
  const factory Socials({
    String? github,
    String? facebook,
    String? instagram,
    String? linkedin,
    String? dribble,
    String? behance,
    String? stackoverflow,
    String? medium,
    String? hackerrank,
  }) = _Socials;
}
