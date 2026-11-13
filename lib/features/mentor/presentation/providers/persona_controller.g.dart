// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persona_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Who the mentor is acting as. A switch shows at once and is restored if
/// the backend refuses it (the error is rethrown for the screen).

@ProviderFor(PersonaController)
const personaControllerProvider = PersonaControllerProvider._();

/// Who the mentor is acting as. A switch shows at once and is restored if
/// the backend refuses it (the error is rethrown for the screen).
final class PersonaControllerProvider
    extends $AsyncNotifierProvider<PersonaController, Persona> {
  /// Who the mentor is acting as. A switch shows at once and is restored if
  /// the backend refuses it (the error is rethrown for the screen).
  const PersonaControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'personaControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$personaControllerHash();

  @$internal
  @override
  PersonaController create() => PersonaController();
}

String _$personaControllerHash() => r'e53237625528ef65216dcf4de7294dc6887a1391';

/// Who the mentor is acting as. A switch shows at once and is restored if
/// the backend refuses it (the error is rethrown for the screen).

abstract class _$PersonaController extends $AsyncNotifier<Persona> {
  FutureOr<Persona> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Persona>, Persona>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Persona>, Persona>,
              AsyncValue<Persona>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
