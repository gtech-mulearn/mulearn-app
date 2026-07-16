import 'package:mulearn_app/core/data/location_remote_datasource.dart';
import 'package:mulearn_app/core/models/location_option.dart';
import 'package:mulearn_app/core/models/reference_option.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/features/auth/data/datasources/register_remote_datasource.dart';
import 'package:mulearn_app/features/auth/data/repositories/register_repository_impl.dart';
import 'package:mulearn_app/features/auth/domain/repositories/register_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_providers.g.dart';

@riverpod
RegisterRemoteDataSource registerRemoteDataSource(Ref ref) =>
    RegisterRemoteDataSource(ref.watch(dioProvider));

/// Presentation depends on the [RegisterRepository] contract (rules.md §2/§5).
@riverpod
RegisterRepository registerRepository(Ref ref) => RegisterRepositoryImpl(
      remote: ref.watch(registerRemoteDataSourceProvider),
      locationRemote: ref.watch(locationRemoteDataSourceProvider),
      tokenStorage: ref.watch(tokenStorageProvider),
    );

// --- Reference-data lookups. Each is a plain FutureProvider — Riverpod
// caches the result for the provider's lifetime, matching the reference
// client's `staleTime`-cached queries closely enough for a one-shot
// registration flow (no manual refetch needed). ---

@riverpod
Future<List<ReferenceOption>> registerRoles(Ref ref) =>
    ref.watch(registerRepositoryProvider).fetchRoles();

@riverpod
Future<List<ReferenceOption>> registerColleges(Ref ref) =>
    ref.watch(registerRepositoryProvider).fetchColleges();

@riverpod
Future<List<ReferenceOption>> registerDepartments(Ref ref) =>
    ref.watch(registerRepositoryProvider).fetchDepartments();

@riverpod
Future<List<ReferenceOption>> registerCompanies(Ref ref) =>
    ref.watch(registerRepositoryProvider).fetchCompanies();

@riverpod
Future<List<LocationOption>> registerCountries(Ref ref) =>
    ref.watch(registerRepositoryProvider).fetchCountries();

@riverpod
Future<List<LocationOption>> registerStates(Ref ref, String countryId) =>
    ref.watch(registerRepositoryProvider).fetchStates(countryId);

@riverpod
Future<List<LocationOption>> registerDistricts(Ref ref, String stateId) =>
    ref.watch(registerRepositoryProvider).fetchDistricts(stateId);

/// Resolves a role's DB UUID by case-insensitive title match, mirroring the
/// reference client's `roles.getRoleId(title)`. Returns null if the role list
/// hasn't loaded yet or no match is found.
String? resolveRoleId(List<ReferenceOption> roles, String title) {
  final normalized = title.toLowerCase();
  for (final role in roles) {
    if (role.title.toLowerCase() == normalized) return role.id;
  }
  return null;
}
