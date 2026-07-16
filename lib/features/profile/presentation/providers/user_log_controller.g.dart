// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_log_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userLog)
const userLogProvider = UserLogProvider._();

final class UserLogProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<UserLogEntry>>,
          List<UserLogEntry>,
          FutureOr<List<UserLogEntry>>
        >
    with
        $FutureModifier<List<UserLogEntry>>,
        $FutureProvider<List<UserLogEntry>> {
  const UserLogProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userLogProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userLogHash();

  @$internal
  @override
  $FutureProviderElement<List<UserLogEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<UserLogEntry>> create(Ref ref) {
    return userLog(ref);
  }
}

String _$userLogHash() => r'9d124fd1c27918e2678a42d0d040997124dc5fe0';
