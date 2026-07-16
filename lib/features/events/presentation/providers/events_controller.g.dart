// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(eventsRemoteDataSource)
const eventsRemoteDataSourceProvider = EventsRemoteDataSourceProvider._();

final class EventsRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          EventsRemoteDataSource,
          EventsRemoteDataSource,
          EventsRemoteDataSource
        >
    with $Provider<EventsRemoteDataSource> {
  const EventsRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventsRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventsRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<EventsRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EventsRemoteDataSource create(Ref ref) {
    return eventsRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EventsRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EventsRemoteDataSource>(value),
    );
  }
}

String _$eventsRemoteDataSourceHash() =>
    r'57b8b8b4b933237957efab8ef01b9592029af71d';

/// Presentation depends on the [EventsRepository] contract (rules.md §2/§5).

@ProviderFor(eventsRepository)
const eventsRepositoryProvider = EventsRepositoryProvider._();

/// Presentation depends on the [EventsRepository] contract (rules.md §2/§5).

final class EventsRepositoryProvider
    extends
        $FunctionalProvider<
          EventsRepository,
          EventsRepository,
          EventsRepository
        >
    with $Provider<EventsRepository> {
  /// Presentation depends on the [EventsRepository] contract (rules.md §2/§5).
  const EventsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventsRepositoryHash();

  @$internal
  @override
  $ProviderElement<EventsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EventsRepository create(Ref ref) {
    return eventsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EventsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EventsRepository>(value),
    );
  }
}

String _$eventsRepositoryHash() => r'cf8d4a0f65937e431bab8cf0291df0634b30eb6b';

@ProviderFor(eventDetail)
const eventDetailProvider = EventDetailFamily._();

final class EventDetailProvider
    extends $FunctionalProvider<AsyncValue<Event>, Event, FutureOr<Event>>
    with $FutureModifier<Event>, $FutureProvider<Event> {
  const EventDetailProvider._({
    required EventDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'eventDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$eventDetailHash();

  @override
  String toString() {
    return r'eventDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Event> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Event> create(Ref ref) {
    final argument = this.argument as String;
    return eventDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EventDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eventDetailHash() => r'ddf0a7cb9385aaf18b04e87d7e9817e195aced34';

final class EventDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Event>, String> {
  const EventDetailFamily._()
    : super(
        retry: null,
        name: r'eventDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EventDetailProvider call(String id) =>
      EventDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'eventDetailProvider';
}

/// Accumulates event pages across "load more" — mirrors [SearchController]'s
/// infinite-scroll pattern.

@ProviderFor(EventsListController)
const eventsListControllerProvider = EventsListControllerProvider._();

/// Accumulates event pages across "load more" — mirrors [SearchController]'s
/// infinite-scroll pattern.
final class EventsListControllerProvider
    extends $AsyncNotifierProvider<EventsListController, List<Event>> {
  /// Accumulates event pages across "load more" — mirrors [SearchController]'s
  /// infinite-scroll pattern.
  const EventsListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventsListControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventsListControllerHash();

  @$internal
  @override
  EventsListController create() => EventsListController();
}

String _$eventsListControllerHash() =>
    r'4dee95b6d1fb9baa575af4018f73031a0f891b27';

/// Accumulates event pages across "load more" — mirrors [SearchController]'s
/// infinite-scroll pattern.

abstract class _$EventsListController extends $AsyncNotifier<List<Event>> {
  FutureOr<List<Event>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Event>>, List<Event>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Event>>, List<Event>>,
              AsyncValue<List<Event>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Toggles interest for a single event, then invalidates the detail and
/// list providers so both reflect the new `viewerInterestStatus`.

@ProviderFor(EventInterestController)
const eventInterestControllerProvider = EventInterestControllerProvider._();

/// Toggles interest for a single event, then invalidates the detail and
/// list providers so both reflect the new `viewerInterestStatus`.
final class EventInterestControllerProvider
    extends $AsyncNotifierProvider<EventInterestController, void> {
  /// Toggles interest for a single event, then invalidates the detail and
  /// list providers so both reflect the new `viewerInterestStatus`.
  const EventInterestControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventInterestControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventInterestControllerHash();

  @$internal
  @override
  EventInterestController create() => EventInterestController();
}

String _$eventInterestControllerHash() =>
    r'e38b1036807d412dabe777dc6091e529560b6200';

/// Toggles interest for a single event, then invalidates the detail and
/// list providers so both reflect the new `viewerInterestStatus`.

abstract class _$EventInterestController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
