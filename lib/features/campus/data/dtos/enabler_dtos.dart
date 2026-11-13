import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/campus/domain/entities/enabler.dart';

part 'enabler_dtos.freezed.dart';
part 'enabler_dtos.g.dart';

/// One row of `enabler/campuses/` and the body of `campuses/<id>/review/`
/// (`EnablerCampusListSerializer`).
@freezed
abstract class EnablerCampusDto with _$EnablerCampusDto {
  const factory EnablerCampusDto({
    required String id,
    @Default('') String collegeName,
    @Default('') String campusCode,
    String? zone,
    @Default('') String orgType,
  }) = _EnablerCampusDto;

  const EnablerCampusDto._();

  factory EnablerCampusDto.fromJson(Map<String, dynamic> json) => _$EnablerCampusDtoFromJson(json);

  EnablerCampus toDomain() =>
      EnablerCampus(id: id, collegeName: collegeName, campusCode: campusCode, zone: zone ?? '', orgType: orgType);
}

/// One row of `campuses/<id>/notes/` (`EnablerCampusNoteSerializer`).
@freezed
abstract class CampusNoteDto with _$CampusNoteDto {
  const factory CampusNoteDto({
    required String id,
    required String createdAt,
    @Default('') String note,
    @Default('medium') String priority,
    @Default('open') String status,
    String? enablerName,
    String? followUpDate,
  }) = _CampusNoteDto;

  const CampusNoteDto._();

  factory CampusNoteDto.fromJson(Map<String, dynamic> json) => _$CampusNoteDtoFromJson(json);

  CampusNote toDomain() {
    final follow = followUpDate == null ? null : DateTime.tryParse(followUpDate!);
    return CampusNote(
      id: id,
      note: note,
      priority: priority.toLowerCase(),
      status: status.toLowerCase(),
      createdAt: DateTime.parse(createdAt).toUtc(),
      author: (enablerName ?? '').isEmpty ? null : enablerName,
      followUp: follow == null ? null : DateTime(follow.year, follow.month, follow.day),
    );
  }
}
