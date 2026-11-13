import 'package:mulearn_app/core/utils/no_retry.dart';
import 'package:mulearn_app/features/campus/data/campus_repository_provider.dart';
import 'package:mulearn_app/features/campus/domain/entities/campus_student.dart';
import 'package:mulearn_app/features/campus/domain/entities/campus_summary.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'campus_overview_providers.g.dart';

@Riverpod(retry: noRetry)
Future<CampusSummary> campusSummary(Ref ref) => ref.watch(campusRepositoryProvider).getSummary();

@Riverpod(retry: noRetry)
Future<List<KarmaDay>> campusWeeklyKarma(Ref ref) => ref.watch(campusRepositoryProvider).getWeeklyKarma();

/// The five students with the most karma.
@Riverpod(retry: noRetry)
Future<List<CampusStudent>> campusTopStudents(Ref ref) async =>
    (await ref.watch(campusRepositoryProvider).getStudents(pageIndex: 1, perPage: 5)).items;
