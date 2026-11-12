import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_empty_state.dart';
import 'package:mulearn_app/features/notifications/presentation/providers/notifications_controller.dart';
import 'package:mulearn_app/features/notifications/presentation/widgets/notification_list_tile.dart';

/// Notification inbox (DESIGN_SPEC.md §2 "14 — Notifications").
///
/// No backend endpoint exists yet — this screen is real (entity +
/// repository + controller, all wired through Riverpod like every other
/// feature), just backed by a datasource that always returns an empty list
/// until the backend adds a `notifications` endpoint. See
/// [NotificationsRemoteDataSource] for the placeholder. Renders through the
/// existing [MuEmptyState] widget for that (today, permanent) empty case.
class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsState = ref.watch(notificationsControllerProvider);

    return Scaffold(
      backgroundColor: MuColors.canvas,
      appBar: AppBar(
        backgroundColor: MuColors.canvas,
        title: Text('Notifications', style: MuType.headline),
        actions: [
          TextButton(
            onPressed: () =>
                ref.read(notificationsControllerProvider.notifier).markAllRead(),
            child: Text(
              'Mark all read',
              style: MuType.bodyMed.copyWith(color: MuColors.primary),
            ),
          ),
          const SizedBox(width: MuSpace.xs),
        ],
      ),
      body: SafeArea(
        child: notificationsState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => ErrorRetryView(
            error: error,
            onRetry: () => ref.invalidate(notificationsControllerProvider),
          ),
          data: (notifications) {
            if (notifications.isEmpty) {
              return const MuEmptyState(
                icon: LucideIcons.bell,
                title: "You're all caught up",
                message: 'Notifications will show up here.',
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: MuSpace.s),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return NotificationListTile(
                  notification: notification,
                  onTap: () {
                    ref
                        .read(notificationsControllerProvider.notifier)
                        .markRead(notification.id);
                    final route = notification.targetRoute;
                    if (route != null) context.push(route);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
