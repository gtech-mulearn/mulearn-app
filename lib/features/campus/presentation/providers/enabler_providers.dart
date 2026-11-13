import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/utils/no_retry.dart';
import 'package:mulearn_app/features/campus/data/repositories/enabler_repository_impl.dart';
import 'package:mulearn_app/features/campus/domain/entities/enabler.dart';
import 'package:mulearn_app/features/campus/domain/repositories/enabler_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'enabler_providers.g.dart';

@riverpod
EnablerRepository enablerRepository(Ref ref) => EnablerRepositoryImpl(ref.watch(dioProvider));

@Riverpod(retry: noRetry)
Future<EnablerSummary> enablerSummary(Ref ref) => ref.watch(enablerRepositoryProvider).getSummary();

@Riverpod(retry: noRetry)
Future<List<EnablerCampus>> enablerCampuses(Ref ref) => ref.watch(enablerRepositoryProvider).getCampuses();

@Riverpod(retry: noRetry)
Future<EnablerCampus> enablerCampus(Ref ref, String id) => ref.watch(enablerRepositoryProvider).getCampus(id);

/// A campus's notes; [add] saves one and reloads the list (the backend
/// returns only a message).
@Riverpod(retry: noRetry)
class CampusNotesController extends _$CampusNotesController {
  @override
  Future<List<CampusNote>> build(String campusId) => ref.watch(enablerRepositoryProvider).getNotes(campusId);

  Future<String> add({required String note, required String priority, DateTime? followUp}) async {
    final repository = ref.read(enablerRepositoryProvider);
    final message = await repository.addNote(campusId, note: note, priority: priority, followUp: followUp);
    if (ref.mounted) ref.invalidateSelf();
    return message;
  }
}
