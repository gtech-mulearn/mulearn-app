import 'package:mulearn_app/core/utils/no_retry.dart';
import 'package:mulearn_app/features/mentor/data/mentor_repository_provider.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_scope.dart';
import 'package:mulearn_app/features/mentor/domain/entities/persona.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'persona_controller.g.dart';

/// Who the mentor is acting as. A switch shows at once and is restored if
/// the backend refuses it (the error is rethrown for the screen).
@Riverpod(retry: noRetry)
class PersonaController extends _$PersonaController {
  @override
  Future<Persona> build() => ref.watch(mentorRepositoryProvider).getPersona();

  Future<String> switchTo(MentorScope? scope) async {
    final repository = ref.read(mentorRepositoryProvider);
    final before = state.value;
    state = AsyncData(
      scope == null
          ? const Persona(isMentor: false)
          : Persona(isMentor: true, scopeType: scope.type, scopeId: scope.id, scopeName: scope.name),
    );
    try {
      return await repository.switchPersona(scope);
    } on Object {
      if (ref.mounted && before != null) state = AsyncData(before);
      rethrow;
    }
  }
}
