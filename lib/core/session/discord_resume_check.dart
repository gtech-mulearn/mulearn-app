import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/session/discord_connect.dart';

/// After the Discord flow sends the user to the browser, the next resume
/// re-checks the account once ([DiscordConnectFlow.onResume]).
class DiscordResumeCheck extends ConsumerStatefulWidget {
  const DiscordResumeCheck({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<DiscordResumeCheck> createState() => _DiscordResumeCheckState();
}

class _DiscordResumeCheckState extends ConsumerState<DiscordResumeCheck> {
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    _lifecycle = AppLifecycleListener(onResume: () => ref.read(discordConnectFlowProvider.notifier).onResume());
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
