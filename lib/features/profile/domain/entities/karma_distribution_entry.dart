import 'package:freezed_annotation/freezed_annotation.dart';

part 'karma_distribution_entry.freezed.dart';

/// Karma earned per task type, e.g. `{task_type: "TFP", karma: 120}` — pure
/// Dart domain entity (rules.md §2).
@freezed
abstract class KarmaDistributionEntry with _$KarmaDistributionEntry {
  const factory KarmaDistributionEntry({
    required String taskType,
    required num karma,
  }) = _KarmaDistributionEntry;
}
