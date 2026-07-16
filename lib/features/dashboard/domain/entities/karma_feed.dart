import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/karma_feed_top_college.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/karma_feed_top_user.dart';

part 'karma_feed.freezed.dart';

/// The home dashboard's karma-feed highlight widget — pure-Dart domain
/// entity (rules.md §2). Confirmed against a real
/// `GET /api/v1/dashboard/profile/karma-feed/` response: despite the name,
/// this is a small top-user/top-college highlight, not a paginated activity
/// feed. Either side may be absent on a fresh/empty backend.
@freezed
abstract class KarmaFeed with _$KarmaFeed {
  const factory KarmaFeed({
    KarmaFeedTopUser? topUser,
    KarmaFeedTopCollege? topCollege,
  }) = _KarmaFeed;
}
