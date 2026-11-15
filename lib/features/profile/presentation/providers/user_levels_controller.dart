import 'package:mulearn_app/features/profile/domain/entities/user_level.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_levels_controller.g.dart';

@riverpod
Future<List<UserLevel>> userLevels(Ref ref) =>
    ref.watch(profileRepositoryProvider).getUserLevels();
