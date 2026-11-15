// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_twitches_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(weeklyTwitchesRepository)
final weeklyTwitchesRepositoryProvider = WeeklyTwitchesRepositoryProvider._();

final class WeeklyTwitchesRepositoryProvider
    extends
        $FunctionalProvider<
          WeeklyTwitchesRepository,
          WeeklyTwitchesRepository,
          WeeklyTwitchesRepository
        >
    with $Provider<WeeklyTwitchesRepository> {
  WeeklyTwitchesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weeklyTwitchesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weeklyTwitchesRepositoryHash();

  @$internal
  @override
  $ProviderElement<WeeklyTwitchesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WeeklyTwitchesRepository create(Ref ref) {
    return weeklyTwitchesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WeeklyTwitchesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WeeklyTwitchesRepository>(value),
    );
  }
}

String _$weeklyTwitchesRepositoryHash() =>
    r'a48c3c761ec0a76e49bd1c9e05cee76dac723e16';

/// Today's and upcoming episodes of [show], soonest first. A show announces
/// a handful a month, so one page of 50 covers it.

@ProviderFor(twitchesComingUp)
final twitchesComingUpProvider = TwitchesComingUpFamily._();

/// Today's and upcoming episodes of [show], soonest first. A show announces
/// a handful a month, so one page of 50 covers it.

final class TwitchesComingUpProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TwitchEpisode>>,
          List<TwitchEpisode>,
          FutureOr<List<TwitchEpisode>>
        >
    with
        $FutureModifier<List<TwitchEpisode>>,
        $FutureProvider<List<TwitchEpisode>> {
  /// Today's and upcoming episodes of [show], soonest first. A show announces
  /// a handful a month, so one page of 50 covers it.
  TwitchesComingUpProvider._({
    required TwitchesComingUpFamily super.from,
    required TwitchShow super.argument,
  }) : super(
         retry: noRetry,
         name: r'twitchesComingUpProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$twitchesComingUpHash();

  @override
  String toString() {
    return r'twitchesComingUpProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<TwitchEpisode>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TwitchEpisode>> create(Ref ref) {
    final argument = this.argument as TwitchShow;
    return twitchesComingUp(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TwitchesComingUpProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$twitchesComingUpHash() => r'1087733f85b57d615fb962f9cd84fdf435b78431';

/// Today's and upcoming episodes of [show], soonest first. A show announces
/// a handful a month, so one page of 50 covers it.

final class TwitchesComingUpFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<TwitchEpisode>>, TwitchShow> {
  TwitchesComingUpFamily._()
    : super(
        retry: noRetry,
        name: r'twitchesComingUpProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Today's and upcoming episodes of [show], soonest first. A show announces
  /// a handful a month, so one page of 50 covers it.

  TwitchesComingUpProvider call(TwitchShow show) =>
      TwitchesComingUpProvider._(argument: show, from: this);

  @override
  String toString() => r'twitchesComingUpProvider';
}

/// Past episodes of [show], newest first, page by page.

@ProviderFor(TwitchesPast)
final twitchesPastProvider = TwitchesPastFamily._();

/// Past episodes of [show], newest first, page by page.
final class TwitchesPastProvider
    extends $AsyncNotifierProvider<TwitchesPast, PagedState<TwitchEpisode>> {
  /// Past episodes of [show], newest first, page by page.
  TwitchesPastProvider._({
    required TwitchesPastFamily super.from,
    required TwitchShow super.argument,
  }) : super(
         retry: noRetry,
         name: r'twitchesPastProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$twitchesPastHash();

  @override
  String toString() {
    return r'twitchesPastProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  TwitchesPast create() => TwitchesPast();

  @override
  bool operator ==(Object other) {
    return other is TwitchesPastProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$twitchesPastHash() => r'e3503289619a083e683042399839bbfab4236c3f';

/// Past episodes of [show], newest first, page by page.

final class TwitchesPastFamily extends $Family
    with
        $ClassFamilyOverride<
          TwitchesPast,
          AsyncValue<PagedState<TwitchEpisode>>,
          PagedState<TwitchEpisode>,
          FutureOr<PagedState<TwitchEpisode>>,
          TwitchShow
        > {
  TwitchesPastFamily._()
    : super(
        retry: noRetry,
        name: r'twitchesPastProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Past episodes of [show], newest first, page by page.

  TwitchesPastProvider call(TwitchShow show) =>
      TwitchesPastProvider._(argument: show, from: this);

  @override
  String toString() => r'twitchesPastProvider';
}

/// Past episodes of [show], newest first, page by page.

abstract class _$TwitchesPast
    extends $AsyncNotifier<PagedState<TwitchEpisode>> {
  late final _$args = ref.$arg as TwitchShow;
  TwitchShow get show => _$args;

  FutureOr<PagedState<TwitchEpisode>> build(TwitchShow show);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<PagedState<TwitchEpisode>>,
              PagedState<TwitchEpisode>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<PagedState<TwitchEpisode>>,
                PagedState<TwitchEpisode>
              >,
              AsyncValue<PagedState<TwitchEpisode>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

/// One episode (from a notification or a list row).

@ProviderFor(twitchEpisode)
final twitchEpisodeProvider = TwitchEpisodeFamily._();

/// One episode (from a notification or a list row).

final class TwitchEpisodeProvider
    extends
        $FunctionalProvider<
          AsyncValue<TwitchEpisode>,
          TwitchEpisode,
          FutureOr<TwitchEpisode>
        >
    with $FutureModifier<TwitchEpisode>, $FutureProvider<TwitchEpisode> {
  /// One episode (from a notification or a list row).
  TwitchEpisodeProvider._({
    required TwitchEpisodeFamily super.from,
    required (TwitchShow, String) super.argument,
  }) : super(
         retry: noRetry,
         name: r'twitchEpisodeProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$twitchEpisodeHash();

  @override
  String toString() {
    return r'twitchEpisodeProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<TwitchEpisode> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TwitchEpisode> create(Ref ref) {
    final argument = this.argument as (TwitchShow, String);
    return twitchEpisode(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is TwitchEpisodeProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$twitchEpisodeHash() => r'54d7c2341084415fed7d3a164cf2574025161eb1';

/// One episode (from a notification or a list row).

final class TwitchEpisodeFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<TwitchEpisode>,
          (TwitchShow, String)
        > {
  TwitchEpisodeFamily._()
    : super(
        retry: noRetry,
        name: r'twitchEpisodeProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// One episode (from a notification or a list row).

  TwitchEpisodeProvider call(TwitchShow show, String id) =>
      TwitchEpisodeProvider._(argument: (show, id), from: this);

  @override
  String toString() => r'twitchEpisodeProvider';
}
