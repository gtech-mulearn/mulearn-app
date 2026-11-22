import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/config/app_links.dart';
import 'package:mulearn_app/core/config/app_version.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/session/discord_connect.dart';
import 'package:mulearn_app/core/session/session_actions.dart';
import 'package:mulearn_app/core/session/session_providers.dart';
import 'package:mulearn_app/core/theme/appearance.dart';
import 'package:mulearn_app/core/utils/external_links.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_controller.dart';

/// Settings (artifact Screen patterns → Settings): grouped lists on cards.
/// Account (password, Discord), Privacy (public profile), Appearance
/// (System / Light / Dark), Safety and help (blocked users, contact
/// support), Legal, then Sign out (confirmed) and Delete account: confirmed
/// in the app, then support deletes it (the backend's delete is a hard
/// cascade; spec §11). Rows are 56 tall with trailing values in `ink-3` and
/// chevrons.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  Future<void> _togglePublic(
    BuildContext context,
    WidgetRef ref,
    bool value,
  ) async {
    try {
      await ref
          .read(profileControllerProvider.notifier)
          .togglePublic(isPublic: value);
    } on Object catch (e) {
      if (context.mounted) {
        MuToast.show(
          context,
          message: ApiException.messageFor(e),
          type: MuToastType.error,
        );
      }
    }
  }

  Future<void> _confirmSignOut(BuildContext context, WidgetRef ref) async {
    final confirmed = await showMuConfirm(
      context,
      title: 'Sign out?',
      body:
          "You'll need your email or muid and password, or Google, to come back.",
      confirmLabel: 'Sign out',
      destructive: true,
    );
    if (confirmed) await ref.read(sessionActionsProvider.notifier).signOut();
  }

  void _showDeletion(BuildContext context) {
    unawaited(
      showMuSheet<void>(context, builder: (_) => const _DeletionSheet()),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final c = mu.colors;
    final open = ref.watch(openExternalProvider);
    final needsDiscord = ref.watch(capabilitiesProvider).value?.needsDiscord;
    final isPublic = ref.watch(profileControllerProvider).value?.isPublic;
    final appearance = ref.watch(appearanceProvider);

    return Scaffold(
      backgroundColor: c.chalk,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MuTopBar.detail(title: 'Settings'),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  MuSpacing.space5,
                  MuSpacing.space2,
                  MuSpacing.space5,
                  MuSpacing.navClearance,
                ),
                children: [
                  const _SectionLabel('Account'),
                  _Group(
                    children: [
                      _Row(
                        icon: LucideIcons.keyRound,
                        label: 'Change password',
                        onTap: () => context.push(RoutePaths.settingsPassword),
                      ),
                      _Row(
                        icon: LucideIcons.messageCircle,
                        label: 'Discord',
                        value: switch (needsDiscord) {
                          null => null,
                          true => 'Not connected',
                          false => 'Connected',
                        },
                        onTap:
                            (needsDiscord ?? false) &&
                                ref.watch(discordAuthUriProvider) != null
                            ? () => unawaited(
                                ref
                                    .read(discordConnectFlowProvider.notifier)
                                    .start(),
                              )
                            : null,
                        last: true,
                      ),
                    ],
                  ),
                  const _SectionLabel('Privacy'),
                  _Group(
                    children: [
                      MuSwitchTile(
                        label: 'Public profile',
                        subtitle: 'Anyone with your link can see your profile',
                        value: isPublic ?? false,
                        onChanged: isPublic == null
                            ? null
                            : (v) => _togglePublic(context, ref, v),
                      ),
                    ],
                  ),
                  const _SectionLabel('Appearance'),
                  MuSegmented<ThemeMode>(
                    values: const [
                      ThemeMode.system,
                      ThemeMode.light,
                      ThemeMode.dark,
                    ],
                    selected: appearance,
                    label: (m) => switch (m) {
                      ThemeMode.system => 'System',
                      ThemeMode.light => 'Light',
                      ThemeMode.dark => 'Dark',
                    },
                    onChanged: (m) =>
                        unawaited(ref.read(appearanceProvider.notifier).set(m)),
                  ),
                  const _SectionLabel('Safety and help'),
                  _Group(
                    children: [
                      _Row(
                        icon: LucideIcons.userX,
                        label: 'Blocked users',
                        onTap: () => context.push(RoutePaths.settingsBlocked),
                      ),
                      _Row(
                        icon: LucideIcons.lifeBuoy,
                        label: 'Contact support',
                        external: true,
                        onTap: () => unawaited(
                          open(
                            Uri(scheme: 'mailto', path: AppLinks.supportEmail),
                          ),
                        ),
                        last: true,
                      ),
                    ],
                  ),
                  const _SectionLabel('Legal'),
                  _Group(
                    children: [
                      _Row(
                        icon: LucideIcons.shieldCheck,
                        label: 'Privacy policy',
                        external: true,
                        onTap: () => unawaited(open(AppLinks.privacyPolicy)),
                      ),
                      _Row(
                        icon: LucideIcons.fileText,
                        label: 'Terms and conditions',
                        external: true,
                        onTap: () => unawaited(open(AppLinks.terms)),
                        last: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: MuSpacing.space8),
                  _Group(
                    children: [
                      _Row(
                        icon: LucideIcons.logOut,
                        label: 'Sign out',
                        danger: true,
                        onTap: () => _confirmSignOut(context, ref),
                      ),
                      _Row(
                        icon: LucideIcons.trash2,
                        label: 'Delete account',
                        danger: true,
                        onTap: () => _showDeletion(context),
                        last: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: MuSpacing.space6),
                  const _VersionLine(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Delete account: the person types DELETE, then the request opens in their
/// mail app addressed to support, who delete the account after confirming.
class _DeletionSheet extends ConsumerStatefulWidget {
  const _DeletionSheet();

  @override
  ConsumerState<_DeletionSheet> createState() => _DeletionSheetState();
}

class _DeletionSheetState extends ConsumerState<_DeletionSheet> {
  final _confirm = TextEditingController();
  bool _requested = false;

  bool get _typed => _confirm.text.trim().toUpperCase() == 'DELETE';

  @override
  void dispose() {
    _confirm.dispose();
    super.dispose();
  }

  void _request() {
    final muid = ref.read(currentUserProvider).value?.muid ?? '';
    unawaited(ref.read(openExternalProvider)(AppLinks.deletionRequest(muid)));
    setState(() => _requested = true);
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        MuSpacing.space5,
        0,
        MuSpacing.space5,
        MuSpacing.space5,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            header: true,
            child: Text('Delete account', style: mu.text.title2),
          ),
          const SizedBox(height: MuSpacing.space2),
          if (!_requested) ...[
            Text(
              'This permanently deletes your account, profile, projects, '
              "comments and karma. It can't be undone.",
              style: mu.text.body.copyWith(color: c.ink2),
            ),
            const SizedBox(height: MuSpacing.space2),
            Text(
              'We confirm the request with you by email, then our team '
              'deletes your account (${AppLinks.supportEmail}).',
              style: mu.text.caption,
            ),
            const SizedBox(height: MuSpacing.space4),
            MuTextField(
              label: 'Type DELETE to confirm',
              controller: _confirm,
              textCapitalization: TextCapitalization.characters,
              textInputAction: TextInputAction.done,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: MuSpacing.space4),
            MuButton(
              label: 'Request deletion',
              icon: LucideIcons.trash2,
              block: true,
              onPressed: _typed ? _request : null,
            ),
          ] else ...[
            Text(
              'Your request is ready in your mail app. Send it to finish. '
              'We will confirm with you before deleting anything.',
              style: mu.text.body.copyWith(color: c.ink2),
            ),
            const SizedBox(height: MuSpacing.space5),
            MuButton(
              label: 'Done',
              variant: MuButtonVariant.outline,
              block: true,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ],
      ),
    );
  }
}

/// "μLearn 1.0.0-dev.84 (84)" under everything; tap copies it for a bug
/// report.
class _VersionLine extends ConsumerWidget {
  const _VersionLine();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final version = ref.watch(appVersionProvider).value;
    if (version == null) return const SizedBox.shrink();
    final text = 'μLearn ${version.label}';
    return Semantics(
      button: true,
      label: '$text. Copy version',
      excludeSemantics: true,
      child: InkWell(
        borderRadius: BorderRadius.circular(MuRadii.control),
        onTap: () async {
          await Clipboard.setData(ClipboardData(text: text));
          if (context.mounted) {
            MuToast.show(
              context,
              message: 'Version copied',
              type: MuToastType.success,
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: MuSpacing.space2),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: context.mu.text.caption,
          ),
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
    padding: const EdgeInsets.fromLTRB(
      MuSpacing.space1,
      MuSpacing.space6,
      MuSpacing.space1,
      MuSpacing.space2,
    ),
    child: Semantics(
      header: true,
      child: Text(
        text.toUpperCase(),
        style: context.mu.text.eyebrow.copyWith(color: context.mu.colors.ink3),
      ),
    ),
  );
}

/// Rows on one `surface` card.
class _Group extends StatelessWidget {
  const _Group({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: MuSpacing.space4),
    decoration: BoxDecoration(
      color: context.mu.colors.surface,
      borderRadius: BorderRadius.circular(MuRadii.card),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(children: children),
  );
}

/// A 56-tall settings row: icon, label, a trailing value in `ink-3`, then a
/// chevron (or an out-arrow for links that leave the app).
class _Row extends StatelessWidget {
  const _Row({
    required this.icon,
    required this.label,
    this.value,
    this.onTap,
    this.external = false,
    this.danger = false,
    this.last = false,
  });

  final IconData icon;
  final String label;
  final String? value;
  final VoidCallback? onTap;
  final bool external;
  final bool danger;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final fg = danger ? c.danger : c.ink;
    return Semantics(
      button: onTap != null,
      label: [label, ?value].join(', '),
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(minHeight: 56),
          decoration: BoxDecoration(
            border: last ? null : Border(bottom: BorderSide(color: c.line)),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: MuSizes.iconMd,
                color: danger ? c.danger : c.ink2,
              ),
              const SizedBox(width: MuSpacing.space3),
              Expanded(
                child: Text(
                  label,
                  style: mu.text.bodyStrong.copyWith(color: fg),
                ),
              ),
              if (value != null) ...[
                Text(value!, style: mu.text.body.copyWith(color: c.ink3)),
                const SizedBox(width: MuSpacing.space2),
              ],
              if (onTap != null)
                Icon(
                  external
                      ? LucideIcons.arrowUpRight
                      : LucideIcons.chevronRight,
                  size: MuSizes.iconSm,
                  color: c.ink3,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
