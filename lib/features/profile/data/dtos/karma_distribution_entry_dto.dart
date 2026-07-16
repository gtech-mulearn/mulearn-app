import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/domain/entities/karma_distribution_entry.dart';

part 'karma_distribution_entry_dto.freezed.dart';
part 'karma_distribution_entry_dto.g.dart';

@freezed
abstract class KarmaDistributionEntryDto with _$KarmaDistributionEntryDto {
  const factory KarmaDistributionEntryDto({
    required String taskType,
    required num karma,
  }) = _KarmaDistributionEntryDto;

  const KarmaDistributionEntryDto._();

  factory KarmaDistributionEntryDto.fromJson(Map<String, dynamic> json) =>
      _$KarmaDistributionEntryDtoFromJson(json);

  KarmaDistributionEntry toDomain() =>
      KarmaDistributionEntry(taskType: taskType, karma: karma);
}
