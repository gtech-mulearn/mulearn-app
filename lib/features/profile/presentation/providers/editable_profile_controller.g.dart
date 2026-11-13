// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editable_profile_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Pre-fill data + save action for the edit-profile form. Loaded fresh each
/// time the modal opens (`keepAlive: false`, the default) since it's a
/// one-shot form, not a cached read.

@ProviderFor(EditableProfileController)
const editableProfileControllerProvider = EditableProfileControllerProvider._();

/// Pre-fill data + save action for the edit-profile form. Loaded fresh each
/// time the modal opens (`keepAlive: false`, the default) since it's a
/// one-shot form, not a cached read.
final class EditableProfileControllerProvider
    extends $AsyncNotifierProvider<EditableProfileController, EditableProfile> {
  /// Pre-fill data + save action for the edit-profile form. Loaded fresh each
  /// time the modal opens (`keepAlive: false`, the default) since it's a
  /// one-shot form, not a cached read.
  const EditableProfileControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'editableProfileControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$editableProfileControllerHash();

  @$internal
  @override
  EditableProfileController create() => EditableProfileController();
}

String _$editableProfileControllerHash() =>
    r'd032386392e040717dee0a9aaca2e17d53fb8ae1';

/// Pre-fill data + save action for the edit-profile form. Loaded fresh each
/// time the modal opens (`keepAlive: false`, the default) since it's a
/// one-shot form, not a cached read.

abstract class _$EditableProfileController
    extends $AsyncNotifier<EditableProfile> {
  FutureOr<EditableProfile> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<EditableProfile>, EditableProfile>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<EditableProfile>, EditableProfile>,
              AsyncValue<EditableProfile>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
