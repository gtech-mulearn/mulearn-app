import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/config/app_links.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/moderation/blocked_user.dart';
import 'package:mulearn_app/core/moderation/blocked_users.dart';
import 'package:mulearn_app/core/utils/external_links.dart';

/// What is being reported.
enum ModerationKind {
  /// A comment on a project.
  comment('comment'),

  /// A project.
  project('project'),

  /// A person's profile.
  profile('profile');

  const ModerationKind(this.label);

  /// Lowercase noun for sentences ("Report this comment").
  final String label;
}

const _reasons = <String>[
  'Spam or misleading',
  'Harassment or hate',
  'Inappropriate or adult content',
  'Something else',
];

/// Opens the report / block sheet for one piece of content or one person.
///
/// There is no report endpoint, so a report opens an email to support with the
/// content and reason filled in. Blocking is local: it hides the person's
/// content on this device, and can be undone from Settings.
Future<void> showModerationSheet(
  BuildContext context, {
  required ModerationKind kind,
  String? contentId,
  String? contentTitle,
  BlockedUser? author,
}) => showMuSheet<void>(
  context,
  builder: (_) => _ModerationSheet(
    parent: context,
    kind: kind,
    contentId: contentId,
    contentTitle: contentTitle,
    author: author,
  ),
);

class _ModerationSheet extends ConsumerWidget {
  const _ModerationSheet({
    required this.parent,
    required this.kind,
    required this.contentId,
    required this.contentTitle,
    required this.author,
  });

  final BuildContext parent;
  final ModerationKind kind;
  final String? contentId;
  final String? contentTitle;
  final BlockedUser? author;

  Future<void> _report(BuildContext context) async {
    Navigator.of(context).pop();
    if (!parent.mounted) return;
    await showMuSheet<void>(
      parent,
      builder: (_) => _ReasonSheet(
        parent: parent,
        kind: kind,
        contentId: contentId,
        contentTitle: contentTitle,
        author: author,
      ),
    );
  }

  Future<void> _block(BuildContext context, WidgetRef ref) async {
    final person = author!;
    final name = person.name.isEmpty ? 'this person' : person.name;
    // Read before the sheet closes: this widget is gone afterwards.
    final blocked = ref.read(blockedUsersProvider.notifier);
    Navigator.of(context).pop();
    if (!parent.mounted) return;
    final sure = await showMuConfirm(
      parent,
      title: 'Block $name?',
      body:
          "You won't see their projects, comments or profile in the app. "
          'You can unblock them in Settings.',
      confirmLabel: 'Block',
      destructive: true,
    );
    if (!sure) return;
    await blocked.block(person);
    if (!parent.mounted) return;
    MuToast.show(
      parent,
      message: '$name is blocked',
      type: MuToastType.success,
    );
  }

  Future<void> _unblock(BuildContext context, WidgetRef ref) async {
    final person = author!;
    final blocked = ref.read(blockedUsersProvider.notifier);
    Navigator.of(context).pop();
    await blocked.unblock(person);
    if (!parent.mounted) return;
    MuToast.show(parent, message: 'Unblocked', type: MuToastType.success);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final blocked = ref.watch(blockedUsersProvider);
    final person = author;
    final isBlocked =
        person != null && blocked.blocks(id: person.id, muid: person.muid);
    final canBlock =
        person != null && (person.id != null || person.muid != null);
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
          Semantics(
            header: true,
            child: Text('Report or block', style: mu.text.title3),
          ),
          const SizedBox(height: MuSpacing.space4),
          MuFeedGroup(
            children: [
              MuFeedRow(
                leading: const MuFeedIcon(
                  LucideIcons.flag,
                  tone: MuFeedTone.problem,
                ),
                subject: 'Report this ${kind.label}',
                time: "Tell us what's wrong",
                divider: canBlock,
                onTap: () => _report(context),
              ),
              if (canBlock)
                MuFeedRow(
                  leading: const MuFeedIcon(LucideIcons.userX),
                  subject: isBlocked
                      ? 'Unblock ${person.name.isEmpty ? 'this person' : person.name}'
                      : 'Block ${person.name.isEmpty ? 'this person' : person.name}',
                  time: isBlocked
                      ? 'Show their content again'
                      : 'Hide everything they post',
                  divider: false,
                  onTap: () =>
                      isBlocked ? _unblock(context, ref) : _block(context, ref),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReasonSheet extends ConsumerWidget {
  const _ReasonSheet({
    required this.parent,
    required this.kind,
    required this.contentId,
    required this.contentTitle,
    required this.author,
  });

  final BuildContext parent;
  final ModerationKind kind;
  final String? contentId;
  final String? contentTitle;
  final BlockedUser? author;

  Future<void> _send(BuildContext context, WidgetRef ref, String reason) async {
    final open = ref.read(openExternalProvider);
    Navigator.of(context).pop();
    final who = author == null
        ? null
        : [
            author!.name,
            author!.muid,
          ].whereType<String>().where((s) => s.isNotEmpty).join(' · ');
    unawaited(
      open(
        AppLinks.contentReport(
          kind: kind.label,
          reason: reason,
          contentId: contentId,
          contentTitle: contentTitle,
          author: who,
        ),
      ),
    );
    if (!parent.mounted) return;
    MuToast.show(parent, message: 'Send the email to finish your report');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
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
          Semantics(
            header: true,
            child: Text('Why are you reporting this?', style: mu.text.title3),
          ),
          const SizedBox(height: MuSpacing.space2),
          Text(
            'Your report opens an email to our team at ${AppLinks.supportEmail}. '
            'We review every report.',
            style: mu.text.body.copyWith(color: mu.colors.ink2),
          ),
          const SizedBox(height: MuSpacing.space4),
          MuFeedGroup(
            children: [
              for (var i = 0; i < _reasons.length; i++)
                MuFeedRow(
                  leading: const MuFeedIcon(LucideIcons.flag),
                  subject: _reasons[i],
                  divider: i < _reasons.length - 1,
                  onTap: () => _send(context, ref, _reasons[i]),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
