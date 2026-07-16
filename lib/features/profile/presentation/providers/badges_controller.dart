import 'package:mulearn_app/features/profile/domain/entities/badges_data.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'badges_controller.g.dart';

@riverpod
Future<BadgesData> badges(Ref ref, String muid) =>
    ref.watch(profileRepositoryProvider).getBadges(muid);
