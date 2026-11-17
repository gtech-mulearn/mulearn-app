// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_log_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The team activity log, page by page, for one [action] filter (`null` is
/// every action). Loads on open, on pull-to-refresh and on scroll-to-end;
/// nothing polls.

@ProviderFor(ActivityLogController)
final activityLogControllerProvider = ActivityLogControllerFamily._();

/// The team activity log, page by page, for one [action] filter (`null` is
/// every action). Loads on open, on pull-to-refresh and on scroll-to-end;
/// nothing polls.
final class ActivityLogControllerProvider
    extends
        $AsyncNotifierProvider<
          ActivityLogController,
          PagedState<ActivityEntry>
        > {
  /// The team activity log, page by page, for one [action] filter (`null` is
  /// every action). Loads on open, on pull-to-refresh and on scroll-to-end;
  /// nothing polls.
  ActivityLogControllerProvider._({
    required ActivityLogControllerFamily super.from,
    required String? super.argument,
  }) : super(
         retry: noRetry,
         name: r'activityLogControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$activityLogControllerHash();

  @override
  String toString() {
    return r'activityLogControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ActivityLogController create() => ActivityLogController();

  @override
  bool operator ==(Object other) {
    return other is ActivityLogControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$activityLogControllerHash() =>
    r'd78c1d873c288ae16659cc7e526cc9deaea102e9';

/// The team activity log, page by page, for one [action] filter (`null` is
/// every action). Loads on open, on pull-to-refresh and on scroll-to-end;
/// nothing polls.

final class ActivityLogControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          ActivityLogController,
          AsyncValue<PagedState<ActivityEntry>>,
          PagedState<ActivityEntry>,
          FutureOr<PagedState<ActivityEntry>>,
          String?
        > {
  ActivityLogControllerFamily._()
    : super(
        retry: noRetry,
        name: r'activityLogControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The team activity log, page by page, for one [action] filter (`null` is
  /// every action). Loads on open, on pull-to-refresh and on scroll-to-end;
  /// nothing polls.

  ActivityLogControllerProvider call(String? action) =>
      ActivityLogControllerProvider._(argument: action, from: this);

  @override
  String toString() => r'activityLogControllerProvider';
}

/// The team activity log, page by page, for one [action] filter (`null` is
/// every action). Loads on open, on pull-to-refresh and on scroll-to-end;
/// nothing polls.

abstract class _$ActivityLogController
    extends $AsyncNotifier<PagedState<ActivityEntry>> {
  late final _$args = ref.$arg as String?;
  String? get action => _$args;

  FutureOr<PagedState<ActivityEntry>> build(String? action);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<PagedState<ActivityEntry>>,
              PagedState<ActivityEntry>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<PagedState<ActivityEntry>>,
                PagedState<ActivityEntry>
              >,
              AsyncValue<PagedState<ActivityEntry>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
