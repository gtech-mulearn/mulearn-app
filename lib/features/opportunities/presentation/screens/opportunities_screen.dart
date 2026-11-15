import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/utils/search_debouncer.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_load_more_footer.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/features/opportunities/domain/entities/job.dart';
import 'package:mulearn_app/features/opportunities/presentation/providers/opportunities_controller.dart';

/// "Hybrid", "Full time", "Internship" from the backend's job type.
String _type(String? raw) => (raw ?? '').replaceAll(RegExp('[_-]'), ' ').trim();

/// Type · place · pay, the way a listing reads.
String _terms(Job j) => [
  if (_type(j.jobType).isNotEmpty) _type(j.jobType),
  if (j.location != null) j.location!,
  if (j.stipend != null)
    'Stipend ${j.stipend}'
  else if (j.salaryRange != null)
    j.salaryRange!
  else if (j.hourlyRate != null)
    '₹${j.hourlyRate}/hr',
].join(' · ');

/// The pill for where an application stands.
Widget statusPill(ApplicationStatus s, String raw) => switch (s) {
  ApplicationStatus.pending => const MuPill(
    'Applied',
    tone: MuPillTone.cobalt,
    icon: LucideIcons.send,
  ),
  ApplicationStatus.inReview => const MuPill(
    'In review',
    tone: MuPillTone.warning,
    icon: LucideIcons.eye,
  ),
  ApplicationStatus.shortlisted => const MuPill(
    'Shortlisted',
    tone: MuPillTone.success,
    icon: LucideIcons.star,
  ),
  ApplicationStatus.interview => const MuPill(
    'Interview',
    tone: MuPillTone.warning,
    icon: LucideIcons.calendar,
  ),
  ApplicationStatus.selected => const MuPill(
    'Selected',
    tone: MuPillTone.success,
    icon: LucideIcons.badgeCheck,
  ),
  ApplicationStatus.rejected => const MuPill(
    'Not selected',
    tone: MuPillTone.danger,
    icon: LucideIcons.x,
  ),
  ApplicationStatus.withdrawn => const MuPill('Withdrawn'),
  ApplicationStatus.unknown => MuPill(raw),
};

enum _Tab { browse, mine }

/// Opportunities (artifact OpportunityRow): internships, jobs and gigs from
/// verified companies as plain listing rows, and the learner's own
/// applications. A row opens the job; Apply asks for a resume link.
class OpportunitiesScreen extends ConsumerStatefulWidget {
  const OpportunitiesScreen({super.key});

  @override
  ConsumerState<OpportunitiesScreen> createState() =>
      _OpportunitiesScreenState();
}

