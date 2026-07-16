import 'package:freezed_annotation/freezed_annotation.dart';

part 'karma_feed_top_user.freezed.dart';

/// The single highest-karma user, shown on the home dashboard's karma feed
/// highlight — pure-Dart domain entity (rules.md §2).
@freezed
abstract class KarmaFeedTopUser with _$KarmaFeedTopUser {
  const factory KarmaFeedTopUser({
    required String fullName,
    required String muid,
    required num karma,
  }) = _KarmaFeedTopUser;
}
