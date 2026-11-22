import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/moderation/blocked_users.dart';

/// Settings → Blocked users: the people this user blocked on this device,
/// each with an Unblock button.
class BlockedUsersScreen extends ConsumerWidget {
  const BlockedUsersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final c = mu.colors;
    final blocked = ref.watch(blockedUsersProvider);
    return Scaffold(
      backgroundColor: c.chalk,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MuTopBar.detail(title: 'Blocked users'),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  MuSpacing.space5,
                  MuSpacing.space3,
                  MuSpacing.space5,
                  MuSpacing.space8,
                ),
                children: [
                  Text(
                    "You don't see projects, comments or profiles from people "
                    'you block. This list stays on this device.',
                    style: mu.text.body.copyWith(color: c.ink2),
                  ),
                  const SizedBox(height: MuSpacing.space5),
                  if (blocked.isEmpty)
                    const MuEmptyLine("You haven't blocked anyone.")
                  else
                    MuFeedGroup(
                      children: [
                        for (var i = 0; i < blocked.length; i++)
                          MuFeedRow(
                            leading: MuAvatar(
                              name: blocked[i].name.isEmpty
                                  ? (blocked[i].muid ?? '?')
                                  : blocked[i].name,
                              ring: false,
                            ),
                            subject: blocked[i].name.isEmpty
                                ? (blocked[i].muid ?? 'Blocked user')
                                : blocked[i].name,
                            time: blocked[i].muid,
                            divider: i < blocked.length - 1,
                            trailing: MuButton(
                              label: 'Unblock',
                              variant: MuButtonVariant.outline,
                              size: MuButtonSize.small,
                              onPressed: () => unawaited(
                                ref
                                    .read(blockedUsersProvider.notifier)
                                    .unblock(blocked[i]),
                              ),
                            ),
                          ),
                      ],
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
