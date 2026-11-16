import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/session/mentor_application.dart';
import 'package:mulearn_app/core/session/session_providers.dart';
import 'package:mulearn_app/core/utils/search_debouncer.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_application_form.dart';
import 'package:mulearn_app/features/mentor/presentation/providers/mentor_applications_providers.dart';

/// Apply to mentor, edit an application under review ([editId]), or apply
/// again after a no ([fromId]) — the dashboard's `MentorOnboardingForm`.
/// What the mentor already told us (about, expertise, hours, LinkedIn, and
/// the earlier application's answers) is filled in.
class MentorApplicationFormScreen extends ConsumerWidget {
  const MentorApplicationFormScreen({this.editId, this.fromId, super.key});

  final String? editId;
  final String? fromId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(mentorProfileSnapshotProvider);
    final apps = ref.watch(mentorApplicationsProvider);
    return snapshot.when(
      loading: () => const MuWorkspacePage(body: Center(child: MuDotsLoader())),
      error: (e, _) => MuWorkspacePage(
        body: ErrorRetryView(
          error: e,
          onRetry: () => ref.invalidate(mentorProfileSnapshotProvider),
        ),
      ),
      data: (s) => _Form(
        snapshot: s ?? const MentorProfileSnapshot(),
        applications: apps.value ?? const [],
        editId: editId,
        fromId: fromId,
      ),
    );
  }
}

class _Form extends ConsumerStatefulWidget {
  const _Form({
    required this.snapshot,
    required this.applications,
    this.editId,
    this.fromId,
  });

  final MentorProfileSnapshot snapshot;
  final List<MentorApplication> applications;
  final String? editId;
  final String? fromId;

  @override
  ConsumerState<_Form> createState() => _FormState();
}

class _FormState extends ConsumerState<_Form> {
  late final MentorApplicationAnswers? _earlier = widget.snapshot.application(
    widget.editId ?? widget.fromId,
  );

  /// An IG Mentor application can be open only once (`MentorRegistrationAPI`).
  late final bool _igTaken = widget.applications.any(
    (a) =>
        a.mentorTier == MentorTier.ig.value &&
        (a.isPending || a.isApproved) &&
        a.id != widget.editId,
  );

  late MentorTier _tier =
      _earlier?.tier ?? (_igTaken ? MentorTier.campus : MentorTier.ig);
  late MentorChoice? _org = _earlier?.organization;
  late final _about = TextEditingController(text: widget.snapshot.about);
  late final _reason = TextEditingController(text: _earlier?.reason ?? '');
  late final _linkedin = TextEditingController(text: widget.snapshot.linkedin);
  final _expertiseInput = TextEditingController();
  late final List<String> _expertise = [...widget.snapshot.expertise];
  late final Set<String> _igs = {...?_earlier?.preferredIgIds};
  late String? _hours = widget.snapshot.hours;
  Map<MentorField, String> _errors = const {};
  bool _busy = false;

  bool get _editing => widget.editId != null;

  @override
  void dispose() {
    _about.dispose();
    _reason.dispose();
    _linkedin.dispose();
    _expertiseInput.dispose();
    super.dispose();
  }

  MentorApplicationDraft get _draft => MentorApplicationDraft(
    tier: _tier,
    organization: _tier.needsOrganization ? _org : null,
    about: _about.text,
    expertise: _expertise,
    reason: _reason.text,
    preferredIgIds: _igs.toList(),
    hours: _hours,
    linkedin: _linkedin.text,
  );

