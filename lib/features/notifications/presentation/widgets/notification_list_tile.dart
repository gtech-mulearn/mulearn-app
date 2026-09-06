import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/features/notifications/domain/entities/app_notification.dart';

/// One row in the notification inbox — icon-square colored by [kind],
/// title/body/timestamp, unread items lifted onto a white surface with a
/// small blue dot, read items muted flat against a hairline bg
/// (DESIGN_SPEC.md §2 "14 — Notifications").
class NotificationListTile extends StatelessWidget {
  const NotificationListTile({required this.notification, super.key, this.onTap});

  final AppNotification notification;
  final VoidCallback? onTap;

  static const _kindStyle = {
    NotificationKind.karma: (
      icon: LucideIcons.zap,
      bg: MuColors.primaryTint,
      fg: MuColors.primary,
    ),
    NotificationKind.level: (
      icon: LucideIcons.trophy,
      bg: MuColors.ink,
      fg: MuColors.karmaAccent,
    ),
    NotificationKind.circle: (
      icon: LucideIcons.users,
      bg: MuColors.successBg,
      fg: MuColors.success,
    ),
    NotificationKind.event: (
      icon: LucideIcons.calendarDays,
      bg: MuColors.warningBg,
      fg: MuColors.warning,
    ),
  };

  @override
  Widget build(BuildContext context) {
    final style = _kindStyle[notification.kind]!;
    final unread = !notification.read;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MuSpace.screenH, vertical: MuSpace.xs),
      child: Material(
        color: unread ? MuColors.surface : MuColors.hairline,
        borderRadius: BorderRadius.circular(MuRadius.inner),
        child: InkWell(
          borderRadius: BorderRadius.circular(MuRadius.inner),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(MuSpace.l),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    color: style.bg,
                    borderRadius: BorderRadius.circular(MuRadius.inner),
                  ),
                  child: Icon(style.icon, size: 20, color: style.fg),
                ),
                const SizedBox(width: MuSpace.m),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(notification.title, style: MuType.bodyMed),
                          ),
                          if (unread) ...[
                            const SizedBox(width: MuSpace.s),
                            Container(
                              height: 8,
                              width: 8,
                              margin: const EdgeInsets.only(top: 4),
                              decoration: const BoxDecoration(
                                color: MuColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: MuSpace.xs),
                      Text(notification.body, style: MuType.caption),
                      const SizedBox(height: MuSpace.xs),
                      Text(
                        _timeAgo(notification.timestamp),
                        style: MuType.caption.copyWith(color: MuColors.inkFaint),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Minimal relative-time formatter — no locale support needed here, just
/// the handful of buckets the design calls for ("12 minutes ago",
/// "Yesterday", "2 days ago"). Not worth pulling in a package for.
String _timeAgo(DateTime timestamp) {
  final diff = DateTime.now().difference(timestamp);
  if (diff.inMinutes < 1) return 'Just now';
  if (diff.inMinutes < 60) return '${diff.inMinutes} minutes ago';
  if (diff.inHours < 24) return '${diff.inHours} hours ago';
  if (diff.inDays == 1) return 'Yesterday';
  if (diff.inDays < 7) return '${diff.inDays} days ago';
  final weeks = diff.inDays ~/ 7;
  return weeks == 1 ? '1 week ago' : '$weeks weeks ago';
}
