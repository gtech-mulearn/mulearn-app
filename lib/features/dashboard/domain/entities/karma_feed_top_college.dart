import 'package:freezed_annotation/freezed_annotation.dart';

part 'karma_feed_top_college.freezed.dart';

/// The single highest-karma college, shown on the home dashboard's karma
/// feed highlight — pure-Dart domain entity (rules.md §2).
@freezed
abstract class KarmaFeedTopCollege with _$KarmaFeedTopCollege {
  const factory KarmaFeedTopCollege({
    required String name,
    required num karma,
  }) = _KarmaFeedTopCollege;
}