class _OpportunitiesScreenState extends ConsumerState<OpportunitiesScreen> {
  final _search = TextEditingController();
  final _scroll = ScrollController();
  late final _debouncer = SearchDebouncer((q) {
    if (mounted) setState(() => _query = q);
  });
  String _query = '';
  _Tab _tab = _Tab.browse;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(() {
      if (_tab != _Tab.browse) return;
      final paged = ref.read(jobsControllerProvider(_query)).value;
      if (paged == null || paged.loadMoreError != null) return;
      if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 200) {
        unawaited(ref.read(jobsControllerProvider(_query).notifier).loadMore());
      }
    });
  }

  @override
  void dispose() {
    _debouncer.dispose();
    _search.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _onSearch(String text) => _debouncer.onChanged(text);

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final applications = ref.watch(myJobApplicationsProvider);
    final mine = applications.value ?? const <JobApplication>[];
    final byJob = {for (final a in mine) a.job.id: a};

    return Scaffold(
      backgroundColor: c.chalk,
      body: SafeArea(
        bottom: false,
        child: MuRefresh(
          onRefresh: () => Future.wait([
            ref.refresh(jobsControllerProvider(_query).future),
            ref.refresh(myJobApplicationsProvider.future),
          ]),
          child: ListView(
            controller: _scroll,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: const EdgeInsets.fromLTRB(
              MuSpacing.space5,
              MuSpacing.space2,
              MuSpacing.space5,
              0,
            ),
            children: [
              if (Navigator.of(context).canPop()) ...[
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: MuIconButton(
                    icon: LucideIcons.arrowLeft,
                    tooltip: 'Back',
                    onPressed: () => context.pop(),
                  ),
                ),
                const SizedBox(height: MuSpacing.space3),
              ],
              Semantics(
                header: true,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Put your karma\n',
                        style: mu.text.displayLight.copyWith(fontSize: 36),
                      ),
                      TextSpan(
                        text: 'to work',
                        style: mu.text.display.copyWith(fontSize: 36),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: MuSpacing.space2),
              Text(
                'Internships, jobs and gigs from verified companies. Some ask for a level or karma first.',
                style: mu.text.body.copyWith(color: c.ink2),
              ),
              const SizedBox(height: MuSpacing.space5),
              MuSegmented<_Tab>(
                values: _Tab.values,
                selected: _tab,
                label: (t) => t == _Tab.browse
                    ? 'Browse'
                    : (mine.isEmpty ? 'Applied' : 'Applied · ${mine.length}'),
                onChanged: (t) => setState(() => _tab = t),
              ),
              const SizedBox(height: MuSpacing.space4),
              if (_tab == _Tab.browse) ...[
                MuSearchField(
                  controller: _search,
                  hint: 'Search roles, companies, places',
                  onChanged: _onSearch,
                ),
                const SizedBox(height: MuSpacing.space4),
                _JobsList(query: _query, byJob: byJob),
              ] else
                _MyApplications(
                  onBrowse: () => setState(() => _tab = _Tab.browse),
                ),
              const SizedBox(height: MuSpacing.navClearance),
            ],
          ),
        ),
      ),
    );
  }
}

class _JobsList extends ConsumerWidget {
  const _JobsList({required this.query, required this.byJob});

  final String query;
  final Map<String, JobApplication> byJob;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(jobsControllerProvider(query));
    final paged = state.value;

    if (paged == null) {
      if (state.hasError) {
        return ErrorRetryView(
          error: state.error!,
          onRetry: () => ref.invalidate(jobsControllerProvider(query)),
        );
      }
      return const Padding(
        padding: EdgeInsets.all(MuSpacing.space8),
        child: Center(child: MuDotsLoader(label: 'Finding openings…')),
      );
    }
    if (paged.items.isEmpty) {
      return MuStateDisplay(
        variant: MuStateVariant.noResults,
        size: MuStateSize.sm,
        title: query.isEmpty ? 'No openings right now' : null,
        description: query.isEmpty
            ? 'New ones post here first. Check back soon.'
            : null,
      );
    }
    final jobs = paged.items;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MuOpportunityGroup(
          children: [
            for (var i = 0; i < jobs.length; i++)
              MuOpportunityRow(
                org: jobs[i].companyName ?? 'Partner company',
                role: jobs[i].title,
                terms: _terms(jobs[i]),
                logoUrl: jobs[i].companyLogo,
                status: byJob[jobs[i].id] != null
                    ? statusPill(
                        byJob[jobs[i].id]!.status,
                        byJob[jobs[i].id]!.rawStatus,
                      )
                    : (jobs[i].eligible == false
                          ? const MuPill(
                              'Not eligible yet',
                              tone: MuPillTone.warning,
                              icon: LucideIcons.lock,
                            )
                          : null),
                divider: i < jobs.length - 1,
                onTap: () => showMuSheet<void>(
                  context,
                  builder: (_) => JobSheet(job: jobs[i]),
                ),
              ),
          ],
        ),
        if (paged.hasMore)
          MuLoadMoreFooter(
            isLoading: paged.isLoadingMore,
            error: paged.loadMoreError,
            onRetry: () =>
                ref.read(jobsControllerProvider(query).notifier).loadMore(),
          ),
      ],
    );
  }
}

class _MyApplications extends ConsumerWidget {
  const _MyApplications({required this.onBrowse});

