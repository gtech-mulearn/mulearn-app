import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_log_entry.freezed.dart';

/// A single karma-earning activity log entry — pure-Dart domain entity
/// (rules.md §2). Powers the activity heatmap and karma-history tab.
@freezed
abstract class UserLogEntry with _$UserLogEntry {
  const factory UserLogEntry({
    required String taskName,
    required num karma,
    required String createdDate,
  }) = _UserLogEntry;
}
