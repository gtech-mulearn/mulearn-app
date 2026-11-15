import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/external_links.dart';
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
    final mu = context.mu;
    final c = mu.colors;
    final link = session.meetingLink;
    if (link == null) return const SizedBox.shrink();
    final joinable = canJoinSession(session, ref.watch(clockProvider)());
    final join = MuButton(
      label: 'Join session',
      icon: LucideIcons.video,
      variant: MuButtonVariant.volt,
      block: true,
      onPressed: () => openLink(context, ref, link),
    );
    if (compact) {
      return joinable
          ? Padding(
              padding: const EdgeInsets.only(top: MuSpacing.space4),
              child: join,
            )
          : const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsetsDirectional.only(start: MuSpacing.space4, end: MuSpacing.space1),
          constraints: const BoxConstraints(minHeight: MuSizes.fieldH),
          decoration: BoxDecoration(color: c.surfaceSunk, borderRadius: BorderRadius.circular(MuRadii.control)),
          child: Row(
            children: [
              Icon(LucideIcons.link, size: MuSizes.iconSm, color: c.ink3),
              const SizedBox(width: MuSpacing.space2),
              Expanded(
                child: Text(
                  displayLink(link),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: mu.text.codeSm.copyWith(color: c.ink2),
                ),
              ),
              MuIconButton(
                icon: LucideIcons.copy,
                tooltip: 'Copy link',
                variant: MuIconButtonVariant.sunk,
                onPressed: () => unawaited(_copy(context, link)),
              ),
            ],
          ),
        ),
        const SizedBox(height: MuSpacing.space3),
        if (joinable)
          join
        else
          MuButton(
            label: 'Open link',
            icon: LucideIcons.externalLink,
            variant: MuButtonVariant.outline,
            block: true,
            onPressed: () => openLink(context, ref, link),
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
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    return Row(
      children: [
        Icon(LucideIcons.mapPin, size: MuSizes.iconSm, color: mu.colors.ink3),
        const SizedBox(width: MuSpacing.space2),
        Expanded(child: Text(venue, style: mu.text.body)),
        MuButton(
          label: 'Directions',
          icon: LucideIcons.navigation,
          variant: MuButtonVariant.ghost,
          size: MuButtonSize.small,
          onPressed: () => unawaited(
            ref.read(openExternalProvider)(Uri.https('www.google.com', '/maps/search/', {'api': '1', 'query': venue})),
          ),
        ),
      ],
    );
  }
}
