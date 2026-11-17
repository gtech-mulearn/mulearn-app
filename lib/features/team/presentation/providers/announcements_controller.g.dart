// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcements_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Announcements, page by page. Loads on open, on pull-to-refresh and on
/// scroll-to-end; nothing polls. An edit or a delete changes the loaded rows
/// in place, so later pages stay loaded; a send or a delete-all is followed
/// by a refresh of the first page.

@ProviderFor(AnnouncementsController)
final announcementsControllerProvider = AnnouncementsControllerProvider._();

/// Announcements, page by page. Loads on open, on pull-to-refresh and on
/// scroll-to-end; nothing polls. An edit or a delete changes the loaded rows
/// in place, so later pages stay loaded; a send or a delete-all is followed
/// by a refresh of the first page.
final class AnnouncementsControllerProvider
    extends
        $AsyncNotifierProvider<AnnouncementsController, AnnouncementsState> {
  /// Announcements, page by page. Loads on open, on pull-to-refresh and on
  /// scroll-to-end; nothing polls. An edit or a delete changes the loaded rows
  /// in place, so later pages stay loaded; a send or a delete-all is followed
  /// by a refresh of the first page.
  AnnouncementsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'announcementsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$announcementsControllerHash();

  @$internal
  @override
  AnnouncementsController create() => AnnouncementsController();
}

String _$announcementsControllerHash() =>
    r'347c13190145aae9a0da51e49500ea4c7e45f5e7';

/// Announcements, page by page. Loads on open, on pull-to-refresh and on
/// scroll-to-end; nothing polls. An edit or a delete changes the loaded rows
/// in place, so later pages stay loaded; a send or a delete-all is followed
/// by a refresh of the first page.

abstract class _$AnnouncementsController
    extends $AsyncNotifier<AnnouncementsState> {
  FutureOr<AnnouncementsState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<AnnouncementsState>, AnnouncementsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AnnouncementsState>, AnnouncementsState>,
              AsyncValue<AnnouncementsState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
