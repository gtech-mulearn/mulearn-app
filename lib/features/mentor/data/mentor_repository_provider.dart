import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/features/mentor/data/datasources/mentor_remote_datasource.dart';
import 'package:mulearn_app/features/mentor/data/repositories/mentor_repository_impl.dart';
import 'package:mulearn_app/features/mentor/domain/repositories/mentor_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mentor_repository_provider.g.dart';

@riverpod
MentorRemoteDataSource mentorRemoteDataSource(Ref ref) => MentorRemoteDataSource(ref.watch(dioProvider));

/// Presentation depends on the [MentorRepository] contract (rules.md §2/§5).
@riverpod
MentorRepository mentorRepository(Ref ref) => MentorRepositoryImpl(ref.watch(mentorRemoteDataSourceProvider));
