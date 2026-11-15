import 'package:mulearn_app/features/profile/domain/entities/socials.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_level.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_log_entry.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_profile.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'public_profile_controller.g.dart';

/// Read-only providers for viewing another user's profile by muid —
/// mirrors [ProfileController]/[SocialsController]/etc but scoped to a
/// specific muid instead of the signed-in user.

@riverpod
Future<UserProfile> publicUserProfile(Ref ref, String muid) =>
    ref.watch(profileRepositoryProvider).getPublicUserProfile(muid);

@riverpod
Future<List<UserLogEntry>> publicUserLog(Ref ref, String muid) =>
    ref.watch(profileRepositoryProvider).getPublicUserLog(muid);

@riverpod
Future<List<UserLevel>> publicUserLevels(Ref ref, String muid) =>
    ref.watch(profileRepositoryProvider).getPublicUserLevels(muid);

@riverpod
Future<Socials> publicSocials(Ref ref, String muid) =>
    ref.watch(profileRepositoryProvider).getPublicSocials(muid);
