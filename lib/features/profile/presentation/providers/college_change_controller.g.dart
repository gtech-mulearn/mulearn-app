// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'college_change_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(profileCountries)
const profileCountriesProvider = ProfileCountriesProvider._();

final class ProfileCountriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<LocationOption>>,
          List<LocationOption>,
          FutureOr<List<LocationOption>>
        >
    with
        $FutureModifier<List<LocationOption>>,
        $FutureProvider<List<LocationOption>> {
  const ProfileCountriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileCountriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileCountriesHash();

  @$internal
  @override
  $FutureProviderElement<List<LocationOption>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<LocationOption>> create(Ref ref) {
    return profileCountries(ref);
  }
}

String _$profileCountriesHash() => r'7df9b2c6f5da7f9d2eb800bd64a930620cb31b3f';

@ProviderFor(profileStates)
const profileStatesProvider = ProfileStatesFamily._();

final class ProfileStatesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<LocationOption>>,
          List<LocationOption>,
          FutureOr<List<LocationOption>>
        >
    with
        $FutureModifier<List<LocationOption>>,
        $FutureProvider<List<LocationOption>> {
  const ProfileStatesProvider._({
    required ProfileStatesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'profileStatesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$profileStatesHash();

  @override
  String toString() {
    return r'profileStatesProvider'
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
    return profileStates(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ProfileStatesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$profileStatesHash() => r'9f9b94e2133098d5b21afe1e22bf8b3b7e377ed1';

final class ProfileStatesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<LocationOption>>, String> {
  const ProfileStatesFamily._()
    : super(
        retry: null,
        name: r'profileStatesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProfileStatesProvider call(String countryId) =>
      ProfileStatesProvider._(argument: countryId, from: this);

  @override
  String toString() => r'profileStatesProvider';
}

@ProviderFor(profileDistricts)
const profileDistrictsProvider = ProfileDistrictsFamily._();

final class ProfileDistrictsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<LocationOption>>,
          List<LocationOption>,
          FutureOr<List<LocationOption>>
        >
    with
        $FutureModifier<List<LocationOption>>,
        $FutureProvider<List<LocationOption>> {
  const ProfileDistrictsProvider._({
    required ProfileDistrictsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'profileDistrictsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$profileDistrictsHash();

  @override
  String toString() {
    return r'profileDistrictsProvider'
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
    return profileDistricts(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ProfileDistrictsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$profileDistrictsHash() => r'540111b91db56bc39f055bf508e72ced207af077';

final class ProfileDistrictsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<LocationOption>>, String> {
  const ProfileDistrictsFamily._()
    : super(
        retry: null,
        name: r'profileDistrictsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProfileDistrictsProvider call(String stateId) =>
      ProfileDistrictsProvider._(argument: stateId, from: this);

  @override
  String toString() => r'profileDistrictsProvider';
}

@ProviderFor(organizationsAndDepartments)
const organizationsAndDepartmentsProvider =
    OrganizationsAndDepartmentsFamily._();

final class OrganizationsAndDepartmentsProvider
    extends
        $FunctionalProvider<
          AsyncValue<
            ({
              List<ReferenceOption> departments,
              List<ReferenceOption> organizations,
            })
          >,
          ({
            List<ReferenceOption> departments,
            List<ReferenceOption> organizations,
          }),
          FutureOr<
            ({
              List<ReferenceOption> departments,
              List<ReferenceOption> organizations,
            })
          >
        >
    with
        $FutureModifier<
          ({
            List<ReferenceOption> departments,
            List<ReferenceOption> organizations,
          })
        >,
        $FutureProvider<
          ({
            List<ReferenceOption> departments,
            List<ReferenceOption> organizations,
          })
        > {
  const OrganizationsAndDepartmentsProvider._({
    required OrganizationsAndDepartmentsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'organizationsAndDepartmentsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$organizationsAndDepartmentsHash();

  @override
  String toString() {
    return r'organizationsAndDepartmentsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<
    ({List<ReferenceOption> departments, List<ReferenceOption> organizations})
  >
  $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<
    ({List<ReferenceOption> departments, List<ReferenceOption> organizations})
  >
  create(Ref ref) {
    final argument = this.argument as String;
    return organizationsAndDepartments(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is OrganizationsAndDepartmentsProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$organizationsAndDepartmentsHash() =>
    r'28c47a4efc15a1221225b090d724a7a32bc1a632';

final class OrganizationsAndDepartmentsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<
            ({
              List<ReferenceOption> departments,
              List<ReferenceOption> organizations,
            })
          >,
          String
        > {
  const OrganizationsAndDepartmentsFamily._()
    : super(
        retry: null,
        name: r'organizationsAndDepartmentsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  OrganizationsAndDepartmentsProvider call(String districtId) =>
      OrganizationsAndDepartmentsProvider._(argument: districtId, from: this);

  @override
  String toString() => r'organizationsAndDepartmentsProvider';
}

@ProviderFor(communities)
const communitiesProvider = CommunitiesProvider._();

final class CommunitiesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ReferenceOption>>,
          List<ReferenceOption>,
          FutureOr<List<ReferenceOption>>
        >
    with
        $FutureModifier<List<ReferenceOption>>,
        $FutureProvider<List<ReferenceOption>> {
  const CommunitiesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'communitiesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$communitiesHash();

  @$internal
  @override
  $FutureProviderElement<List<ReferenceOption>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ReferenceOption>> create(Ref ref) {
    return communities(ref);
  }
}

String _$communitiesHash() => r'4eceed0f998a9f1adf8ba9d99c1330b78229466c';

/// Submits the college-change request, then refreshes the main profile so
/// the sidebar reflects the new college/department.

@ProviderFor(ChangeCollegeController)
const changeCollegeControllerProvider = ChangeCollegeControllerProvider._();

/// Submits the college-change request, then refreshes the main profile so
/// the sidebar reflects the new college/department.
final class ChangeCollegeControllerProvider
    extends $AsyncNotifierProvider<ChangeCollegeController, void> {
  /// Submits the college-change request, then refreshes the main profile so
  /// the sidebar reflects the new college/department.
  const ChangeCollegeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'changeCollegeControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$changeCollegeControllerHash();

  @$internal
  @override
  ChangeCollegeController create() => ChangeCollegeController();
}

String _$changeCollegeControllerHash() =>
    r'8cb9ae311586e17b9d68118a2ae9d0e3abad26ce';

/// Submits the college-change request, then refreshes the main profile so
/// the sidebar reflects the new college/department.

abstract class _$ChangeCollegeController extends $AsyncNotifier<void> {
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
