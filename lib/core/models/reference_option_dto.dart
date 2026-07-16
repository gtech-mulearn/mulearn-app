import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/core/models/reference_option.dart';

part 'reference_option_dto.freezed.dart';
part 'reference_option_dto.g.dart';

/// Raw `{id, title}` API shape for the role/college/department/company
/// reference-data lists (rules.md §2). Lives in `core/` alongside
/// [ReferenceOption] — see that file's doc comment.
@freezed
abstract class ReferenceOptionDto with _$ReferenceOptionDto {
  const factory ReferenceOptionDto({
    required String id,
    required String title,
  }) = _ReferenceOptionDto;

  const ReferenceOptionDto._();

  factory ReferenceOptionDto.fromJson(Map<String, dynamic> json) =>
      _$ReferenceOptionDtoFromJson(json);

  ReferenceOption toDomain() => ReferenceOption(id: id, title: title);
}
