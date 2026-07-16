import 'package:mulearn_app/core/models/location_option.dart';
import 'package:mulearn_app/core/models/reference_option.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'college_change_controller.g.dart';

// --- Reference-data lookups for the college-change picker. Each is a plain
// FutureProvider — Riverpod caches the result for the provider's lifetime. ---

@riverpod
Future<List<LocationOption>> profileCountries(Ref ref) =>
    ref.watch(profileRepositoryProvider).getCountries();

@riverpod
Future<List<LocationOption>> profileStates(Ref ref, String countryId) =>
    ref.watch(profileRepositoryProvider).getStates(countryId);

@riverpod
Future<List<LocationOption>> profileDistricts(Ref ref, String stateId) =>
    ref.watch(profileRepositoryProvider).getDistricts(stateId);

@riverpod
Future<
    ({
      List<ReferenceOption> organizations,
      List<ReferenceOption> departments,
    })> organizationsAndDepartments(Ref ref, String districtId) =>
    ref.watch(profileRepositoryProvider).getOrganizationsAndDepartments(
          districtId,
        );

@riverpod
Future<List<ReferenceOption>> communities(Ref ref) =>
    ref.watch(profileRepositoryProvider).getCommunities();

/// Submits the college-change request, then refreshes the main profile so
/// the sidebar reflects the new college/department.
@riverpod
class ChangeCollegeController extends _$ChangeCollegeController {
  @override
  Future<void> build() async {}

  Future<void> submit({
    required String orgId,
    required String departmentId,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(profileRepositoryProvider).changeCollege(
            orgId: orgId,
            departmentId: departmentId,
          );
      ref.invalidate(profileControllerProvider);
    });
  }
}
