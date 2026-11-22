import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/utils/no_retry.dart';
import 'package:mulearn_app/features/campus_profile/data/campus_profile_data.dart';
import 'package:mulearn_app/features/campus_profile/domain/entities/public_campus.dart';
import 'package:mulearn_app/features/campus_profile/domain/repositories/campus_profile_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'campus_profile_providers.g.dart';

@riverpod
CampusProfileRepository campusProfileRepository(Ref ref) =>
    CampusProfileRepositoryImpl(
      CampusProfileRemoteDataSource(ref.watch(dioProvider)),
    );

/// A college's public page.
@Riverpod(retry: noRetry)
Future<PublicCampus> publicCampus(Ref ref, String id) =>
    ref.watch(campusProfileRepositoryProvider).campus(id);

/// Its last seven days of karma.
@Riverpod(retry: noRetry)
Future<List<CampusKarmaDay>> publicCampusWeeklyKarma(Ref ref, String id) =>
    ref.watch(campusProfileRepositoryProvider).weeklyKarma(id);
