import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_log_entry.dart';

part 'user_log_entry_dto.freezed.dart';
part 'user_log_entry_dto.g.dart';

@freezed
abstract class UserLogEntryDto with _$UserLogEntryDto {
  const factory UserLogEntryDto({
    required String taskName,
    required num karma,
    required String createdDate,
  }) = _UserLogEntryDto;

  const UserLogEntryDto._();

  factory UserLogEntryDto.fromJson(Map<String, dynamic> json) =>
      _$UserLogEntryDtoFromJson(json);

  UserLogEntry toDomain() =>
      UserLogEntry(taskName: taskName, karma: karma, createdDate: createdDate);
}
