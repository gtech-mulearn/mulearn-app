// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preferences_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserPreferencesController)
const userPreferencesControllerProvider = UserPreferencesControllerProvider._();

final class UserPreferencesControllerProvider
    extends $AsyncNotifierProvider<UserPreferencesController, UserPreferences> {
  const UserPreferencesControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userPreferencesControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userPreferencesControllerHash();

  @$internal
  @override
  UserPreferencesController create() => UserPreferencesController();
}

String _$userPreferencesControllerHash() =>
    r'53de89664018a5b7cc9ec5467ae20a762885fc8d';

abstract class _$UserPreferencesController
    extends $AsyncNotifier<UserPreferences> {
  FutureOr<UserPreferences> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<UserPreferences>, UserPreferences>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UserPreferences>, UserPreferences>,
              AsyncValue<UserPreferences>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
