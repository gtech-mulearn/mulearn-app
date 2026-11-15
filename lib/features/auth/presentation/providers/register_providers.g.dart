// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(registerRemoteDataSource)
const registerRemoteDataSourceProvider = RegisterRemoteDataSourceProvider._();

final class RegisterRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          RegisterRemoteDataSource,
          RegisterRemoteDataSource,
          RegisterRemoteDataSource
        >
    with $Provider<RegisterRemoteDataSource> {
  const RegisterRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registerRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registerRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<RegisterRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RegisterRemoteDataSource create(Ref ref) {
    return registerRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RegisterRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RegisterRemoteDataSource>(value),
    );
  }
}

String _$registerRemoteDataSourceHash() =>
    r'691e4d56bd11b0711d49437f7858ed2afa59e8bc';

/// Presentation depends on the [RegisterRepository] contract (rules.md §2/§5).

@ProviderFor(registerRepository)
const registerRepositoryProvider = RegisterRepositoryProvider._();

/// Presentation depends on the [RegisterRepository] contract (rules.md §2/§5).

final class RegisterRepositoryProvider
    extends
        $FunctionalProvider<
          RegisterRepository,
          RegisterRepository,
          RegisterRepository
        >
    with $Provider<RegisterRepository> {
  /// Presentation depends on the [RegisterRepository] contract (rules.md §2/§5).
  const RegisterRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registerRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registerRepositoryHash();

  @$internal
  @override
  $ProviderElement<RegisterRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RegisterRepository create(Ref ref) {
    return registerRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RegisterRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RegisterRepository>(value),
    );
  }
}

String _$registerRepositoryHash() =>
    r'89e5898755955fdc9f058a3a1f8f20deeb3218b4';

@ProviderFor(registerRoles)
const registerRolesProvider = RegisterRolesProvider._();

final class RegisterRolesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ReferenceOption>>,
          List<ReferenceOption>,
          FutureOr<List<ReferenceOption>>
        >
    with
        $FutureModifier<List<ReferenceOption>>,
        $FutureProvider<List<ReferenceOption>> {
  const RegisterRolesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registerRolesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registerRolesHash();

  @$internal
  @override
  $FutureProviderElement<List<ReferenceOption>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ReferenceOption>> create(Ref ref) {
    return registerRoles(ref);
  }
}

String _$registerRolesHash() => r'86ce19920b449b9150bb1198611d128b53093339';

@ProviderFor(registerColleges)
const registerCollegesProvider = RegisterCollegesProvider._();

final class RegisterCollegesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ReferenceOption>>,
          List<ReferenceOption>,
          FutureOr<List<ReferenceOption>>
        >
    with
        $FutureModifier<List<ReferenceOption>>,
        $FutureProvider<List<ReferenceOption>> {
  const RegisterCollegesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registerCollegesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registerCollegesHash();

  @$internal
  @override
  $FutureProviderElement<List<ReferenceOption>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ReferenceOption>> create(Ref ref) {
    return registerColleges(ref);
  }
}

String _$registerCollegesHash() => r'b3f38c5173c2f5b911beb422a7fdee3e5c13b69d';

@ProviderFor(registerDepartments)
const registerDepartmentsProvider = RegisterDepartmentsProvider._();

final class RegisterDepartmentsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ReferenceOption>>,
          List<ReferenceOption>,
          FutureOr<List<ReferenceOption>>
        >
    with
        $FutureModifier<List<ReferenceOption>>,
        $FutureProvider<List<ReferenceOption>> {
  const RegisterDepartmentsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registerDepartmentsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registerDepartmentsHash();

  @$internal
  @override
  $FutureProviderElement<List<ReferenceOption>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ReferenceOption>> create(Ref ref) {
    return registerDepartments(ref);
  }
}

String _$registerDepartmentsHash() =>
    r'd89849226a1632446a33bcdd5b4001e4a39cdc30';

@ProviderFor(registerCompanies)
const registerCompaniesProvider = RegisterCompaniesProvider._();

final class RegisterCompaniesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ReferenceOption>>,
          List<ReferenceOption>,
          FutureOr<List<ReferenceOption>>
        >
    with
        $FutureModifier<List<ReferenceOption>>,
        $FutureProvider<List<ReferenceOption>> {
  const RegisterCompaniesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registerCompaniesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registerCompaniesHash();

  @$internal
  @override
  $FutureProviderElement<List<ReferenceOption>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ReferenceOption>> create(Ref ref) {
    return registerCompanies(ref);
  }
}

String _$registerCompaniesHash() => r'0612c6e5992eb5681abe3fceb2fd68e03bbd265f';

@ProviderFor(registerCountries)
const registerCountriesProvider = RegisterCountriesProvider._();

final class RegisterCountriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<LocationOption>>,
          List<LocationOption>,
          FutureOr<List<LocationOption>>
        >
    with
        $FutureModifier<List<LocationOption>>,
        $FutureProvider<List<LocationOption>> {
  const RegisterCountriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registerCountriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registerCountriesHash();

  @$internal
  @override
  $FutureProviderElement<List<LocationOption>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<LocationOption>> create(Ref ref) {
    return registerCountries(ref);
  }
}

String _$registerCountriesHash() => r'3f7a7d3f9cd8e70cceac3a369064d75d1432bcc3';

@ProviderFor(registerStates)
const registerStatesProvider = RegisterStatesFamily._();

final class RegisterStatesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<LocationOption>>,
          List<LocationOption>,
          FutureOr<List<LocationOption>>
        >
    with
        $FutureModifier<List<LocationOption>>,
        $FutureProvider<List<LocationOption>> {
  const RegisterStatesProvider._({
    required RegisterStatesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'registerStatesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$registerStatesHash();

  @override
  String toString() {
    return r'registerStatesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<LocationOption>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<LocationOption>> create(Ref ref) {
    final argument = this.argument as String;
    return registerStates(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RegisterStatesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$registerStatesHash() => r'8018a3dc071dbf581d41239766094994fb6a4a87';

final class RegisterStatesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<LocationOption>>, String> {
  const RegisterStatesFamily._()
    : super(
        retry: null,
        name: r'registerStatesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RegisterStatesProvider call(String countryId) =>
      RegisterStatesProvider._(argument: countryId, from: this);

  @override
  String toString() => r'registerStatesProvider';
}

@ProviderFor(registerDistricts)
const registerDistrictsProvider = RegisterDistrictsFamily._();

final class RegisterDistrictsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<LocationOption>>,
          List<LocationOption>,
          FutureOr<List<LocationOption>>
        >
    with
        $FutureModifier<List<LocationOption>>,
        $FutureProvider<List<LocationOption>> {
  const RegisterDistrictsProvider._({
    required RegisterDistrictsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'registerDistrictsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$registerDistrictsHash();

  @override
  String toString() {
    return r'registerDistrictsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<LocationOption>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<LocationOption>> create(Ref ref) {
    final argument = this.argument as String;
    return registerDistricts(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RegisterDistrictsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$registerDistrictsHash() => r'c86ed1a116108e672b81601f8571aeaddca5b06f';

final class RegisterDistrictsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<LocationOption>>, String> {
  const RegisterDistrictsFamily._()
    : super(
        retry: null,
        name: r'registerDistrictsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RegisterDistrictsProvider call(String stateId) =>
      RegisterDistrictsProvider._(argument: stateId, from: this);

  @override
  String toString() => r'registerDistrictsProvider';
}
