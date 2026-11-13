import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/external_links.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_session.dart';
import 'package:mulearn_app/features/mentor/domain/session_rules.dart';

/// A meeting link as a browser can open it. `meeting_link` is free text, so
/// "meet.google.com/abc" gets `https://`; only http(s) to a real host is
/// ever launched. Null when it isn't a web link.
Uri? launchableLink(String link) {
  final text = link.trim();
  if (text.isEmpty) return null;
  final hasScheme = RegExp('^[a-zA-Z][a-zA-Z0-9+.-]*:').hasMatch(text);
  final uri = Uri.tryParse(hasScheme ? text : 'https://$text');
  if (uri == null || (uri.scheme != 'https' && uri.scheme != 'http') || !uri.host.contains('.')) return null;
  return uri;
}

/// Opens a meeting link, or says it can't (never a silent no-op).
void openLink(BuildContext context, WidgetRef ref, String link) {
  final uri = launchableLink(link);
  if (uri == null) {
    MuToast.show(context, message: "This link can't be opened. Copy it instead.", type: MuToastType.error);
    return;
  }
  unawaited(ref.read(openExternalProvider)(uri));
}

/// The link without its scheme, for display: "meet.google.com/abc-defg".
String displayLink(String link) => link.replaceFirst(RegExp('^https?://'), '');

/// A session's meeting link where the mentor looks for it: the link itself,
/// Copy, and Join as the primary action from 15 minutes before the start
/// (Open link before then).
class MeetingLinkActions extends ConsumerWidget {
  const MeetingLinkActions({required this.session, this.compact = false, super.key});

  final MentorSession session;

  /// The hub's card: Join only when it's time, no link line.
  final bool compact;

  Future<void> _copy(BuildContext context, String link) async {
    await Clipboard.setData(ClipboardData(text: link));
    if (context.mounted) MuToast.show(context, message: 'Link copied', type: MuToastType.success);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final link = session.meetingLink;
    if (link == null) return const SizedBox.shrink();
    final joinable = canJoinSession(session, ref.watch(clockProvider)());
    if (compact) {
      return joinable
          ? Padding(
              padding: const EdgeInsets.only(top: MuSpace.m),
              child: MuPrimaryButton(label: 'Join session', icon: LucideIcons.video, onPressed: () => openLink(context, ref, link)),
            )
          : const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Icon(LucideIcons.link, size: 16, color: MuColors.inkSecondary),
            const SizedBox(width: MuSpace.s),
            Expanded(
              child: Text(displayLink(link), style: MuType.body, maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
            IconButton(
              tooltip: 'Copy link',
              icon: const Icon(LucideIcons.copy, size: 18, color: MuColors.inkSecondary),
              onPressed: () => unawaited(_copy(context, link)),
            ),
          ],
        ),
        if (joinable)
          MuPrimaryButton(label: 'Join session', icon: LucideIcons.video, onPressed: () => openLink(context, ref, link))
        else
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () => openLink(context, ref, link),
              icon: const Icon(LucideIcons.externalLink, size: 16),
              label: const Text('Open link'),
            ),
          ),
      ],
    );
  }
}

/// A venue with Directions (a maps search, so any maps app can take it).
class VenueRow extends ConsumerWidget {
  const VenueRow({required this.venue, super.key});

  final String venue;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Row(
        children: [
          const Icon(LucideIcons.mapPin, size: 16, color: MuColors.inkSecondary),
          const SizedBox(width: MuSpace.s),
          Expanded(child: Text(venue, style: MuType.body)),
          TextButton(
            onPressed: () => unawaited(ref.read(openExternalProvider)(
              Uri.https('www.google.com', '/maps/search/', {'api': '1', 'query': venue}),
            )),
            child: const Text('Directions'),
          ),
        ],
      );
}
