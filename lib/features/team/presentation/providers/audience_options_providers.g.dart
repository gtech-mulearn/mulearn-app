// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audience_options_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Every role. A role audience is matched by `title`, not id.

@ProviderFor(teamRoleOptions)
final teamRoleOptionsProvider = TeamRoleOptionsProvider._();

/// Every role. A role audience is matched by `title`, not id.

final class TeamRoleOptionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ReferenceOption>>,
          List<ReferenceOption>,
          FutureOr<List<ReferenceOption>>
        >
    with
        $FutureModifier<List<ReferenceOption>>,
        $FutureProvider<List<ReferenceOption>> {
  /// Every role. A role audience is matched by `title`, not id.
  TeamRoleOptionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'teamRoleOptionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$teamRoleOptionsHash();

  @$internal
  @override
  $FutureProviderElement<List<ReferenceOption>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ReferenceOption>> create(Ref ref) {
    return teamRoleOptions(ref);
  }
}

String _$teamRoleOptionsHash() => r'9174487b543c68d49d1bda6df3ce6f9bee51e611';

/// Every interest group (`title` is the group's name).

@ProviderFor(teamIgOptions)
final teamIgOptionsProvider = TeamIgOptionsProvider._();

/// Every interest group (`title` is the group's name).

final class TeamIgOptionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ReferenceOption>>,
          List<ReferenceOption>,
          FutureOr<List<ReferenceOption>>
        >
    with
        $FutureModifier<List<ReferenceOption>>,
        $FutureProvider<List<ReferenceOption>> {
  /// Every interest group (`title` is the group's name).
  TeamIgOptionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'teamIgOptionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$teamIgOptionsHash();

  @$internal
  @override
  $FutureProviderElement<List<ReferenceOption>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ReferenceOption>> create(Ref ref) {
    return teamIgOptions(ref);
  }
}

String _$teamIgOptionsHash() => r'13f72903bcc7559a164536c86d829e44464ca457';

/// Colleges matching [query] (two letters or more), for a college audience.
/// Each query is kept a while, so retyping costs no request.

@ProviderFor(teamCollegeSearch)
final teamCollegeSearchProvider = TeamCollegeSearchFamily._();

/// Colleges matching [query] (two letters or more), for a college audience.
/// Each query is kept a while, so retyping costs no request.

final class TeamCollegeSearchProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ReferenceOption>>,
          List<ReferenceOption>,
          FutureOr<List<ReferenceOption>>
        >
    with
        $FutureModifier<List<ReferenceOption>>,
        $FutureProvider<List<ReferenceOption>> {
  /// Colleges matching [query] (two letters or more), for a college audience.
  /// Each query is kept a while, so retyping costs no request.
  TeamCollegeSearchProvider._({
    required TeamCollegeSearchFamily super.from,
    required String super.argument,
  }) : super(
         retry: noRetry,
         name: r'teamCollegeSearchProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$teamCollegeSearchHash();

  @override
  String toString() {
    return r'teamCollegeSearchProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ReferenceOption>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ReferenceOption>> create(Ref ref) {
    final argument = this.argument as String;
    return teamCollegeSearch(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TeamCollegeSearchProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$teamCollegeSearchHash() => r'cd6f86a7eb31950c3300d81182c71f551da59df8';

/// Colleges matching [query] (two letters or more), for a college audience.
/// Each query is kept a while, so retyping costs no request.

final class TeamCollegeSearchFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<ReferenceOption>>, String> {
  TeamCollegeSearchFamily._()
    : super(
        retry: noRetry,
        name: r'teamCollegeSearchProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Colleges matching [query] (two letters or more), for a college audience.
  /// Each query is kept a while, so retyping costs no request.

  TeamCollegeSearchProvider call(String query) =>
      TeamCollegeSearchProvider._(argument: query, from: this);

  @override
  String toString() => r'teamCollegeSearchProvider';
}