  final VoidCallback onBrowse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(myJobApplicationsProvider);
    return state.when(
      skipLoadingOnRefresh: true,
      loading: () => const Padding(
        padding: EdgeInsets.all(MuSpacing.space8),
        child: Center(child: MuDotsLoader(label: 'Loading your applications…')),
      ),
      error: (error, _) => ErrorRetryView(
        error: error,
        onRetry: () => ref.invalidate(myJobApplicationsProvider),
      ),
      data: (apps) {
        if (apps.isEmpty) {
          return MuStateDisplay(
            variant: MuStateVariant.noResults,
            size: MuStateSize.sm,
            title: 'No applications yet',
            description: 'Browse openings and apply with your resume link.',
            action: MuButton(
              label: 'Browse openings',
              variant: MuButtonVariant.outline,
              onPressed: onBrowse,
            ),
          );
        }
        return MuOpportunityGroup(
          children: [
            for (var i = 0; i < apps.length; i++)
              MuOpportunityRow(
                org: apps[i].job.companyName ?? 'Partner company',
                role: apps[i].job.title,
                terms: apps[i].appliedAt == null
                    ? _terms(apps[i].job)
                    : 'Applied ${formatDay(apps[i].appliedAt!.toLocal())}',
                logoUrl: apps[i].job.companyLogo,
                status: statusPill(apps[i].status, apps[i].rawStatus),
                closed: apps[i].status == ApplicationStatus.withdrawn,
                divider: i < apps.length - 1,
                onTap: () => showMuSheet<void>(
                  context,
                  builder: (_) => JobSheet(job: apps[i].job),
                ),
              ),
          ],
        );
      },
    );
  }
}

/// A job in full: who and what, the terms, what you'd deliver, whether you
/// meet each rule, and the one action: Apply, Apply again, or (once in)
/// where it stands with Withdraw.
class JobSheet extends ConsumerWidget {
  const JobSheet({required this.job, super.key});

  final Job job;

