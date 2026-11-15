import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/session/discord_connect.dart';
import 'package:mulearn_app/core/utils/external_links.dart';

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

  /// "Try again" returns through a new App Link to this same page (go_router
  /// keys the page by route pattern), so a changed code must start its own
  /// exchange; the controller still sends each code once.
  @override
  void didUpdateWidget(ConnectDiscordScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_hasCode && widget.code != oldWidget.code) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) unawaited(ref.read(discordConnectControllerProvider.notifier).connect(widget.code!));
      });
    }
  }

  void _startFlow() => unawaited(ref.read(discordConnectFlowProvider.notifier).start());

  /// Opened from a link, the screen is the whole stack: leave to Home.
  void _leave() => context.canPop() ? context.pop() : context.go(RoutePaths.home);

  Widget get _notNow => MuButton(label: 'Not now', variant: MuButtonVariant.ghost, block: true, onPressed: _leave);

  @override
  Widget build(BuildContext context) {
    final c = context.mu.colors;
    final available = ref.watch(discordAuthUriProvider) != null;
    final Widget body;
    if (!_hasCode) {
      body = _Outcome(
        icon: LucideIcons.messageCircle,
        tone: MuFeedTone.event,
        title: 'Join the μLearn Discord',
        message: 'Link your Discord account to join the server, where task proof is posted and karma is counted.',
        actions: [
          if (available) MuButton(label: 'Connect Discord', block: true, onPressed: _startFlow),
          _notNow,
        ],
      );
    } else {
      final state = ref.watch(discordConnectControllerProvider);
      body = state.when(
        loading: () => const _Connecting(),
        error: (error, _) => _Outcome(
          icon: LucideIcons.xCircle,
          tone: MuFeedTone.problem,
          title: "Couldn't connect Discord",
          message: ApiException.messageFor(error),
          actions: [
            if (available) MuButton(label: 'Try again', block: true, onPressed: _startFlow),
            _notNow,
          ],
        ),
        data: (message) => message == null
            ? const _Connecting()
            : _Outcome(
                icon: LucideIcons.checkCircle2,
                tone: MuFeedTone.done,
                title: 'Discord connected',
                message: message,
                actions: [
                  MuButton(
                    label: 'Open the μLearn server',
                    block: true,
                    knob: true,
                    onPressed: () => unawaited(ref.read(openExternalProvider)(discordServerInvite)),
                  ),
                  MuButton(label: 'Done', variant: MuButtonVariant.ghost, block: true, onPressed: _leave),
                ],
              ),
      );
    }

    return Scaffold(
      backgroundColor: c.chalk,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MuTopBar.detail(title: 'Discord', onBack: _leave),
            Expanded(
              child: Padding(padding: const EdgeInsets.all(MuSpacing.space5), child: body),
            ),
          ],
        ),
      ),
    );
  }
}

class _Connecting extends StatelessWidget {
  const _Connecting();

  @override
  Widget build(BuildContext context) => const Center(child: MuDotsLoader(label: 'Connecting your Discord account…'));
}

class _Outcome extends StatelessWidget {
  const _Outcome({
    required this.icon,
    required this.tone,
    required this.title,
    required this.message,
    required this.actions,
  });

  final IconData icon;
  final MuFeedTone tone;
  final String title;
  final String message;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(),
        Center(
          child: Transform.scale(scale: 2, child: MuFeedIcon(icon, tone: tone)),
        ),
        const SizedBox(height: MuSpacing.space10),
        Semantics(
          header: true,
          child: Text(title, style: mu.text.title1, textAlign: TextAlign.center),
        ),
        const SizedBox(height: MuSpacing.space2),
        Text(
          message,
          style: mu.text.body.copyWith(color: mu.colors.ink2),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        for (final a in actions) ...[a, const SizedBox(height: MuSpacing.space2)],
      ],
    );
  }
}
