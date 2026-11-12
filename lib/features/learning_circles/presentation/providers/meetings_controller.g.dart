// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meetings_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// A circle's meetings, one page at a time — the same paging behaviour as
/// [CirclesListController]: keep-on-error, de-duplicated by id, and
/// concurrent [loadMore] calls share one request.

@ProviderFor(CircleMeetingsController)
const circleMeetingsControllerProvider = CircleMeetingsControllerFamily._();

/// A circle's meetings, one page at a time — the same paging behaviour as
/// [CirclesListController]: keep-on-error, de-duplicated by id, and
/// concurrent [loadMore] calls share one request.
final class CircleMeetingsControllerProvider
    extends
        $AsyncNotifierProvider<CircleMeetingsController, PagedState<Meeting>> {
  /// A circle's meetings, one page at a time — the same paging behaviour as
  /// [CirclesListController]: keep-on-error, de-duplicated by id, and
  /// concurrent [loadMore] calls share one request.
  const CircleMeetingsControllerProvider._({
    required CircleMeetingsControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'circleMeetingsControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$circleMeetingsControllerHash();

  @override
  String toString() {
    return r'circleMeetingsControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CircleMeetingsController create() => CircleMeetingsController();

  @override
  bool operator ==(Object other) {
    return other is CircleMeetingsControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$circleMeetingsControllerHash() =>
    r'365afd6146d6b09f3780b2474b873797f9270916';

/// A circle's meetings, one page at a time — the same paging behaviour as
/// [CirclesListController]: keep-on-error, de-duplicated by id, and
/// concurrent [loadMore] calls share one request.

final class CircleMeetingsControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          CircleMeetingsController,
          AsyncValue<PagedState<Meeting>>,
          PagedState<Meeting>,
          FutureOr<PagedState<Meeting>>,
          String
        > {
  const CircleMeetingsControllerFamily._()
    : super(
        retry: null,
        name: r'circleMeetingsControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// A circle's meetings, one page at a time — the same paging behaviour as
  /// [CirclesListController]: keep-on-error, de-duplicated by id, and
  /// concurrent [loadMore] calls share one request.

  CircleMeetingsControllerProvider call(String circleId) =>
      CircleMeetingsControllerProvider._(argument: circleId, from: this);

  @override
  String toString() => r'circleMeetingsControllerProvider';
}

/// A circle's meetings, one page at a time — the same paging behaviour as
/// [CirclesListController]: keep-on-error, de-duplicated by id, and
/// concurrent [loadMore] calls share one request.

abstract class _$CircleMeetingsController
    extends $AsyncNotifier<PagedState<Meeting>> {
  late final _$args = ref.$arg as String;
  String get circleId => _$args;

  FutureOr<PagedState<Meeting>> build(String circleId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref as $Ref<AsyncValue<PagedState<Meeting>>, PagedState<Meeting>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PagedState<Meeting>>, PagedState<Meeting>>,
              AsyncValue<PagedState<Meeting>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(meetingDetail)
const meetingDetailProvider = MeetingDetailFamily._();

final class MeetingDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<MeetingDetail>,
          MeetingDetail,
          FutureOr<MeetingDetail>
        >
    with $FutureModifier<MeetingDetail>, $FutureProvider<MeetingDetail> {
  const MeetingDetailProvider._({
    required MeetingDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'meetingDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$meetingDetailHash();

  @override
  String toString() {
    return r'meetingDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<MeetingDetail> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MeetingDetail> create(Ref ref) {
    final argument = this.argument as String;
    return meetingDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MeetingDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$meetingDetailHash() => r'71136dc73492da9c853e546d9b84b41ae3643834';

final class MeetingDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<MeetingDetail>, String> {
  const MeetingDetailFamily._()
    : super(
        retry: null,
        name: r'meetingDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MeetingDetailProvider call(String id) =>
      MeetingDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'meetingDetailProvider';
}

@ProviderFor(attendeeReport)
const attendeeReportProvider = AttendeeReportFamily._();

final class AttendeeReportProvider
    extends
        $FunctionalProvider<
          AsyncValue<AttendeeReport>,
          AttendeeReport,
          FutureOr<AttendeeReport>
        >
    with $FutureModifier<AttendeeReport>, $FutureProvider<AttendeeReport> {
  const AttendeeReportProvider._({
    required AttendeeReportFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'attendeeReportProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$attendeeReportHash();

  @override
  String toString() {
    return r'attendeeReportProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<AttendeeReport> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AttendeeReport> create(Ref ref) {
    final argument = this.argument as String;
    return attendeeReport(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AttendeeReportProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$attendeeReportHash() => r'a7c1bf063aaa309cd9fa50e57f809f8259b7aa36';

final class AttendeeReportFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<AttendeeReport>, String> {
  const AttendeeReportFamily._()
    : super(
        retry: null,
        name: r'attendeeReportProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AttendeeReportProvider call(String meetingId) =>
      AttendeeReportProvider._(argument: meetingId, from: this);

  @override
  String toString() => r'attendeeReportProvider';
}

@ProviderFor(meetingReport)
const meetingReportProvider = MeetingReportFamily._();

final class MeetingReportProvider
    extends
        $FunctionalProvider<
          AsyncValue<MeetingReport>,
          MeetingReport,
          FutureOr<MeetingReport>
        >
    with $FutureModifier<MeetingReport>, $FutureProvider<MeetingReport> {
  const MeetingReportProvider._({
    required MeetingReportFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'meetingReportProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$meetingReportHash();

  @override
  String toString() {
    return r'meetingReportProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<MeetingReport> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MeetingReport> create(Ref ref) {
    final argument = this.argument as String;
    return meetingReport(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MeetingReportProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$meetingReportHash() => r'236b4d4a0c373ef685f666bdd42a64de8f81571e';

final class MeetingReportFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<MeetingReport>, String> {
  const MeetingReportFamily._()
    : super(
        retry: null,
        name: r'meetingReportProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MeetingReportProvider call(String meetingId) =>
      MeetingReportProvider._(argument: meetingId, from: this);

  @override
  String toString() => r'meetingReportProvider';
}

/// Every meeting action (create/edit/delete/RSVP/join-by-code/leave/
/// reports) — a single notifier, mirroring [CircleActionsController].

@ProviderFor(MeetingActionsController)
const meetingActionsControllerProvider = MeetingActionsControllerProvider._();

/// Every meeting action (create/edit/delete/RSVP/join-by-code/leave/
/// reports) — a single notifier, mirroring [CircleActionsController].
final class MeetingActionsControllerProvider
    extends $AsyncNotifierProvider<MeetingActionsController, void> {
  /// Every meeting action (create/edit/delete/RSVP/join-by-code/leave/
  /// reports) — a single notifier, mirroring [CircleActionsController].
  const MeetingActionsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'meetingActionsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$meetingActionsControllerHash();

  @$internal
  @override
  MeetingActionsController create() => MeetingActionsController();
}

String _$meetingActionsControllerHash() =>
    r'269d95555c711efa8aa99668ec95b41ae01bd1ed';

/// Every meeting action (create/edit/delete/RSVP/join-by-code/leave/
/// reports) — a single notifier, mirroring [CircleActionsController].

abstract class _$MeetingActionsController extends $AsyncNotifier<void> {
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
