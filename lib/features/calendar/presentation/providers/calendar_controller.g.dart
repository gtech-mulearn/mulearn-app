// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(calendarRemoteDataSource)
const calendarRemoteDataSourceProvider = CalendarRemoteDataSourceProvider._();

final class CalendarRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          CalendarRemoteDataSource,
          CalendarRemoteDataSource,
          CalendarRemoteDataSource
        >
    with $Provider<CalendarRemoteDataSource> {
  const CalendarRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'calendarRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$calendarRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<CalendarRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CalendarRemoteDataSource create(Ref ref) {
    return calendarRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CalendarRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CalendarRemoteDataSource>(value),
    );
  }
}

String _$calendarRemoteDataSourceHash() =>
    r'080d25bedf2630056a12c8a9308d6371102145af';

/// Presentation depends on the [CalendarRepository] contract (rules.md
/// §2/§5).

@ProviderFor(calendarRepository)
const calendarRepositoryProvider = CalendarRepositoryProvider._();

/// Presentation depends on the [CalendarRepository] contract (rules.md
/// §2/§5).

final class CalendarRepositoryProvider
    extends
        $FunctionalProvider<
          CalendarRepository,
          CalendarRepository,
          CalendarRepository
        >
    with $Provider<CalendarRepository> {
  /// Presentation depends on the [CalendarRepository] contract (rules.md
  /// §2/§5).
  const CalendarRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'calendarRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$calendarRepositoryHash();

  @$internal
  @override
  $ProviderElement<CalendarRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CalendarRepository create(Ref ref) {
    return calendarRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CalendarRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CalendarRepository>(value),
    );
  }
}

String _$calendarRepositoryHash() =>
    r'419497a58a792dc9ae28873139ecfa6350d53570';

@ProviderFor(calendarEntries)
const calendarEntriesProvider = CalendarEntriesFamily._();

final class CalendarEntriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CalendarEntry>>,
          List<CalendarEntry>,
          FutureOr<List<CalendarEntry>>
        >
    with
        $FutureModifier<List<CalendarEntry>>,
        $FutureProvider<List<CalendarEntry>> {
  const CalendarEntriesProvider._({
    required CalendarEntriesFamily super.from,
    required ({DateTime start, DateTime end}) super.argument,
  }) : super(
         retry: null,
         name: r'calendarEntriesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$calendarEntriesHash();

  @override
  String toString() {
    return r'calendarEntriesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<CalendarEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CalendarEntry>> create(Ref ref) {
    final argument = this.argument as ({DateTime start, DateTime end});
    return calendarEntries(ref, start: argument.start, end: argument.end);
  }

  @override
  bool operator ==(Object other) {
    return other is CalendarEntriesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$calendarEntriesHash() => r'b8074e8670372a9782ed7fa5af50f14981381b48';

final class CalendarEntriesFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<CalendarEntry>>,
          ({DateTime start, DateTime end})
        > {
  const CalendarEntriesFamily._()
    : super(
        retry: null,
        name: r'calendarEntriesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CalendarEntriesProvider call({
    required DateTime start,
    required DateTime end,
  }) =>
      CalendarEntriesProvider._(argument: (start: start, end: end), from: this);

  @override
  String toString() => r'calendarEntriesProvider';
}

/// Tracks which month the calendar grid is currently showing — navigation
/// state only, the entries themselves are fetched by [calendarEntriesProvider]
/// keyed off the visible grid's date range.

@ProviderFor(CalendarMonthController)
const calendarMonthControllerProvider = CalendarMonthControllerProvider._();

/// Tracks which month the calendar grid is currently showing — navigation
/// state only, the entries themselves are fetched by [calendarEntriesProvider]
/// keyed off the visible grid's date range.
final class CalendarMonthControllerProvider
    extends $NotifierProvider<CalendarMonthController, DateTime> {
  /// Tracks which month the calendar grid is currently showing — navigation
  /// state only, the entries themselves are fetched by [calendarEntriesProvider]
  /// keyed off the visible grid's date range.
  const CalendarMonthControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'calendarMonthControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$calendarMonthControllerHash();

  @$internal
  @override
  CalendarMonthController create() => CalendarMonthController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime>(value),
    );
  }
}

String _$calendarMonthControllerHash() =>
    r'510161f7384a7ad4029f292b32836122125b5e49';

/// Tracks which month the calendar grid is currently showing — navigation
/// state only, the entries themselves are fetched by [calendarEntriesProvider]
/// keyed off the visible grid's date range.

abstract class _$CalendarMonthController extends $Notifier<DateTime> {
  DateTime build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<DateTime, DateTime>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTime, DateTime>,
              DateTime,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
