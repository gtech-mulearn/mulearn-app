import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/session/discord_connect.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/utils/external_links.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';

/// Where Discord's OAuth redirect lands (`/dashboard/connect-discord?code=`,
/// opened as an App Link). Sends the code to the backend once and shows the
/// outcome, like the dashboard's connect page.
class ConnectDiscordScreen extends ConsumerStatefulWidget {
  const ConnectDiscordScreen({this.code, super.key});

  final String? code;

  @override
  ConsumerState<ConnectDiscordScreen> createState() => _ConnectDiscordScreenState();
}

class _ConnectDiscordScreenState extends ConsumerState<ConnectDiscordScreen> {
  bool get _hasCode => (widget.code ?? '').isNotEmpty;

  @override
  void initState() {
    super.initState();
    if (_hasCode) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) unawaited(ref.read(discordConnectControllerProvider.notifier).connect(widget.code!));
      });
    }
  }

  void _startFlow() => unawaited(ref.read(discordConnectFlowProvider.notifier).start());

  /// Opened from a link, the screen is the whole stack: leave to Home.
  void _leave() => context.canPop() ? context.pop() : context.go(RoutePaths.home);

  Widget get _notNow => TextButton(onPressed: _leave, child: const Text('Not now'));

  @override
  Widget build(BuildContext context) {
    final available = ref.watch(discordAuthUriProvider) != null;
    final Widget body;
    if (!_hasCode) {
      body = _Outcome(
        icon: LucideIcons.messageCircle,
        title: 'Join the μLearn Discord',
        message: 'Link your Discord account to join the server, where task proof is posted and karma is counted.',
        actions: [
          if (available) MuPrimaryButton(label: 'Connect Discord', onPressed: _startFlow),
          const SizedBox(height: MuSpace.m),
          _notNow,
        ],
      );
    } else {
      final state = ref.watch(discordConnectControllerProvider);
      body = state.when(
        loading: () => const _Connecting(),
        error: (error, _) => _Outcome(
          icon: LucideIcons.xCircle,
          iconColor: MuColors.error,
          title: "Couldn't connect Discord",
          message: ApiException.messageFor(error),
          actions: [
            if (available) MuPrimaryButton(label: 'Try again', onPressed: _startFlow),
            const SizedBox(height: MuSpace.m),
            _notNow,
          ],
        ),
        data: (message) => message == null
            ? const _Connecting()
            : _Outcome(
                icon: LucideIcons.checkCircle2,
                iconColor: MuColors.success,
                title: 'Discord connected',
                message: message,
                actions: [
                  MuPrimaryButton(
                    label: 'Open the μLearn server',
                    onPressed: () => unawaited(ref.read(openExternalProvider)(discordServerInvite)),
                  ),
                  const SizedBox(height: MuSpace.m),
                  TextButton(onPressed: _leave, child: const Text('Done')),
                ],
              ),
      );
    }
    return Scaffold(
      backgroundColor: MuColors.canvas,
      appBar: AppBar(
        backgroundColor: MuColors.canvas,
        title: Text('Discord', style: MuType.headline),
        leading: context.canPop()
            ? null
            : IconButton(tooltip: 'Close', icon: const Icon(LucideIcons.x), onPressed: _leave),
      ),
      body: SafeArea(child: Padding(padding: const EdgeInsets.all(MuSpace.screenH), child: body)),
    );
  }
}

class _Connecting extends StatelessWidget {
  const _Connecting();

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: MuSpace.l),
            Text('Connecting your Discord account…', style: MuType.body.copyWith(color: MuColors.inkSecondary)),
          ],
        ),
      );
}

class _Outcome extends StatelessWidget {
  const _Outcome({
    required this.icon,
    required this.title,
    required this.message,
    required this.actions,
    this.iconColor = MuColors.primary,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String message;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(icon, size: 48, color: iconColor),
          const SizedBox(height: MuSpace.l),
          Text(title, style: MuType.headline, textAlign: TextAlign.center),
          const SizedBox(height: MuSpace.s),
          Text(message, style: MuType.body.copyWith(color: MuColors.inkSecondary), textAlign: TextAlign.center),
          const SizedBox(height: MuSpace.xl),
          ...actions,
        ],
      );
}