  Future<void> _withdraw(
    BuildContext context,
    WidgetRef ref,
    JobApplication app,
  ) async {
    final ok = await showMuConfirm(
      context,
      title: 'Withdraw from ${job.title}?',
      body: 'The company stops seeing it. You can apply again later.',
      confirmLabel: 'Withdraw',
      destructive: true,
    );
    if (!ok || !context.mounted) return;
    final done = await ref
        .read(applicationActionsControllerProvider.notifier)
        .withdraw(app.id);
    if (!context.mounted) return;
    final error = ref.read(applicationActionsControllerProvider).error;
    MuToast.show(
      context,
      message: done
          ? 'Application withdrawn'
          : ApiException.messageFor(error ?? "Couldn't withdraw"),
      type: done ? MuToastType.success : MuToastType.error,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final c = mu.colors;
    final app = ref
        .watch(myJobApplicationsProvider)
        .value
        ?.where((a) => a.job.id == job.id)
        .firstOrNull;
    final busy = ref.watch(applicationActionsControllerProvider).isLoading;
    final unmet = [
      for (final r in job.checks)
        if (!r.met) r,
    ];
    final duration = job.durationValue == null
        ? null
        : '${job.durationValue} ${job.durationUnit ?? ''}'.trim();

    final Widget action;
    if (app != null && !app.status.canResubmit) {
      action = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            spacing: MuSpacing.space2,
            runSpacing: MuSpacing.space1,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              statusPill(app.status, app.rawStatus),
              if (app.appliedAt != null)
                Text(
                  'since ${formatDay(app.appliedAt!.toLocal())}',
                  style: mu.text.caption,
                ),
            ],
          ),
          if (app.status.canWithdraw) ...[
            const SizedBox(height: MuSpacing.space3),
            MuButton(
              label: 'Withdraw application',
              variant: MuButtonVariant.outline,
              block: true,
              loading: busy,
              onPressed: busy ? null : () => _withdraw(context, ref, app),
            ),
          ],
        ],
      );
    } else if (job.eligible == false) {
      action = const MuButton(
        label: 'Not eligible yet',
        icon: LucideIcons.lock,
        variant: MuButtonVariant.outline,
        block: true,
        onPressed: null,
      );
    } else {
      action = MuButton(
        label: app != null ? 'Apply again' : 'Apply',
        variant: MuButtonVariant.ink,
        knob: true,
        block: true,
        onPressed: () => showMuSheet<void>(
          context,
          builder: (_) => _ApplySheet(job: job, resubmitId: app?.id),
        ),
      );
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.86,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                MuSpacing.space5,
                0,
                MuSpacing.space5,
                MuSpacing.space4,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.companyName ?? 'Partner company',
                    style: mu.text.caption.copyWith(color: c.ink3),
                  ),
                  const SizedBox(height: 2),
                  Semantics(
                    header: true,
                    child: Text(job.title, style: mu.text.title1),
                  ),
                  const SizedBox(height: MuSpacing.space3),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      if (_type(job.jobType).isNotEmpty)
                        MuPill(_type(job.jobType), tone: MuPillTone.cobalt),
                      if (job.location != null)
                        MuPill(job.location!, icon: LucideIcons.mapPin),
                      if (duration != null)
                        MuPill(duration, icon: LucideIcons.clock),
                      if (job.experience != null)
                        MuPill(job.experience!, icon: LucideIcons.briefcase),
                      if (job.certificateProvided)
                        const MuPill(
                          'Certificate',
                          tone: MuPillTone.success,
                          icon: LucideIcons.award,
                        ),
                    ],
                  ),
                  if (job.stipend != null ||
                      job.salaryRange != null ||
                      job.hourlyRate != null) ...[
                    const SizedBox(height: MuSpacing.space3),
                    Text(
                      [
                        if (job.stipend != null) 'Stipend ${job.stipend}',
                        if (job.salaryRange != null) job.salaryRange!,
                        if (job.hourlyRate != null)
                          '₹${job.hourlyRate} an hour',
                      ].join(' · '),
                      style: mu.text.bodyStrong,
                    ),
                  ],
                  if (job.description != null) ...[
                    const _Eyebrow('THE ROLE'),
                    Text(
                      job.description!,
                      style: mu.text.body.copyWith(color: c.ink2, height: 1.55),
                    ),
                  ],
                  if (job.deliverables.isNotEmpty) ...[
                    const _Eyebrow("WHAT YOU'LL DELIVER"),
                    for (final d in job.deliverables)
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: MuSpacing.space2,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: c.ink3,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            const SizedBox(width: MuSpacing.space3),
                            Expanded(
                              child: Text(
                                d,
                                style: mu.text.body.copyWith(color: c.ink2),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                  if (job.checks.isNotEmpty) ...[
                    _Eyebrow(
                      unmet.isEmpty ? 'YOU QUALIFY' : 'BEFORE YOU APPLY',
                    ),
                    for (final r in job.checks)
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: MuSpacing.space2,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              r.met
                                  ? LucideIcons.checkCircle2
                                  : LucideIcons.xCircle,
                              size: MuSizes.iconMd,
                              color: r.met ? c.success : c.danger,
                            ),
                            const SizedBox(width: MuSpacing.space2),
                            Expanded(
                              child: Text(
                                r.met
                                    ? _ruleLabel(r)
                                    : (r.message ?? _ruleLabel(r)),
                                style: mu.text.body.copyWith(
                                  color: r.met ? c.ink2 : c.ink,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                  if (app?.rejectionReason != null) ...[
                    const _Eyebrow('FROM THE COMPANY'),
                    Text(
                      app!.rejectionReason!,
                      style: mu.text.body.copyWith(color: c.ink2),
                    ),
                  ],
                  if (job.expiresAt != null) ...[
                    const SizedBox(height: MuSpacing.space4),
                    Text(
                      'Open until ${formatDay(job.expiresAt!.toLocal())}',
                      style: mu.text.caption,
                    ),
                  ],
                ],
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: c.surface,
              border: Border(top: BorderSide(color: c.line)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                MuSpacing.space5,
                MuSpacing.space3,
                MuSpacing.space5,
                MuSpacing.space4,
              ),
              child: action,
            ),
          ),
        ],
      ),
    );
  }

  static String _ruleLabel(JobRuleCheck r) => switch (r.ruleType) {
    'min_karma' => 'At least ${r.ruleValue} karma',
    'max_karma' => 'At most ${r.ruleValue} karma',
    'min_level' => 'Level ${r.ruleValue} or above',
    'max_level' => 'Level ${r.ruleValue} or below',
    'skill' => 'The required skill',
    _ => r.ruleType.replaceAll('_', ' '),
  };
}

