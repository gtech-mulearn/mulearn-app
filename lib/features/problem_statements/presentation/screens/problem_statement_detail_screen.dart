import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/utils/external_links.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_markdown.dart';
import 'package:mulearn_app/features/problem_statements/domain/entities/problem_statement.dart';
import 'package:mulearn_app/features/problem_statements/presentation/providers/problem_statements_providers.dart';
import 'package:mulearn_app/features/problem_statements/presentation/widgets/ps_labels.dart';

/// One problem statement: who posted it, what it asks, when it closes, how
/// many are on it, and your part pinned at the bottom: "I'm trying it",
/// then Submit solution (or Leave); once submitted, Update link (or
/// Withdraw). After the deadline a submission is locked.
class ProblemStatementDetailScreen extends ConsumerWidget {
  const ProblemStatementDetailScreen({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(problemStatementProvider(id));
    final statement = state.value;
    return Scaffold(
      backgroundColor: context.mu.colors.chalk,
      body: SafeArea(
        child: Column(
          children: [
            const MuTopBar.detail(),
            Expanded(
              child: state.when(
                loading: () => const Center(child: MuDotsLoader(label: 'Loading the problem…')),
                error: (e, _) => ErrorRetryView(error: e, onRetry: () => ref.invalidate(problemStatementProvider(id))),
                data: (s) => _Body(statement: s),
              ),
            ),
            if (statement != null) _ActionBar(statement: statement),
          ],
        ),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({required this.statement});

  final ProblemStatement statement;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final s = statement;
    final now = ref.watch(clockProvider)();
    final mine = ref.watch(myPsParticipationProvider(s.id)).value;
    final link = mine?.submissionUrl;
    return RefreshIndicator(
      onRefresh: () => Future.wait([
        ref.refresh(problemStatementProvider(s.id).future),
        ref.refresh(myPsParticipationProvider(s.id).future),
      ]),
      child: ListView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.fromLTRB(MuSpacing.space5, MuSpacing.space2, MuSpacing.space5, MuSpacing.space8),
        children: [
          Row(
            children: [
              MuAvatar(name: s.companyName, url: s.companyLogo, size: MuSizes.avatarMd, ring: false),
              const SizedBox(width: MuSpacing.space3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s.companyName, style: mu.text.bodyStrong),
                    Text(
                      s.publishedAt == null ? 'Problem statement' : 'Posted ${formatDay(s.publishedAt!)}',
                      style: mu.text.caption,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: MuSpacing.space4),
          Semantics(header: true, child: Text(s.title, style: mu.text.display.copyWith(fontSize: 30))),
          const SizedBox(height: MuSpacing.space3),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              ?psStatusPill(mine?.status ?? s.myStatus),
              if (s.category != null) MuPill(s.category!, tone: MuPillTone.cobalt),
              for (final skill in s.skills) MuPill(skill),
            ],
          ),
          const SizedBox(height: MuSpacing.space5),
          MuFeedGroup(
            children: [
              MuFeedRow(
                leading: MuFeedIcon(s.isOpen ? LucideIcons.clock : LucideIcons.lock, tone: MuFeedTone.event),
                subject: psDeadlineLabel(s, now),
                time: s.deadline == null ? 'Open until it is taken down' : formatDayTime(s.deadline!),
              ),
              MuFeedRow(
                leading: const MuFeedIcon(LucideIcons.users),
                subject: psPeopleLabel(s),
                time: 'Learners on this',
                divider: link != null,
              ),
              if (link != null)
                MuFeedRow(
                  leading: const MuFeedIcon(LucideIcons.link, tone: MuFeedTone.karma),
                  subject: 'Your solution',
                  time: mine?.submittedAt == null ? link : 'Sent ${formatDayTime(mine!.submittedAt!)}',
                  trailing: Icon(LucideIcons.arrowUpRight, size: MuSizes.iconSm, color: mu.colors.ink3),
                  divider: false,
                  onTap: () {
                    final uri = Uri.tryParse(link);
                    if (uri != null) unawaited(ref.read(openExternalProvider)(uri));
                  },
                ),
            ],
          ),
          if (s.description.isNotEmpty) ...[
            const MuSectionEyebrow('THE PROBLEM', top: MuSpacing.space6),
            MuMarkdown(s.description),
          ],
        ],
      ),
    );
  }
}

/// Your part, pinned: what you can do next depends on where you stand and
/// whether the statement is still open.
class _ActionBar extends ConsumerWidget {
  const _ActionBar({required this.statement});

  final ProblemStatement statement;

  Future<void> _act(BuildContext context, WidgetRef ref, Future<bool> Function(PsActions a) run, String done) async {
    final ok = await run(ref.read(psActionsProvider.notifier));
    if (!context.mounted) return;
    final error = ref.read(psActionsProvider).error;
    MuToast.show(
      context,
      message: ok ? done : ApiException.messageFor(error ?? "That didn't go through"),
      type: ok ? MuToastType.success : MuToastType.error,
    );
  }

  Future<void> _leave(BuildContext context, WidgetRef ref) async {
    final sure = await showMuConfirm(
      context,
      title: 'Leave this problem?',
      body: "You'll no longer be counted as trying it. You can come back while it's open.",
      confirmLabel: 'Leave',
      destructive: true,
    );
    if (sure && context.mounted) {
      await _act(context, ref, (a) => a.leave(statement.id), 'You left ${statement.title}');
    }
  }

  Future<void> _withdraw(BuildContext context, WidgetRef ref) async {
    final sure = await showMuConfirm(
      context,
      title: 'Withdraw your solution?',
      body: "Your link is removed and you're back to trying it. You can submit again before the deadline.",
      confirmLabel: 'Withdraw',
      destructive: true,
    );
    if (sure && context.mounted) {
      await _act(context, ref, (a) => a.withdraw(statement.id), 'Solution withdrawn');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final c = mu.colors;
    final s = statement;
    final mine = ref.watch(myPsParticipationProvider(s.id));
    final status = mine.value?.status ?? (mine.hasValue ? null : s.myStatus);
    final busy = ref.watch(psActionsProvider).isLoading;

    String? note;
    final buttons = <Widget>[];
    switch ((status, s.isOpen)) {
      case (null, true):
        buttons.add(
          MuButton(
            label: "I'm trying it",
            icon: LucideIcons.hammer,
            variant: MuButtonVariant.volt,
            block: true,
            loading: busy,
            onPressed: busy
                ? null
                : () =>
                      _act(context, ref, (a) => a.startTrying(s.id), "You're on it. Submit your link when it's ready."),
          ),
        );
      case (null, false):
        note = 'This problem is closed to new entries.';
      case (PsStatus.trying, true):
        buttons
          ..add(
            MuButton(
              label: 'Leave',
              variant: MuButtonVariant.outline,
              onPressed: busy ? null : () => _leave(context, ref),
            ),
          )
          ..add(
            Expanded(
              child: MuButton(
                label: 'Submit solution',
                icon: LucideIcons.send,
                block: true,
                loading: busy,
                onPressed: busy ? null : () => _SubmitSheet.show(context, s),
              ),
            ),
          );
      case (PsStatus.trying, false):
        note = 'The deadline has passed, so it no longer takes solutions.';
        buttons.add(
          MuButton(
            label: 'Leave',
            variant: MuButtonVariant.outline,
            block: true,
            onPressed: busy ? null : () => _leave(context, ref),
          ),
        );
      case (PsStatus.submitted, true):
        buttons
          ..add(
            MuButton(
              label: 'Withdraw',
              variant: MuButtonVariant.outline,
              onPressed: busy ? null : () => _withdraw(context, ref),
            ),
          )
          ..add(
            Expanded(
              child: MuButton(
                label: 'Update link',
                icon: LucideIcons.link,
                block: true,
                loading: busy,
                onPressed: busy ? null : () => _SubmitSheet.show(context, s, current: mine.value?.submissionUrl),
              ),
            ),
          );
      case (PsStatus.submitted, false):
        note = 'Submitted. The deadline has passed, so your link is locked in.';
    }
    if (buttons.isEmpty && note == null) return const SizedBox.shrink();

    return DecoratedBox(
      decoration: BoxDecoration(
        color: c.chalk,
        border: Border(top: BorderSide(color: c.line)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(MuSpacing.space5, MuSpacing.space3, MuSpacing.space5, MuSpacing.space3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (note != null) Text(note, style: mu.text.caption, textAlign: TextAlign.center),
            if (note != null && buttons.isNotEmpty) const SizedBox(height: MuSpacing.space2),
            if (buttons.length == 1)
              buttons.single
            else if (buttons.isNotEmpty)
              Row(
                children: [
                  buttons.first,
                  const SizedBox(width: MuSpacing.space3),
                  buttons.last,
                ],
              ),
          ],
        ),
      ),
    );
  }
}

/// Submit or replace the solution link: https only (a bare address gets
/// https:// added).
class _SubmitSheet extends ConsumerStatefulWidget {
  const _SubmitSheet({required this.statement, this.current});

  final ProblemStatement statement;
  final String? current;

  static Future<void> show(BuildContext context, ProblemStatement statement, {String? current}) => showMuSheet<void>(
    context,
    builder: (_) => _SubmitSheet(statement: statement, current: current),
  );

  @override
  ConsumerState<_SubmitSheet> createState() => _SubmitSheetState();
}

class _SubmitSheetState extends ConsumerState<_SubmitSheet> {
  final _formKey = GlobalKey<FormState>();
  late final _link = TextEditingController(text: widget.current ?? '');

  @override
  void dispose() {
    _link.dispose();
    super.dispose();
  }

  static String _https(String typed) {
    final t = typed.trim();
    if (t.startsWith('https://')) return t;
    if (t.startsWith('http://')) return 'https://${t.substring(7)}';
    return 'https://$t';
  }

  static String? _validate(String? v) {
    final s = v?.trim() ?? '';
    if (s.isEmpty) return 'Add the link to your solution';
    final uri = Uri.tryParse(_https(s));
    return uri == null || !uri.host.contains('.') ? 'That link looks incomplete' : null;
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final ok = await ref.read(psActionsProvider.notifier).submit(widget.statement.id, _https(_link.text));
    if (!mounted) return;
    final error = ref.read(psActionsProvider).error;
    MuToast.show(
      context,
      message: ok
          ? (widget.current == null ? 'Solution submitted' : 'Link updated')
          : ApiException.messageFor(error ?? "Couldn't submit"),
      type: ok ? MuToastType.success : MuToastType.error,
    );
    if (ok) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final busy = ref.watch(psActionsProvider).isLoading;
    return Form(
      key: _formKey,
      child: MuFormSheet(
        title: widget.current == null ? 'Submit your solution' : 'Update your link',
        lead:
            '${widget.statement.companyName} sees this link with your μLearn profile. '
            'You can change it until the deadline.',
        action: MuButton(
          label: widget.current == null ? 'Submit' : 'Save link',
          block: true,
          loading: busy,
          onPressed: busy ? null : _submit,
        ),
        children: [
          MuTextField(
            label: 'Solution link',
            controller: _link,
            hint: 'GitHub repo, demo or write-up',
            keyboardType: TextInputType.url,
            autofocus: true,
            validator: _validate,
          ),
        ],
      ),
    );
  }
}
