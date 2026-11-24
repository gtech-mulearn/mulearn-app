import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/features/team/data/datasources/team_remote_datasource.dart';
import 'package:mulearn_app/features/team/data/repositories/team_repository_impl.dart';
import 'package:mulearn_app/features/team/domain/repositories/team_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'team_repository_provider.g.dart';

@riverpod
TeamRemoteDataSource teamRemoteDataSource(Ref ref) =>
    TeamRemoteDataSource(ref.watch(dioProvider));

/// Presentation depends on the [TeamRepository] contract (rules.md §2/§5).
@riverpod
TeamRepository teamRepository(Ref ref) =>
    TeamRepositoryImpl(ref.watch(teamRemoteDataSourceProvider));
