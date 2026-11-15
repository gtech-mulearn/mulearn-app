import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/features/calendar/data/datasources/calendar_remote_datasource.dart';
import 'package:mulearn_app/features/calendar/data/repositories/calendar_repository_impl.dart';
import 'package:mulearn_app/features/calendar/domain/entities/calendar_entry.dart';
import 'package:mulearn_app/features/calendar/domain/repositories/calendar_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'calendar_controller.g.dart';

@riverpod
CalendarRemoteDataSource calendarRemoteDataSource(Ref ref) =>
    CalendarRemoteDataSource(ref.watch(dioProvider));

/// Presentation depends on the [CalendarRepository] contract (rules.md
/// §2/§5).
@riverpod
CalendarRepository calendarRepository(Ref ref) =>
    CalendarRepositoryImpl(ref.watch(calendarRemoteDataSourceProvider));

@riverpod
Future<List<CalendarEntry>> calendarEntries(
  Ref ref, {
  required DateTime start,
  required DateTime end,
}) =>
    ref.watch(calendarRepositoryProvider).getEntries(start: start, end: end);