  /// Adds what's typed (commas split it) to the expertise chips.
  void _addExpertise([String? raw]) {
    final parts = (raw ?? _expertiseInput.text)
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty);
    setState(() {
      for (final p in parts) {
        if (!_expertise.any((e) => e.toLowerCase() == p.toLowerCase())) {
          _expertise.add(p);
        }
      }
      _expertiseInput.clear();
      _errors = {..._errors}..remove(MentorField.expertise);
    });
  }

  static const _backendFields = {
    'org': MentorField.organization,
    'about': MentorField.about,
    'expertise': MentorField.expertise,
    'reason': MentorField.reason,
    'preferred_ig_ids': MentorField.interestGroups,
    'linkedin': MentorField.linkedin,
  };

  Future<void> _send() async {
    if (_expertiseInput.text.trim().isNotEmpty) _addExpertise();
    final draft = _draft;
    final problems = draft.problems();
    if (problems.isNotEmpty) {
      setState(() => _errors = problems);
      MuToast.show(
        context,
        message: problems.values.first,
        type: MuToastType.error,
      );
      return;
    }
    setState(() {
      _busy = true;
      _errors = const {};
    });
    try {
      final message = await ref
          .read(mentorApplicationSenderProvider.notifier)
          .send(draft, editingId: widget.editId);
      if (!mounted) return;
      MuToast.show(context, message: message, type: MuToastType.success);
      context.canPop()
          ? context.pop()
          : context.go(RoutePaths.mentorApplications);
    } on Object catch (e) {
      if (!mounted) return;
      final fields = e is ApiException
          ? e.fieldErrors
          : const <String, List<String>>{};
      setState(() {
        _busy = false;
        _errors = {
          for (final f in fields.entries)
            if (_backendFields[f.key] case final field?)
              field: f.value.firstOrNull ?? '',
        };
      });
      MuToast.show(
        context,
        message: ApiException.messageFor(e),
        type: MuToastType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final title = _editing
        ? 'Edit your application'
        : widget.fromId != null
        ? 'Apply again'
        : 'Apply to mentor';
    return MuWorkspacePage(
      bottom: MuButton(
        label: _editing ? 'Save changes' : 'Send application',
        block: true,
        variant: MuButtonVariant.ink,
        knob: true,
        loading: _busy,
        onPressed: _busy ? null : _send,
      ),
      body: ListView(
        padding: muListPadding,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          Semantics(
            header: true,
            child: Text(title, style: mu.text.display.copyWith(fontSize: 32)),
          ),
          const SizedBox(height: MuSpacing.space2),
          Text(
            _editing
                ? 'Change your answers while it’s under review. Its tier and '
                      'organisation stay as they are.'
                : 'Tell us how you’ll mentor. ${_tier.reviewer}',
            style: mu.text.body.copyWith(color: mu.colors.ink2),
          ),
          if (widget.fromId != null) ...[
            const SizedBox(height: MuSpacing.space3),
            _RejectionNote(
              applications: widget.applications,
              id: widget.fromId!,
            ),
          ],
          const SizedBox(height: MuSpacing.space6),
          ..._tierSection(context),
          const SizedBox(height: MuSpacing.space6),
          _IgPicker(
            selected: _igs,
            error: _errors[MentorField.interestGroups],
            onToggle: (id) => setState(() {
              _igs.contains(id) ? _igs.remove(id) : _igs.add(id);
              _errors = {..._errors}..remove(MentorField.interestGroups);
            }),
          ),
          const SizedBox(height: MuSpacing.space6),
          MuTextField(
            label: 'About you',
            controller: _about,
            hint: 'What you do, what you’ve built, what you can teach',
            help: 'At least ${MentorApplicationDraft.aboutMin} characters.',
            error: _errors[MentorField.about],
            minLines: 3,
            maxLines: 8,
            maxLength: MentorApplicationDraft.aboutMax,
            textCapitalization: TextCapitalization.sentences,
          ),
          const SizedBox(height: MuSpacing.space4),
          _ExpertiseField(
            values: _expertise,
            input: _expertiseInput,
            error: _errors[MentorField.expertise],
            onAdd: _addExpertise,
            onRemove: (e) => setState(() => _expertise.remove(e)),
          ),
          const SizedBox(height: MuSpacing.space4),
          MuTextField(
            label: 'Why you want to mentor',
            controller: _reason,
            hint: 'What you hope learners get from you',
            help: 'At least ${MentorApplicationDraft.reasonMin} characters.',
            error: _errors[MentorField.reason],
            minLines: 2,
            maxLines: 6,
            textCapitalization: TextCapitalization.sentences,
          ),
          const SizedBox(height: MuSpacing.space4),
          MuSelectField(
            label: 'Hours a week (optional)',
            hint: 'How much time you can give',
            options: [
              for (final h in mentorHoursChoices) MuOption(h, '$h hours'),
            ],
            value: _hours,
            onChanged: (v) => setState(() => _hours = v),
          ),
          const SizedBox(height: MuSpacing.space4),
          MuTextField(
            label: 'LinkedIn (optional)',
            controller: _linkedin,
            hint: 'https://www.linkedin.com/in/you',
            error: _errors[MentorField.linkedin],
            keyboardType: TextInputType.url,
            autofillHints: const [AutofillHints.url],
          ),
        ],
      ),
    );
  }

  List<Widget> _tierSection(BuildContext context) {
    final mu = context.mu;
    if (_editing) {
      return [
        MuSurfaceCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_tier.label, style: mu.text.title3),
              if (_org != null) Text(_org!.name, style: mu.text.body),
            ],
          ),
        ),
      ];
    }
    return [
      Text('How you’ll mentor', style: mu.text.label),
      const SizedBox(height: MuSpacing.space2),
      for (final t in MentorTier.values) ...[
        MuRadioCard<MentorTier>(
          value: t,
          groupValue: _tier,
          title: t.label,
          subtitle: t == MentorTier.ig && _igTaken
              ? 'You already have an IG Mentor application.'
              : switch (t) {
                  MentorTier.ig => 'Guide learners in Interest Groups.',
                  MentorTier.campus => 'Mentor the learners of one college.',
                  MentorTier.company => 'Mentor from the company you work at.',
                },
          onChanged: t == MentorTier.ig && _igTaken
              ? null
              : (v) => setState(() {
                  if (v != _tier) _org = null;
                  _tier = v;
                  _errors = {..._errors}..remove(MentorField.organization);
                }),
        ),
        const SizedBox(height: MuSpacing.space2),
      ],
      if (_tier == MentorTier.company) ...[
        const SizedBox(height: MuSpacing.space2),
        _CompanyPicker(
          value: _org,
          error: _errors[MentorField.organization],
          onPicked: (c) => setState(() {
            _org = c;
            _errors = {..._errors}..remove(MentorField.organization);
          }),
        ),
      ],
      if (_tier == MentorTier.campus) ...[
        const SizedBox(height: MuSpacing.space2),
        _CollegePicker(
          picked: _org,
          error: _errors[MentorField.organization],
          onPicked: (c) => setState(() {
            _org = c;
            _errors = {..._errors}..remove(MentorField.organization);
          }),
        ),
      ],
    ];
  }
}

