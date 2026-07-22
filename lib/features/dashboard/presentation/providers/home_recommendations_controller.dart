import 'package:mulearn_app/features/interest_groups/presentation/providers/interest_groups_controller.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/learning_circle.dart';
import 'package:mulearn_app/features/learning_circles/presentation/providers/learning_circles_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_recommendations_controller.g.dart';

/// Learning circles whose interest group matches one the signed-in user has
/// joined — composed client-side since neither `/learningcircle/list/` nor
/// `/ig/list/` offers a way to filter circles by IG server-side. Cross-
/// references the circle catalog's first page (there's no "all circles for
/// IG X" endpoint) against the user's joined interest-group names: the two
/// endpoints only share IG identity via display name (`LearningCircle.ig`),
/// not id, so the match is name-based and case-/whitespace-insensitive.
@riverpod
Future<List<LearningCircle>> circlesForMyInterestGroups(Ref ref) async {
  final myIds = await ref.watch(myInterestGroupIdsProvider.future);
  if (myIds.isEmpty) return const [];

  final catalog = await ref.watch(interestGroupsCatalogProvider.future);
  final myNames = catalog
      .where((g) => myIds.contains(g.id))
      .map((g) => g.name.trim().toLowerCase())
      .toSet();
  if (myNames.isEmpty) return const [];

  final page = await ref.watch(learningCirclesRepositoryProvider).getCircles();
  return page.circles
      .where((c) => myNames.contains(c.ig.trim().toLowerCase()))
      .toList();
}
