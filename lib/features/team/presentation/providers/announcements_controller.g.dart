// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcements_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Announcements, page by page. Loads on open, on pull-to-refresh and on
/// scroll-to-end; nothing polls. Every change (send, edit, delete) is
/// followed by a refresh of the first page so the list shows the result.

@ProviderFor(AnnouncementsController)
final announcementsControllerProvider = AnnouncementsControllerProvider._();

/// Announcements, page by page. Loads on open, on pull-to-refresh and on
/// scroll-to-end; nothing polls. Every change (send, edit, delete) is
/// followed by a refresh of the first page so the list shows the result.
final class AnnouncementsControllerProvider
    extends
        $AsyncNotifierProvider<AnnouncementsController, AnnouncementsState> {
  /// Announcements, page by page. Loads on open, on pull-to-refresh and on
  /// scroll-to-end; nothing polls. Every change (send, edit, delete) is
  /// followed by a refresh of the first page so the list shows the result.
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
    r'12a37f5fe49c0405f6f4378aec19d892d9e3f293';

/// Announcements, page by page. Loads on open, on pull-to-refresh and on
/// scroll-to-end; nothing polls. Every change (send, edit, delete) is
/// followed by a refresh of the first page so the list shows the result.

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
