import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/interest_groups/domain/entities/ig_person_ref.dart';

part 'ig_person_ref_dto.freezed.dart';
part 'ig_person_ref_dto.g.dart';

@freezed
abstract class IgPersonRefDto with _$IgPersonRefDto {
  const factory IgPersonRefDto({
    required String muid,
    String? fullName,
    String? profilePic,
  }) = _IgPersonRefDto;

  const IgPersonRefDto._();

  factory IgPersonRefDto.fromJson(Map<String, dynamic> json) =>
      _$IgPersonRefDtoFromJson(json);

  IgPersonRef toDomain() => IgPersonRef(
        muid: muid,
        fullName: fullName ?? muid,
        profilePicUrl: profilePic,
      );
}
