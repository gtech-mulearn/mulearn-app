import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/data/dtos/achievement_dto.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_achievement.dart';

part 'user_achievement_dto.freezed.dart';
part 'user_achievement_dto.g.dart';

@freezed
abstract class UserAchievementDto with _$UserAchievementDto {
  const factory UserAchievementDto({
    required String id,
    required String userId,
    required AchievementDto achievement,
    @Default(false) bool isIssued,
    String? vcUrl,
  }) = _UserAchievementDto;

  const UserAchievementDto._();

  factory UserAchievementDto.fromJson(Map<String, dynamic> json) =>
      _$UserAchievementDtoFromJson(json);

  UserAchievement toDomain() => UserAchievement(
        id: id,
        userId: userId,
        achievement: achievement.toDomain(),
        isIssued: isIssued,
        vcUrl: vcUrl,
      );
}
