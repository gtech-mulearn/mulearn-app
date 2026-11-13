import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/features/campus/data/datasources/campus_remote_datasource.dart';
import 'package:mulearn_app/features/campus/data/repositories/campus_repository_impl.dart';
import 'package:mulearn_app/features/campus/domain/repositories/campus_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'campus_repository_provider.g.dart';

@riverpod
CampusRemoteDataSource campusRemoteDataSource(Ref ref) => CampusRemoteDataSource(ref.watch(dioProvider));

/// Presentation depends on the [CampusRepository] contract (rules.md §2/§5).
@riverpod
CampusRepository campusRepository(Ref ref) => CampusRepositoryImpl(ref.watch(campusRemoteDataSourceProvider));
