// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workspace_access.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The signed-in user's role verification, read from the shared profile.

@ProviderFor(roleVerification)
final roleVerificationProvider = RoleVerificationProvider._();

/// The signed-in user's role verification, read from the shared profile.

final class RoleVerificationProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, bool>>,
          Map<String, bool>,
          FutureOr<Map<String, bool>>
        >
    with
        $FutureModifier<Map<String, bool>>,
        $FutureProvider<Map<String, bool>> {
  /// The signed-in user's role verification, read from the shared profile.
  RoleVerificationProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'roleVerificationProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$roleVerificationHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, bool>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, bool>> create(Ref ref) {
    return roleVerification(ref);
  }
}

String _$roleVerificationHash() => r'1e9f30c404a49ada902100344a4a4c802018bf7f';

/// [WorkspaceAccess] for the signed-in user; `null` when signed out. The
/// profile is read only for users holding a campus role.

@ProviderFor(workspaceAccess)
final workspaceAccessProvider = WorkspaceAccessProvider._();

/// [WorkspaceAccess] for the signed-in user; `null` when signed out. The
/// profile is read only for users holding a campus role.

final class WorkspaceAccessProvider
    extends
        $FunctionalProvider<
          AsyncValue<WorkspaceAccess?>,
          WorkspaceAccess?,
          FutureOr<WorkspaceAccess?>
        >
    with $FutureModifier<WorkspaceAccess?>, $FutureProvider<WorkspaceAccess?> {
  /// [WorkspaceAccess] for the signed-in user; `null` when signed out. The
  /// profile is read only for users holding a campus role.
  WorkspaceAccessProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'workspaceAccessProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workspaceAccessHash();

  @$internal
  @override
  $FutureProviderElement<WorkspaceAccess?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<WorkspaceAccess?> create(Ref ref) {
    return workspaceAccess(ref);
  }
}

String _$workspaceAccessHash() => r'9d6bb6f2fdec911f76e356db2b0f6aa4d7d10f2c';
