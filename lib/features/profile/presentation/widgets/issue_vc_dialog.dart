import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_achievement.dart';
import 'package:mulearn_app/features/profile/domain/entities/vc_credential_info.dart';
import 'package:mulearn_app/features/profile/domain/entities/vc_credential_type.dart';
import 'package:mulearn_app/features/profile/domain/entities/vc_subject_info.dart';
import 'package:mulearn_app/features/profile/presentation/providers/achievements_controller.dart';
import 'package:mulearn_app/features/profile/presentation/providers/vc_issuance_controller.dart';

/// Shows an already-issued credential's QR, or walks the user through
/// selecting a connected DID and issuing a new one — mirrors the reference
/// dashboard's `IssueVCModal`.
class IssueVcDialog extends ConsumerStatefulWidget {
  const IssueVcDialog({
    required this.achievement,
    required this.muid,
    required this.userName,
    super.key,
    this.userEmail,
  });

  final UserAchievement achievement;
  final String muid;
  final String userName;
  final String? userEmail;

  @override
  ConsumerState<IssueVcDialog> createState() => _IssueVcDialogState();
}

class _IssueVcDialogState extends ConsumerState<IssueVcDialog> {
  String? _selectedDid;

  Future<void> _issue(String did) async {
    final achievement = widget.achievement.achievement;
    await ref.read(vcIssuanceControllerProvider.notifier).issue(
          muid: widget.muid,
          achievementId: widget.achievement.id,
          subjectInfo: VcSubjectInfo(
            type: VcCredentialType.badge,
            did: did,
            name: widget.userName,
            email: widget.userEmail,
          ),
          credentialInfo: VcCredentialInfo(
            courseName: achievement.achievementName,
            name: achievement.achievementName,
            tags: achievement.tags,
            description: achievement.description ?? '',
          ),
          templateId: achievement.templateId ?? '',
        );
  }

  @override
  Widget build(BuildContext context) {
    final issuance = ref.watch(vcIssuanceControllerProvider);
    final alreadyIssued =
        widget.achievement.isIssued && widget.achievement.vcUrl != null;

    return AlertDialog(
      title: Text(alreadyIssued ? 'Credential' : 'Issue credential'),
      content: SizedBox(
        width: 380,
        child: alreadyIssued
            ? _IssuedView(vcUrl: widget.achievement.vcUrl!)
            : issuance.when(
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (error, _) =>
                    Text(ApiException.messageFor(error)),
                data: (issued) {
                  if (issued != null && issued.isNotEmpty) {
                    return _IssuedView(vcUrl: issued.first.message);
                  }
                  return _IssueForm(
                    muid: widget.muid,
                    achievementName: widget.achievement.achievement.achievementName,
                    selectedDid: _selectedDid,
                    onDidSelected: (did) => setState(() => _selectedDid = did),
                  );
                },
              ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(alreadyIssued ? 'Close' : 'Cancel'),
        ),
        if (!alreadyIssued && !(issuance.value?.isNotEmpty ?? false))
          Consumer(
            builder: (context, ref, _) {
              final didsAsync = ref.watch(connectedDidsProvider(widget.muid));
              final dids = didsAsync.value ?? [];
              final did = _selectedDid ?? dids.firstOrNull;
              return FilledButton(
                onPressed: (did == null || issuance.isLoading)
                    ? null
                    : () => _issue(did),
                child: issuance.isLoading
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Issue VC'),
              );
            },
          ),
      ],
    );
  }
}

class _IssueForm extends ConsumerWidget {
  const _IssueForm({
    required this.muid,
    required this.achievementName,
    required this.selectedDid,
    required this.onDidSelected,
  });

  final String muid;
  final String achievementName;
  final String? selectedDid;
  final ValueChanged<String> onDidSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final didsState = ref.watch(connectedDidsProvider(muid));

    return didsState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Text(ApiException.messageFor(error)),
      data: (dids) {
        if (dids.isEmpty) {
          return const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'No DID linked yet',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'To issue a Verifiable Credential, download the QSeverse app '
                'and log in with your μLearn account — your DID links '
                'automatically.',
                style: TextStyle(color: MulearnColors.gray600),
              ),
            ],
          );
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(achievementName,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            if (dids.length > 1)
              RadioGroup<String>(
                groupValue: selectedDid ?? dids.first,
                onChanged: (value) => onDidSelected(value!),
                child: Column(
                  children: [
                    for (final did in dids)
                      RadioListTile<String>(
                        value: did,
                        title: Text(
                          did.length > 30 ? '${did.substring(0, 30)}…' : did,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                  ],
                ),
              )
            else
              Text(
                'DID: ${dids.first}',
                style: const TextStyle(fontSize: 12),
              ),
          ],
        );
      },
    );
  }
}

class _IssuedView extends StatelessWidget {
  const _IssuedView({required this.vcUrl});

  final String vcUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 32),
        const SizedBox(height: 8),
        const Text('Credential issued — scan to add it to your wallet.'),
        const SizedBox(height: 12),
        CachedNetworkImage(imageUrl: vcUrl, height: 220, width: 220),
      ],
    );
  }
}
