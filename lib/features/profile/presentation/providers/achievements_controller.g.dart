// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievements_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userAchievements)
const userAchievementsProvider = UserAchievementsFamily._();

final class UserAchievementsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<UserAchievement>>,
          List<UserAchievement>,
          FutureOr<List<UserAchievement>>
        >
    with
        $FutureModifier<List<UserAchievement>>,
        $FutureProvider<List<UserAchievement>> {
  const UserAchievementsProvider._({
    required UserAchievementsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'userAchievementsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userAchievementsHash();

  @override
  String toString() {
    return r'userAchievementsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<UserAchievement>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<UserAchievement>> create(Ref ref) {
    final argument = this.argument as String;
    return userAchievements(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UserAchievementsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userAchievementsHash() => r'aabdac23360204f189b31cf65d56b3e6aa1bfdcc';

final class UserAchievementsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<UserAchievement>>, String> {
  const UserAchievementsFamily._()
    : super(
        retry: null,
        name: r'userAchievementsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UserAchievementsProvider call(String muid) =>
      UserAchievementsProvider._(argument: muid, from: this);

  @override
  String toString() => r'userAchievementsProvider';
}

/// DIDs already connected/verified via QSeverse for [muid] — used to decide
/// whether the VC-issuance flow can proceed without an extra connect step.

@ProviderFor(connectedDids)
const connectedDidsProvider = ConnectedDidsFamily._();

/// DIDs already connected/verified via QSeverse for [muid] — used to decide
/// whether the VC-issuance flow can proceed without an extra connect step.

final class ConnectedDidsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<String>>,
          List<String>,
          FutureOr<List<String>>
        >
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  /// DIDs already connected/verified via QSeverse for [muid] — used to decide
  /// whether the VC-issuance flow can proceed without an extra connect step.
  const ConnectedDidsProvider._({
    required ConnectedDidsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'connectedDidsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$connectedDidsHash();

  @override
  String toString() {
    return r'connectedDidsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>> create(Ref ref) {
    final argument = this.argument as String;
    return connectedDids(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ConnectedDidsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$connectedDidsHash() => r'9db4182e1690a292baf536e70d1c3b711967a0e8';

/// DIDs already connected/verified via QSeverse for [muid] — used to decide
/// whether the VC-issuance flow can proceed without an extra connect step.

final class ConnectedDidsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<String>>, String> {
  const ConnectedDidsFamily._()
    : super(
        retry: null,
        name: r'connectedDidsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// DIDs already connected/verified via QSeverse for [muid] — used to decide
  /// whether the VC-issuance flow can proceed without an extra connect step.

  ConnectedDidsProvider call(String muid) =>
      ConnectedDidsProvider._(argument: muid, from: this);

  @override
  String toString() => r'connectedDidsProvider';
}
