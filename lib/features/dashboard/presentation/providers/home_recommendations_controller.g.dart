// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_recommendations_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Learning circles whose interest group matches one the signed-in user has
/// joined — composed client-side since neither `/learningcircle/list/` nor
/// `/ig/list/` offers a way to filter circles by IG server-side. Cross-
/// references the circle catalog's first page (there's no "all circles for
/// IG X" endpoint) against the user's joined interest-group names: the two
/// endpoints only share IG identity via display name (`LearningCircle.ig`),
/// not id, so the match is name-based and case-/whitespace-insensitive.

@ProviderFor(circlesForMyInterestGroups)
const circlesForMyInterestGroupsProvider =
    CirclesForMyInterestGroupsProvider._();

/// Learning circles whose interest group matches one the signed-in user has
/// joined — composed client-side since neither `/learningcircle/list/` nor
/// `/ig/list/` offers a way to filter circles by IG server-side. Cross-
/// references the circle catalog's first page (there's no "all circles for
/// IG X" endpoint) against the user's joined interest-group names: the two
/// endpoints only share IG identity via display name (`LearningCircle.ig`),
/// not id, so the match is name-based and case-/whitespace-insensitive.

final class CirclesForMyInterestGroupsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<LearningCircle>>,
          List<LearningCircle>,
          FutureOr<List<LearningCircle>>
        >
    with
        $FutureModifier<List<LearningCircle>>,
        $FutureProvider<List<LearningCircle>> {
  /// Learning circles whose interest group matches one the signed-in user has
  /// joined — composed client-side since neither `/learningcircle/list/` nor
  /// `/ig/list/` offers a way to filter circles by IG server-side. Cross-
  /// references the circle catalog's first page (there's no "all circles for
  /// IG X" endpoint) against the user's joined interest-group names: the two
  /// endpoints only share IG identity via display name (`LearningCircle.ig`),
  /// not id, so the match is name-based and case-/whitespace-insensitive.
  const CirclesForMyInterestGroupsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'circlesForMyInterestGroupsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$circlesForMyInterestGroupsHash();

  @$internal
  @override
  $FutureProviderElement<List<LearningCircle>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<LearningCircle>> create(Ref ref) {
    return circlesForMyInterestGroups(ref);
  }
}

String _$circlesForMyInterestGroupsHash() =>
    r'2fe47cbbd51ab5eb01b48b4418f8d9181132f9b5';
