// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badges_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(badges)
const badgesProvider = BadgesFamily._();

final class BadgesProvider
    extends
        $FunctionalProvider<
          AsyncValue<BadgesData>,
          BadgesData,
          FutureOr<BadgesData>
        >
    with $FutureModifier<BadgesData>, $FutureProvider<BadgesData> {
  const BadgesProvider._({
    required BadgesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'badgesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$badgesHash();

  @override
  String toString() {
    return r'badgesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<BadgesData> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<BadgesData> create(Ref ref) {
    final argument = this.argument as String;
    return badges(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is BadgesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$badgesHash() => r'8d83f086cd30eb9f6a9611a076e943dbfb82209b';

final class BadgesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<BadgesData>, String> {
  const BadgesFamily._()
    : super(
        retry: null,
        name: r'badgesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BadgesProvider call(String muid) =>
      BadgesProvider._(argument: muid, from: this);

  @override
  String toString() => r'badgesProvider';
}