class _Eyebrow extends StatelessWidget {
  const _Eyebrow(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(
      top: MuSpacing.space6,
      bottom: MuSpacing.space2,
    ),
    child: Semantics(
      header: true,
      child: Text(text, style: context.mu.text.eyebrow),
    ),
  );
}

/// Apply (or apply again) with a resume link and an optional note.
class _ApplySheet extends ConsumerStatefulWidget {
  const _ApplySheet({required this.job, this.resubmitId});

  final Job job;

  /// Set to resubmit a rejected or withdrawn application.
  final String? resubmitId;

  @override
  ConsumerState<_ApplySheet> createState() => _ApplySheetState();
}

class _ApplySheetState extends ConsumerState<_ApplySheet> {
  final _formKey = GlobalKey<FormState>();
  final _resume = TextEditingController();
  final _note = TextEditingController();

  @override
  void dispose() {
    _resume.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final typed = _resume.text.trim();
    // A bare "drive.google.com/…" is sent as a full link the company can open.
    final resume = typed.startsWith('http://') || typed.startsWith('https://')
        ? typed
        : 'https://$typed';
    final ok = await ref
        .read(applicationActionsControllerProvider.notifier)
        .apply(
          widget.job.id,
          resumeLink: resume,
          coverLetter: _note.text.trim().isEmpty ? null : _note.text.trim(),
          applicationId: widget.resubmitId,
        );
    if (!mounted) return;
    final error = ref.read(applicationActionsControllerProvider).error;
    MuToast.show(
      context,
      message: ok
          ? 'Applied to ${widget.job.title}'
          : ApiException.messageFor(error ?? "Couldn't apply"),
      type: ok ? MuToastType.success : MuToastType.error,
    );
    if (ok) Navigator.of(context).pop();
  }

  static String? _link(String? v) {
    final s = v?.trim() ?? '';
    if (s.isEmpty) return 'Add a link to your resume';
    final uri = Uri.tryParse(s.startsWith('http') ? s : 'https://$s');
    return uri == null || uri.host.isEmpty || !uri.host.contains('.')
        ? 'That link looks incomplete'
        : null;
  }

  @override
  Widget build(BuildContext context) {
    final busy = ref.watch(applicationActionsControllerProvider).isLoading;
    return Form(
      key: _formKey,
      child: MuFormSheet(
        title: widget.resubmitId == null
            ? 'Apply to ${widget.job.title}'
            : 'Apply again',
        lead: widget.job.companyName == null
            ? null
            : '${widget.job.companyName} sees your μLearn profile and this.',
        action: MuButton(
          label: widget.resubmitId == null ? 'Send application' : 'Resubmit',
          block: true,
          loading: busy,
          onPressed: busy ? null : _submit,
        ),
        children: [
          MuTextField(
            label: 'Resume link',
            controller: _resume,
            hint: 'Drive, Notion or your portfolio',
            keyboardType: TextInputType.url,
            autofocus: true,
            validator: _link,
          ),
          MuTextField(
            label: 'Note (optional)',
            controller: _note,
            hint: "Why you're a good fit",
            maxLines: 5,
            minLines: 3,
            textCapitalization: TextCapitalization.sentences,
          ),
        ],
      ),
    );
  }
}