/// On "apply again": what the reviewer said last time.
class _RejectionNote extends StatelessWidget {
  const _RejectionNote({required this.applications, required this.id});

  final List<MentorApplication> applications;
  final String id;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final reason = applications
        .where((a) => a.id == id)
        .firstOrNull
        ?.rejectionReason;
    if (reason == null) return const SizedBox.shrink();
    return MuSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Last time the reviewer said', style: mu.text.label),
          const SizedBox(height: 2),
          Text(reason, style: mu.text.body),
        ],
      ),
    );
  }
}

class _CompanyPicker extends ConsumerWidget {
  const _CompanyPicker({
    required this.value,
    required this.onPicked,
    this.error,
  });

  final MentorChoice? value;
  final ValueChanged<MentorChoice?> onPicked;
  final String? error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companies = ref.watch(mentorCompanyChoicesProvider);
    final list = companies.value ?? const <MentorChoice>[];
    return MuSelectField(
      label: 'Company',
      hint: 'Pick your company',
      loading: companies.isLoading,
      error:
          error ??
          (companies.hasError ? 'Companies couldn’t load. Try again.' : null),
      options: [for (final c in list) MuOption(c.id, c.name)],
      value: value?.id,
      onChanged: (id) =>
          onPicked(list.where((c) => c.id == id).firstOrNull ?? value),
    );
  }
}

/// A college search (there are too many to list), as signup does.
class _CollegePicker extends ConsumerStatefulWidget {
  const _CollegePicker({
    required this.picked,
    required this.onPicked,
    this.error,
  });

  final MentorChoice? picked;
  final ValueChanged<MentorChoice?> onPicked;
  final String? error;

  @override
  ConsumerState<_CollegePicker> createState() => _CollegePickerState();
}

class _CollegePickerState extends ConsumerState<_CollegePicker> {
  final _search = TextEditingController();
  String _query = '';
  late final _debouncer = SearchDebouncer((q) {
    if (mounted) setState(() => _query = q);
  });

