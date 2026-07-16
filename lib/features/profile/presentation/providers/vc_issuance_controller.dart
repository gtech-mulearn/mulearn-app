import 'package:mulearn_app/features/profile/domain/entities/issued_vc.dart';
import 'package:mulearn_app/features/profile/domain/entities/vc_credential_info.dart';
import 'package:mulearn_app/features/profile/domain/entities/vc_subject_info.dart';
import 'package:mulearn_app/features/profile/presentation/providers/achievements_controller.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vc_issuance_controller.g.dart';

/// Issues a Verifiable Credential via QSeverse, then persists the resulting
/// URL against the achievement — the two-step flow the reference dashboard's
/// `issueVC` + `updateVCURL` calls form together.
@riverpod
class VcIssuanceController extends _$VcIssuanceController {
  @override
  Future<List<IssuedVc>?> build() async => null;

  Future<void> issue({
    required String muid,
    required String achievementId,
    required VcSubjectInfo subjectInfo,
    required VcCredentialInfo credentialInfo,
    required String templateId,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(profileRepositoryProvider);
      final issued = await repo.issueVc(
        subjectInfo: subjectInfo,
        credentialInfo: credentialInfo,
        templateId: templateId,
      );
      // Confirmed against the reference dashboard's use-profile-mutations.ts
      // (`useIssueVCMutation`): the persisted "VC URL" is
      // `subject_info.s3_url`. `message` is a separate one-time QR image
      // shown only in the immediate post-issuance UI, not what's saved.
      final vcUrl = issued.firstOrNull?.subjectInfo.s3Url;
      if (vcUrl != null) {
        await repo.saveIssuedVcUrl(achievementId: achievementId, vcUrl: vcUrl);
      }
      ref.invalidate(userAchievementsProvider(muid));
      return issued;
    });
  }
}
