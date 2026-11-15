import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_achievement.dart';
import 'package:mulearn_app/features/profile/domain/entities/vc_credential_info.dart';
import 'package:mulearn_app/features/profile/domain/entities/vc_credential_type.dart';
import 'package:mulearn_app/features/profile/domain/entities/vc_subject_info.dart';
import 'package:mulearn_app/features/profile/presentation/providers/achievements_controller.dart';
import 'package:mulearn_app/features/profile/presentation/providers/vc_issuance_controller.dart';

/// Shows an already-issued credential's QR, or walks the user through
/// picking a connected DID and issuing one. Mirrors the reference
/// dashboard's `IssueVCModal`, as a sheet.
class IssueVcSheet extends ConsumerStatefulWidget {
  const IssueVcSheet({
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

  /// Opens the sheet over [context].
  static Future<void> show(
    BuildContext context, {
    required UserAchievement achievement,
    required String muid,
    required String userName,
    String? userEmail,
  }) => showMuSheet<void>(
    context,
    builder: (_) => IssueVcSheet(achievement: achievement, muid: muid, userName: userName, userEmail: userEmail),
  );

  @override
  ConsumerState<IssueVcSheet> createState() => _IssueVcSheetState();
}

class _IssueVcSheetState extends ConsumerState<IssueVcSheet> {
  String? _selectedDid;

  Future<void> _issue(String did) async {
    final achievement = widget.achievement.achievement;
    await ref
        .read(vcIssuanceControllerProvider.notifier)
        .issue(
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
    final mu = context.mu;
    final c = mu.colors;
    final issuance = ref.watch(vcIssuanceControllerProvider);
    final name = widget.achievement.achievement.achievementName;
    final issuedUrl = widget.achievement.isIssued && widget.achievement.vcUrl != null
        ? widget.achievement.vcUrl
        : issuance.value?.firstOrNull?.message;

    final Widget content;
    if (issuedUrl != null) {
      content = _Issued(vcUrl: issuedUrl);
    } else {
      final didsState = ref.watch(connectedDidsProvider(widget.muid));
      content = didsState.when(
        loading: () => const SizedBox(
          height: 160,
          child: Center(child: MuDotsLoader(label: 'Finding your wallet…')),
        ),
        error: (error, _) => _Message(
          icon: LucideIcons.alertCircle,
          title: "Couldn't reach your wallet",
          body: ApiException.messageFor(error),
          action: MuButton(
            label: 'Try again',
            variant: MuButtonVariant.outline,
            block: true,
            onPressed: () => ref.invalidate(connectedDidsProvider(widget.muid)),
          ),
        ),
        data: (dids) {
          if (dids.isEmpty) {
            return const _Message(
              icon: LucideIcons.wallet,
              title: 'Link a wallet first',
              body:
                  'Download the QSeverse app and sign in with your μLearn account. '
                  'Your DID links on its own, then come back here to issue.',
            );
          }
          final did = _selectedDid ?? dids.first;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Issue this badge as a verifiable credential to your wallet.',
                style: mu.text.body.copyWith(color: c.ink2),
              ),
              const SizedBox(height: MuSpacing.space4),
              if (dids.length > 1) ...[
                Text('WALLET', style: mu.text.eyebrow),
                const SizedBox(height: MuSpacing.space2),
                for (final d in dids) ...[
                  MuRadioCard<String>(
                    value: d,
                    groupValue: did,
                    title: _short(d),
                    icon: LucideIcons.wallet,
                    onChanged: issuance.isLoading ? null : (v) => setState(() => _selectedDid = v),
                  ),
                  const SizedBox(height: MuSpacing.space2),
                ],
              ] else
                _DidRow(did: did),
              if (issuance.hasError) ...[
                const SizedBox(height: MuSpacing.space3),
                Text(ApiException.messageFor(issuance.error!), style: mu.text.caption.copyWith(color: c.danger)),
              ],
              const SizedBox(height: MuSpacing.space4),
              MuButton(
                label: 'Issue credential',
                block: true,
                loading: issuance.isLoading,
                loadingLabel: 'Issuing…',
                onPressed: issuance.isLoading ? null : () => _issue(did),
              ),
            ],
          );
        },
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(MuSpacing.space5, 0, MuSpacing.space5, MuSpacing.space5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text((issuedUrl != null ? 'Credential' : 'Issue credential').toUpperCase(), style: mu.text.eyebrow),
          const SizedBox(height: 6),
          Semantics(header: true, child: Text(name, style: mu.text.title2)),
          const SizedBox(height: MuSpacing.space4),
          content,
        ],
      ),
    );
  }

  static String _short(String did) =>
      did.length > 32 ? '${did.substring(0, 20)}…${did.substring(did.length - 8)}' : did;
}

class _DidRow extends StatelessWidget {
  const _DidRow({required this.did});

  final String did;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    return Semantics(
      label: 'Wallet $did',
      excludeSemantics: true,
      child: Container(
        padding: const EdgeInsets.all(MuSpacing.space4),
        decoration: BoxDecoration(color: c.surfaceSunk, borderRadius: BorderRadius.circular(MuRadii.control)),
        child: Row(
          children: [
            Icon(LucideIcons.wallet, size: MuSizes.iconSm, color: c.ink3),
            const SizedBox(width: MuSpacing.space2),
            Expanded(
              child: Text(
                did,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: mu.text.codeSm.copyWith(color: c.ink2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({required this.icon, required this.title, required this.body, this.action});

  final IconData icon;
  final String title;
  final String body;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(color: c.surfaceSunk, shape: BoxShape.circle),
          child: Icon(icon, size: MuSizes.iconMd, color: c.ink2),
        ),
        const SizedBox(height: MuSpacing.space3),
        Text(title, style: mu.text.title3),
        const SizedBox(height: MuSpacing.space1),
        Text(body, style: mu.text.body.copyWith(color: c.ink2)),
        if (action != null) ...[const SizedBox(height: MuSpacing.space4), action!],
      ],
    );
  }
}

class _Issued extends StatelessWidget {
  const _Issued({required this.vcUrl});

  final String vcUrl;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    return Column(
      children: [
        Row(
          children: [
            Icon(LucideIcons.badgeCheck, size: MuSizes.iconMd, color: c.success),
            const SizedBox(width: MuSpacing.space2),
            Expanded(child: Text('Issued. Scan to add it to your wallet.', style: mu.text.bodyStrong)),
          ],
        ),
        const SizedBox(height: MuSpacing.space4),
        Semantics(
          image: true,
          label: 'Credential QR code',
          child: Container(
            padding: const EdgeInsets.all(MuSpacing.space3),
            decoration: BoxDecoration(
              // QR codes scan best dark-on-white, in either theme.
              color: c.onCobalt,
              borderRadius: BorderRadius.circular(MuRadii.card),
              border: Border.all(color: c.line),
            ),
            child: CachedNetworkImage(
              imageUrl: vcUrl,
              width: 220,
              height: 220,
              placeholder: (_, _) => const SizedBox.square(dimension: 220),
            ),
          ),
        ),
      ],
    );
  }
}
