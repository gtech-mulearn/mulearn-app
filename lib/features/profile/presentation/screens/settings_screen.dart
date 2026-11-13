import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/config/app_links.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/session/discord_connect.dart';
import 'package:mulearn_app/core/session/session_actions.dart';
import 'package:mulearn_app/core/session/session_providers.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/utils/external_links.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_controller.dart';

/// Account settings (UX-03, SEC-14; L19): password, connected accounts,
/// profile visibility, legal links, sign out, and account deletion through
/// support (the backend's delete is a hard cascade; spec §11).
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  Future<void> _togglePublic(BuildContext context, WidgetRef ref, bool value) async {
    try {
      await ref.read(profileControllerProvider.notifier).togglePublic(isPublic: value);
    } on Object catch (e) {
      if (context.mounted) MuToast.show(context, message: ApiException.messageFor(e), type: MuToastType.error);
    }
  }

  Future<void> _confirmSignOut(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign out?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Sign out')),
        ],
      ),
    );
    if (confirmed ?? false) await ref.read(sessionActionsProvider.notifier).signOut();
  }

  void _showDeletion(BuildContext context, WidgetRef ref) {
    final muid = ref.read(currentUserProvider).value?.muid ?? '';
    final open = ref.read(openExternalProvider);
    unawaited(showModalBottomSheet<void>(
      context: context,
      backgroundColor: MuColors.surface,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(MuSpace.screenH, 0, MuSpace.screenH, MuSpace.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Delete account', style: MuType.headline),
              const SizedBox(height: MuSpace.s),
              Text(
                "Contact support to delete your account. We'll confirm the request with you, "
                "then permanently delete your account and its data. This can't be undone.",
                style: MuType.body.copyWith(color: MuColors.inkSecondary),
              ),
              const SizedBox(height: MuSpace.s),
              Text(
                'Your email goes to ${AppLinks.supportEmail}.',
                style: MuType.caption.copyWith(color: MuColors.inkTertiary),
              ),
              const SizedBox(height: MuSpace.xl),
              MuPrimaryButton(
                label: 'Email support',
                icon: LucideIcons.mail,
                onPressed: () {
                  unawaited(open(AppLinks.deletionRequest(muid)));
                  Navigator.of(sheetContext).pop();
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final open = ref.watch(openExternalProvider);
    final needsDiscord = ref.watch(capabilitiesProvider).value?.needsDiscord;
    final isPublic = ref.watch(profileControllerProvider).value?.isPublic;

    return Scaffold(
      backgroundColor: MuColors.canvas,
      appBar: AppBar(backgroundColor: MuColors.canvas, title: Text('Settings', style: MuType.headline)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(MuSpace.screenH, MuSpace.s, MuSpace.screenH, MuSpace.navClearance),
          children: [
            const _SectionLabel('Account'),
            MuCard(
              padding: const EdgeInsets.symmetric(vertical: MuSpace.xs),
              child: Column(
                children: [
                  _SettingsRow(
                    icon: LucideIcons.keyRound,
                    label: 'Change password',
                    onTap: () => context.push(RoutePaths.settingsPassword),
                  ),
                  _SettingsRow(
                    icon: LucideIcons.messageCircle,
                    label: 'Discord',
                    onTap: (needsDiscord ?? false) && ref.watch(discordAuthUriProvider) != null
                        ? () => unawaited(ref.read(discordConnectFlowProvider.notifier).start())
                        : null,
                    trailing: Text(
                      switch (needsDiscord) { null => '', true => 'Not connected', false => 'Connected' },
                      style: MuType.caption.copyWith(color: MuColors.inkSecondary),
                    ),
                    isLast: true,
                  ),
                ],
              ),
            ),
            const _SectionLabel('Privacy'),
            MuCard(
              padding: const EdgeInsets.symmetric(vertical: MuSpace.xs),
              child: _SettingsRow(
                icon: LucideIcons.globe,
                label: 'Public profile',
                subtitle: 'Anyone with your link can see your profile',
                trailing: Switch(
                  value: isPublic ?? false,
                  onChanged: isPublic == null ? null : (v) => _togglePublic(context, ref, v),
                ),
                isLast: true,
              ),
            ),
            const _SectionLabel('Legal'),
            MuCard(
              padding: const EdgeInsets.symmetric(vertical: MuSpace.xs),
              child: Column(
                children: [
                  _SettingsRow(
                    icon: LucideIcons.shieldCheck,
                    label: 'Privacy policy',
                    onTap: () => unawaited(open(AppLinks.privacyPolicy)),
                    external: true,
                  ),
                  _SettingsRow(
                    icon: LucideIcons.fileText,
                    label: 'Terms and conditions',
                    onTap: () => unawaited(open(AppLinks.terms)),
                    external: true,
                    isLast: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: MuSpace.xl),
            MuCard(
              padding: const EdgeInsets.symmetric(vertical: MuSpace.xs),
              child: Column(
                children: [
                  _SettingsRow(
                    icon: LucideIcons.logOut,
                    label: 'Sign out',
                    iconColor: MuColors.error,
                    onTap: () => _confirmSignOut(context, ref),
                  ),
                  _SettingsRow(
                    icon: LucideIcons.trash2,
                    label: 'Delete account',
                    iconColor: MuColors.error,
                    onTap: () => _showDeletion(context, ref),
                    isLast: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(MuSpace.xs, MuSpace.xl, MuSpace.xs, MuSpace.s),
        child: Semantics(
          header: true,
          child: Text(text.toUpperCase(), style: MuType.caption.copyWith(color: MuColors.inkTertiary, fontWeight: FontWeight.w600)),
        ),
      );
}

/// One settings row, styled like Profile's quick-action rows.
class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.icon,
    required this.label,
    this.subtitle,
    this.onTap,
    this.trailing,
    this.iconColor,
    this.external = false,
    this.isLast = false,
  });

  final IconData icon;
  final String label;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Color? iconColor;
  final bool external;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final color = iconColor ?? MuColors.primary;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: MuSpace.l, vertical: MuSpace.m),
        decoration: BoxDecoration(
          border: isLast ? null : const Border(bottom: BorderSide(color: MuColors.hairline)),
        ),
        child: Row(
          children: [
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(MuRadius.inner),
              ),
              alignment: Alignment.center,
              child: Icon(icon, size: 18, color: color),
            ),
            const SizedBox(width: MuSpace.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: MuType.bodyMed),
                  if (subtitle != null)
                    Text(subtitle!, style: MuType.caption.copyWith(color: MuColors.inkSecondary)),
                ],
              ),
            ),
            if (trailing != null)
              trailing!
            else if (onTap != null)
              Icon(
                external ? LucideIcons.externalLink : LucideIcons.chevronRight,
                size: 18,
                color: MuColors.inkTertiary,
              ),
          ],
        ),
      ),
    );
  }
}
