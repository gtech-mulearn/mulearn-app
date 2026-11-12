import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/features/notifications/data/datasources/notifications_remote_datasource.dart';
import 'package:mulearn_app/features/notifications/data/repositories/notifications_repository_impl.dart';
import 'package:mulearn_app/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notifications_repository_provider.g.dart';

@riverpod
NotificationsRemoteDataSource notificationsRemoteDataSource(Ref ref) =>
    NotificationsRemoteDataSource(ref.watch(dioProvider));

/// Presentation depends on the [NotificationsRepository] contract
/// (rules.md §2/§5).
@riverpod
NotificationsRepository notificationsRepository(Ref ref) =>
    NotificationsRepositoryImpl(ref.watch(notificationsRemoteDataSourceProvider));
