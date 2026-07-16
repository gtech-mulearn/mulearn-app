// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_levels_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userLevels)
const userLevelsProvider = UserLevelsProvider._();

final class UserLevelsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<UserLevel>>,
          List<UserLevel>,
          FutureOr<List<UserLevel>>
        >
    with $FutureModifier<List<UserLevel>>, $FutureProvider<List<UserLevel>> {
  const UserLevelsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userLevelsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userLevelsHash();

  @$internal
  @override
  $FutureProviderElement<List<UserLevel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<UserLevel>> create(Ref ref) {
    return userLevels(ref);
  }
}

String _$userLevelsHash() => r'd23123f65c235aa74d96554c270ad502e8fe89bd';
