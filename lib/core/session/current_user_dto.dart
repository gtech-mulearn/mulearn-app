import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/core/session/current_user.dart';

part 'current_user_dto.freezed.dart';
part 'current_user_dto.g.dart';

/// `GET /api/v1/dashboard/user/info/` — `UserSerializer`
/// (api/dashboard/user/dash_user_serializer.py). Only the fields the app
/// uses are modelled.
@freezed
abstract class CurrentUserDto with _$CurrentUserDto {
  const factory CurrentUserDto({
    required String muid,
    required String fullName,
    @Default([]) List<String> roles,
    @Default(false) bool existInGuild,
    String? profilePic,
    String? company,
  }) = _CurrentUserDto;

  const CurrentUserDto._();

  factory CurrentUserDto.fromJson(Map<String, dynamic> json) => _$CurrentUserDtoFromJson(json);

  CurrentUser toDomain() => CurrentUser(
        muid: muid,
        fullName: fullName,
        roles: roles,
        existInGuild: existInGuild,
        profilePic: profilePic,
        company: company,
      );
}
