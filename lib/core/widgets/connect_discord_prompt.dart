import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/session/discord_connect.dart';
import 'package:mulearn_app/core/session/session_providers.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';

/// Task proof is posted in the μLearn Discord, so karma needs the account in
/// the server (UX-02). Shows a Connect prompt while `needsDiscord`, else
/// [orElse].
class ConnectDiscordPrompt extends ConsumerWidget {
  const ConnectDiscordPrompt({required this.orElse, super.key});

  final Widget orElse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final needsDiscord = ref.watch(capabilitiesProvider).value?.needsDiscord ?? false;
    final available = ref.watch(discordAuthUriProvider) != null;
    if (!needsDiscord || !available) return orElse;
    return MuCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Connect Discord to earn karma', style: MuType.bodyMed),
          const SizedBox(height: MuSpace.xs),
          Text(
            'Proof is posted in the μLearn Discord server. Connect your account first so your karma counts.',
            style: MuType.caption.copyWith(color: MuColors.inkSecondary),
          ),
          const SizedBox(height: MuSpace.l),
          MuPrimaryButton(
            label: 'Connect Discord',
            icon: LucideIcons.messageCircle,
            onPressed: () => unawaited(ref.read(discordConnectFlowProvider.notifier).start()),
          ),
        ],
      ),
    );
  }
}
