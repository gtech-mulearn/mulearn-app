// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_profile_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Read-only providers for viewing another user's profile by muid —
/// mirrors [ProfileController]/[SocialsController]/etc but scoped to a
/// specific muid instead of the signed-in user.

@ProviderFor(publicUserProfile)
const publicUserProfileProvider = PublicUserProfileFamily._();

/// Read-only providers for viewing another user's profile by muid —
/// mirrors [ProfileController]/[SocialsController]/etc but scoped to a
/// specific muid instead of the signed-in user.

final class PublicUserProfileProvider
    extends
        $FunctionalProvider<
          AsyncValue<UserProfile>,
          UserProfile,
          FutureOr<UserProfile>
        >
    with $FutureModifier<UserProfile>, $FutureProvider<UserProfile> {
  /// Read-only providers for viewing another user's profile by muid —
  /// mirrors [ProfileController]/[SocialsController]/etc but scoped to a
  /// specific muid instead of the signed-in user.
  const PublicUserProfileProvider._({
    required PublicUserProfileFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'publicUserProfileProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$publicUserProfileHash();

  @override
  String toString() {
    return r'publicUserProfileProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<UserProfile> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<UserProfile> create(Ref ref) {
    final argument = this.argument as String;
    return publicUserProfile(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PublicUserProfileProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$publicUserProfileHash() => r'fd506f4f80b7cac6f2bddab8d029558dffa1c504';

/// Read-only providers for viewing another user's profile by muid —
/// mirrors [ProfileController]/[SocialsController]/etc but scoped to a
/// specific muid instead of the signed-in user.

final class PublicUserProfileFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<UserProfile>, String> {
  const PublicUserProfileFamily._()
    : super(
        retry: null,
        name: r'publicUserProfileProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Read-only providers for viewing another user's profile by muid —
  /// mirrors [ProfileController]/[SocialsController]/etc but scoped to a
  /// specific muid instead of the signed-in user.

  PublicUserProfileProvider call(String muid) =>
      PublicUserProfileProvider._(argument: muid, from: this);

  @override
  String toString() => r'publicUserProfileProvider';
}

@ProviderFor(publicUserLog)
const publicUserLogProvider = PublicUserLogFamily._();

final class PublicUserLogProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<UserLogEntry>>,
          List<UserLogEntry>,
          FutureOr<List<UserLogEntry>>
        >
    with
        $FutureModifier<List<UserLogEntry>>,
        $FutureProvider<List<UserLogEntry>> {
  const PublicUserLogProvider._({
    required PublicUserLogFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'publicUserLogProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$publicUserLogHash();

  @override
  String toString() {
    return r'publicUserLogProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<UserLogEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<UserLogEntry>> create(Ref ref) {
    final argument = this.argument as String;
    return publicUserLog(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PublicUserLogProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$publicUserLogHash() => r'6595132ce0af53c82b07b9f3dcac464cb56c5fe3';

final class PublicUserLogFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<UserLogEntry>>, String> {
  const PublicUserLogFamily._()
    : super(
        retry: null,
        name: r'publicUserLogProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PublicUserLogProvider call(String muid) =>
      PublicUserLogProvider._(argument: muid, from: this);

  @override
  String toString() => r'publicUserLogProvider';
}

@ProviderFor(publicUserLevels)
const publicUserLevelsProvider = PublicUserLevelsFamily._();

final class PublicUserLevelsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<UserLevel>>,
          List<UserLevel>,
          FutureOr<List<UserLevel>>
        >
    with $FutureModifier<List<UserLevel>>, $FutureProvider<List<UserLevel>> {
  const PublicUserLevelsProvider._({
    required PublicUserLevelsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'publicUserLevelsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$publicUserLevelsHash();

  @override
  String toString() {
    return r'publicUserLevelsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<UserLevel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<UserLevel>> create(Ref ref) {
    final argument = this.argument as String;
    return publicUserLevels(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PublicUserLevelsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$publicUserLevelsHash() => r'81ce377ea39e59f9357b6f5a579ce0c36caae9fa';

final class PublicUserLevelsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<UserLevel>>, String> {
  const PublicUserLevelsFamily._()
    : super(
        retry: null,
        name: r'publicUserLevelsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PublicUserLevelsProvider call(String muid) =>
      PublicUserLevelsProvider._(argument: muid, from: this);

  @override
  String toString() => r'publicUserLevelsProvider';
}

@ProviderFor(publicSocials)
const publicSocialsProvider = PublicSocialsFamily._();

final class PublicSocialsProvider
    extends $FunctionalProvider<AsyncValue<Socials>, Socials, FutureOr<Socials>>
    with $FutureModifier<Socials>, $FutureProvider<Socials> {
  const PublicSocialsProvider._({
    required PublicSocialsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'publicSocialsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$publicSocialsHash();

  @override
  String toString() {
    return r'publicSocialsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Socials> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Socials> create(Ref ref) {
    final argument = this.argument as String;
    return publicSocials(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PublicSocialsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$publicSocialsHash() => r'69be152d7a876af652822989c84b7493ac23155b';

final class PublicSocialsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Socials>, String> {
  const PublicSocialsFamily._()
    : super(
        retry: null,
        name: r'publicSocialsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PublicSocialsProvider call(String muid) =>
      PublicSocialsProvider._(argument: muid, from: this);

  @override
  String toString() => r'publicSocialsProvider';
}
