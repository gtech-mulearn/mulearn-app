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
         retry: noRetry,
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

String _$userAchievementsHash() => r'ae11739bc76106945ab08a2e1864c6c5775c7513';

final class UserAchievementsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<UserAchievement>>, String> {
  const UserAchievementsFamily._()
    : super(
        retry: noRetry,
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

/// What the signed-in user can claim now.

@ProviderFor(eligibleAchievements)
const eligibleAchievementsProvider = EligibleAchievementsProvider._();

/// What the signed-in user can claim now.

final class EligibleAchievementsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AchievementProgress>>,
          List<AchievementProgress>,
          FutureOr<List<AchievementProgress>>
        >
    with
        $FutureModifier<List<AchievementProgress>>,
        $FutureProvider<List<AchievementProgress>> {
  /// What the signed-in user can claim now.
  const EligibleAchievementsProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'eligibleAchievementsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eligibleAchievementsHash();

  @$internal
  @override
  $FutureProviderElement<List<AchievementProgress>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AchievementProgress>> create(Ref ref) {
    return eligibleAchievements(ref);
  }
}

String _$eligibleAchievementsHash() =>
    r'b4033aa553a2644588b1b740e055fccc7d649f95';

/// Progress towards every achievement (filtered into "In Progress").

@ProviderFor(achievementProgress)
const achievementProgressProvider = AchievementProgressProvider._();

/// Progress towards every achievement (filtered into "In Progress").

final class AchievementProgressProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AchievementProgress>>,
          List<AchievementProgress>,
          FutureOr<List<AchievementProgress>>
        >
    with
        $FutureModifier<List<AchievementProgress>>,
        $FutureProvider<List<AchievementProgress>> {
  /// Progress towards every achievement (filtered into "In Progress").
  const AchievementProgressProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'achievementProgressProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$achievementProgressHash();

  @$internal
  @override
  $FutureProviderElement<List<AchievementProgress>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AchievementProgress>> create(Ref ref) {
    return achievementProgress(ref);
  }
}

String _$achievementProgressHash() =>
    r'a929d98c7e02f937bc6a0239ffdd650c9ea3cf4b';

/// Catalog descriptions by id, to describe eligible and in-progress items.

@ProviderFor(achievementDescriptions)
const achievementDescriptionsProvider = AchievementDescriptionsProvider._();

/// Catalog descriptions by id, to describe eligible and in-progress items.

final class AchievementDescriptionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, String>>,
          Map<String, String>,
          FutureOr<Map<String, String>>
        >
    with
        $FutureModifier<Map<String, String>>,
        $FutureProvider<Map<String, String>> {
  /// Catalog descriptions by id, to describe eligible and in-progress items.
  const AchievementDescriptionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'achievementDescriptionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$achievementDescriptionsHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, String>> create(Ref ref) {
    return achievementDescriptions(ref);
  }
}

String _$achievementDescriptionsHash() =>
    r'3089bf7d92a80336dbf81ca6f703656d08400a52';

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

/// Claims an achievement, then refreshes the earned, eligible and progress
/// lists. Throws the backend's reason when refused.

@ProviderFor(AchievementClaimController)
const achievementClaimControllerProvider =
    AchievementClaimControllerProvider._();

/// Claims an achievement, then refreshes the earned, eligible and progress
/// lists. Throws the backend's reason when refused.
final class AchievementClaimControllerProvider
    extends $AsyncNotifierProvider<AchievementClaimController, void> {
  /// Claims an achievement, then refreshes the earned, eligible and progress
  /// lists. Throws the backend's reason when refused.
  const AchievementClaimControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'achievementClaimControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$achievementClaimControllerHash();

  @$internal
  @override
  AchievementClaimController create() => AchievementClaimController();
}

String _$achievementClaimControllerHash() =>
    r'43dd121ee2c6199405e86078d60e07ddc0addd6c';

/// Claims an achievement, then refreshes the earned, eligible and progress
/// lists. Throws the backend's reason when refused.

abstract class _$AchievementClaimController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
