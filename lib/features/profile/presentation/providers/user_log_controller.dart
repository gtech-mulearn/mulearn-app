import 'package:mulearn_app/features/profile/domain/entities/user_log_entry.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_log_controller.g.dart';

@riverpod
Future<List<UserLogEntry>> userLog(Ref ref) =>
    ref.watch(profileRepositoryProvider).getUserLog();
