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
import 'package:mulearn_app/core/notifications/push/push_controller.dart';
import 'package:mulearn_app/core/notifications/push/push_preferences.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/session/discord_connect.dart';
import 'package:mulearn_app/core/session/session_actions.dart';
import 'package:mulearn_app/core/session/session_providers.dart';
import 'package:mulearn_app/core/theme/appearance.dart';
import 'package:mulearn_app/core/utils/external_links.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mulearn_app/features/profile/presentation/providers/push_preferences_controller.dart';

/// Settings (artifact Screen patterns → Settings): grouped lists on cards.
/// Account (password, Discord), Privacy (public profile), Appearance
/// (System / Light / Dark), Legal, then Sign out (confirmed) and Delete
/// account through support (the backend's delete is a hard cascade; spec
/// §11). Rows are 56 tall with trailing values in `ink-3` and chevrons.
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

  void _showDeletion(BuildContext context, WidgetRef ref) {
    final muid = ref.read(currentUserProvider).value?.muid ?? '';
    final open = ref.read(openExternalProvider);
    unawaited(
      showMuSheet<void>(
        context,
        builder: (sheetContext) {
          final mu = sheetContext.mu;
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
                Text('Delete account', style: mu.text.title2),
                const SizedBox(height: MuSpacing.space2),
                Text(
                  "Contact support to delete your account. We'll confirm the request with you, "
                  "then permanently delete your account and its data. This can't be undone.",
                  style: mu.text.body.copyWith(color: c.ink2),
                ),
                const SizedBox(height: MuSpacing.space2),
                Text(
                  'Your email goes to ${AppLinks.supportEmail}.',
                  style: mu.text.caption,
                ),
                const SizedBox(height: MuSpacing.space5),
                MuButton(
                  label: 'Email support',
                  icon: LucideIcons.mail,
                  block: true,
                  onPressed: () {
                    unawaited(open(AppLinks.deletionRequest(muid)));
                    Navigator.of(sheetContext).pop();
                  },
                ),
              ],
            ),
          );
        },
      ),
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
                  const _NotificationsSection(),
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
                        onTap: () => _showDeletion(context, ref),
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

/// Settings → Notifications. Hidden in builds without push.
class _NotificationsSection extends ConsumerWidget {
  const _NotificationsSection();

  static String _hour(int h) {
    final suffix = h < 12 ? 'AM' : 'PM';
    final twelve = h % 12 == 0 ? 12 : h % 12;
    return '$twelve $suffix';
  }

  Future<void> _save(
    BuildContext context,
    WidgetRef ref,
    PushPreferences next,
    Map<String, Object?> patch,
  ) async {
    try {
      await ref
          .read(pushPreferencesControllerProvider.notifier)
          .save(next, patch);
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

  Future<void> _pickQuietHours(
    BuildContext context,
    WidgetRef ref,
    PushPreferences prefs,
  ) async {
    final from = await showTimePicker(
      context: context,
      helpText: 'Quiet from',
      initialTime: TimeOfDay(hour: prefs.quietStart, minute: 0),
    );
    if (from == null || !context.mounted) return;
    final to = await showTimePicker(
      context: context,
      helpText: 'Quiet until',
      initialTime: TimeOfDay(hour: prefs.quietEnd, minute: 0),
    );
    if (to == null || !context.mounted) return;
    await _save(
      context,
      ref,
      prefs.copyWith(quietStart: from.hour, quietEnd: to.hour),
      {'quiet_start': from.hour, 'quiet_end': to.hour},
    );
  }

  Future<void> _pickTopics(BuildContext context, WidgetRef ref) =>
      showMuSheet<void>(
        context,
        builder: (sheetContext) => Consumer(
          builder: (context, ref, _) {
            final prefs = ref.watch(pushPreferencesControllerProvider).value;
            if (prefs == null) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.fromLTRB(
                MuSpacing.space5,
                0,
                MuSpacing.space5,
                MuSpacing.space6,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('What to hear about', style: context.mu.text.title2),
                  const SizedBox(height: MuSpacing.space3),
                  for (final entry in pushCategoryLabels.entries)
                    MuSwitchTile(
                      label: entry.value,
                      value: !prefs.mutedCategories.contains(entry.key),
                      onChanged: (on) {
                        final muted = {...prefs.mutedCategories};
                        if (on) {
                          muted.remove(entry.key);
                        } else {
                          muted.add(entry.key);
                        }
                        final list = muted.toList()..sort();
                        unawaited(
                          _save(
                            context,
                            ref,
                            prefs.copyWith(mutedCategories: list),
                            {'muted_categories': list},
                          ),
                        );
                      },
                    ),
                ],
              ),
            );
          },
        ),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(pushControllerProvider).value;
    if (status == null || status == PushStatus.unavailable) {
      return const SizedBox.shrink();
    }
    final prefs = ref.watch(pushPreferencesControllerProvider).value;
    final muted = prefs?.mutedCategories.length ?? 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _SectionLabel('Notifications'),
        _Group(
          children: [
            _Row(
              icon: LucideIcons.smartphone,
              label: 'On this phone',
              value: switch (status) {
                PushStatus.granted => 'On',
                PushStatus.denied => 'Off in phone settings',
                _ => 'Off',
              },
              onTap: status == PushStatus.notDetermined
                  ? () => unawaited(
                      ref
                          .read(pushControllerProvider.notifier)
                          .requestPermission(),
                    )
                  : null,
            ),
            MuSwitchTile(
              label: 'Push notifications',
              subtitle: 'Circles, events, karma and announcements',
              value: prefs?.pushEnabled ?? false,
              onChanged: prefs == null
                  ? null
                  : (v) => unawaited(
                      _save(context, ref, prefs.copyWith(pushEnabled: v), {
                        'push_enabled': v,
                      }),
                    ),
            ),
            MuSwitchTile(
              label: 'Reminders',
              subtitle: 'Keep a streak going, or a nudge after a few days away',
              value:
                  (prefs?.pushEnabled ?? false) &&
                  (prefs?.engagementEnabled ?? false),
              onChanged: prefs == null || !prefs.pushEnabled
                  ? null
                  : (v) => unawaited(
                      _save(
                        context,
                        ref,
                        prefs.copyWith(engagementEnabled: v),
                        {'engagement_enabled': v},
                      ),
                    ),
            ),
            _Row(
              icon: LucideIcons.moon,
              label: 'Quiet hours',
              value: prefs == null
                  ? null
                  : '${_hour(prefs.quietStart)} – ${_hour(prefs.quietEnd)}',
              onTap: prefs == null
                  ? null
                  : () => unawaited(_pickQuietHours(context, ref, prefs)),
            ),
            _Row(
              icon: LucideIcons.listChecks,
              label: 'Topics',
              value: muted == 0 ? 'All' : '$muted muted',
              onTap: prefs == null
                  ? null
                  : () => unawaited(_pickTopics(context, ref)),
              last: true,
            ),
          ],
        ),
      ],
    );
  }
}