  @override
  void dispose() {
    _debouncer.dispose();
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final picked = widget.picked;
    final found = ref.watch(mentorCollegeSearchProvider(_query));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('College', style: mu.text.label),
        const SizedBox(height: MuSpacing.space2),
        if (picked != null)
          MuFeedRow(
            leading: const MuCampusSeal(code: null, size: 40),
            subject: picked.name,
            trailing: MuIconButton(
              icon: LucideIcons.x,
              tooltip: 'Pick another college',
              variant: MuIconButtonVariant.sunk,
              onPressed: () => widget.onPicked(null),
            ),
            divider: false,
          )
        else ...[
          MuSearchField(
            controller: _search,
            hint: 'Search your college',
            onChanged: _debouncer.onChanged,
            onSubmitted: _debouncer.submit,
          ),
          if (_query.length >= 2)
            ...found.when(
              loading: () => const [
                Padding(
                  padding: EdgeInsets.all(MuSpacing.space3),
                  child: Center(child: MuDotsLoader()),
                ),
              ],
              error: (e, _) => [MuEmptyLine(ApiException.messageFor(e))],
              data: (colleges) => colleges.isEmpty
                  ? const [MuEmptyLine('No college matches that.')]
                  : [
                      MuFeedGroup(
                        children: [
                          for (final (i, c) in colleges.indexed)
                            MuFeedRow(
                              leading: const MuCampusSeal(code: null, size: 40),
                              subject: c.name,
                              onTap: () {
                                _search.clear();
                                _debouncer.reset();
                                setState(() => _query = '');
                                widget.onPicked(c);
                              },
                              divider: i < colleges.length - 1,
                            ),
                        ],
                      ),
                    ],
            ),
        ],
        if (widget.error != null) ...[
          const SizedBox(height: MuSpacing.space1),
          Text(
            widget.error!,
            style: mu.text.caption.copyWith(color: mu.colors.danger),
          ),
        ],
      ],
    );
  }
}

/// The Interest Groups to mentor, as chips (1 to [maxPreferredIgs]).
class _IgPicker extends ConsumerWidget {
  const _IgPicker({required this.selected, required this.onToggle, this.error});

  final Set<String> selected;
  final ValueChanged<String> onToggle;
  final String? error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final igs = ref.watch(mentorIgChoicesProvider);
    final full = selected.length >= maxPreferredIgs;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text('Interest Groups to mentor', style: mu.text.label),
            ),
            Text(
              '${selected.length} of $maxPreferredIgs',
              style: mu.text.caption,
            ),
          ],
        ),
        const SizedBox(height: MuSpacing.space2),
        ...igs.when(
          loading: () => const [Center(child: MuDotsLoader())],
          error: (e, _) => [
            ErrorRetryView(
              error: e,
              onRetry: () => ref.invalidate(mentorIgChoicesProvider),
            ),
          ],
          data: (list) => [
            Wrap(
              spacing: MuSpacing.space2,
              runSpacing: MuSpacing.space2,
              children: [
                for (final g in list)
                  MuFilterChip(
                    label: g.name,
                    selected: selected.contains(g.id),
                    onTap: !selected.contains(g.id) && full
                        ? () => MuToast.show(
                            context,
                            message:
                                'Pick at most $maxPreferredIgs. Tap one to drop it first.',
                          )
                        : () {
                            HapticFeedback.selectionClick();
                            onToggle(g.id);
                          },
                  ),
              ],
            ),
          ],
        ),
        if (error != null) ...[
          const SizedBox(height: MuSpacing.space1),
          Text(
            error!,
            style: mu.text.caption.copyWith(color: mu.colors.danger),
          ),
        ],
      ],
    );
  }
}

/// Areas of expertise as chips: type one and press done (or a comma).
class _ExpertiseField extends StatelessWidget {
  const _ExpertiseField({
    required this.values,
    required this.input,
    required this.onAdd,
    required this.onRemove,
    this.error,
  });

  final List<String> values;
  final TextEditingController input;
  final void Function([String?]) onAdd;
  final ValueChanged<String> onRemove;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MuTextField(
          label: 'Areas of expertise',
          controller: input,
          hint: 'Flutter, product design, IoT…',
          help: values.length >= MentorApplicationDraft.expertiseMin
              ? null
              : 'Add at least ${MentorApplicationDraft.expertiseMin}. '
                    'Press done after each.',
          error: error,
          textInputAction: TextInputAction.done,
          textCapitalization: TextCapitalization.sentences,
          onChanged: (v) {
            if (v.contains(',')) onAdd(v);
          },
          onSubmitted: (_) => onAdd(),
          trailing: MuIconButton(
            icon: LucideIcons.plus,
            tooltip: 'Add',
            variant: MuIconButtonVariant.sunk,
            onPressed: onAdd,
          ),
        ),
        if (values.isNotEmpty) ...[
          const SizedBox(height: MuSpacing.space2),
          Wrap(
            spacing: MuSpacing.space2,
            runSpacing: MuSpacing.space2,
            children: [
              for (final v in values)
                MuFilterChip(
                  label: v,
                  selected: true,
                  icon: LucideIcons.x,
                  onTap: () => onRemove(v),
                ),
            ],
          ),
        ],
      ],
    );
  }
}
