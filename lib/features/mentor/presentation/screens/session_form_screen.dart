import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_session.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_draft.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_enums.dart';
import 'package:mulearn_app/features/mentor/presentation/providers/mentor_sessions_controller.dart';
import 'package:mulearn_app/features/mentor/presentation/providers/persona_controller.dart';

/// Create a session, or edit one when [sessionId] is given. An edit changes
/// title, description, mode, times, link and venue only — what the backend's
/// `SessionUpdateSerializer` accepts; a series is changed on the web.
class SessionFormScreen extends ConsumerWidget {
  const SessionFormScreen({this.sessionId, super.key});

  final String? sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = sessionId;
    return Scaffold(
      backgroundColor: MuColors.canvas,
      appBar: AppBar(
        backgroundColor: MuColors.canvas,
        elevation: 0,
        title: Text(id == null ? 'New session' : 'Edit session'),
      ),
      body: id == null
          ? ref.watch(sessionTargetsProvider).when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => ErrorRetryView(error: e, onRetry: () => ref.invalidate(sessionTargetsProvider)),
                data: (targets) {
                  // Wait for who the mentor acts as (its scope is the
                  // default); a failure just means no default.
                  final persona = ref.watch(personaControllerProvider);
                  if (persona.isLoading && !persona.hasValue) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final acting = persona.value;
                  return _SessionForm(
                    targets: targets,
                    preferredEntityId: acting != null && acting.isMentor ? acting.scopeId : null,
                  );
                },
              )
          : ref.watch(mentorSessionProvider(id)).when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => ErrorRetryView(error: e, onRetry: () => ref.invalidate(mentorSessionProvider(id))),
                data: (session) => _SessionForm(editing: session),
              ),
    );
  }
}

class _SessionForm extends ConsumerStatefulWidget {
  const _SessionForm({this.targets = const [], this.editing, this.preferredEntityId});

  final List<SessionTarget> targets;
  final MentorSession? editing;

  /// The scope the mentor acts in; preselected when it's a target.
  final String? preferredEntityId;

  @override
  ConsumerState<_SessionForm> createState() => _SessionFormState();
}

class _SessionFormState extends ConsumerState<_SessionForm> {
  late final TextEditingController _title;
  late final TextEditingController _description;
  late final TextEditingController _link;
  late final TextEditingController _venue;
  late final TextEditingController _max;
  late final TextEditingController _interval;
  late SessionDraft _draft;
  bool _busy = false;
  String? _formError;
  Map<String, String> _fieldErrors = const {};

  bool get _isEdit => widget.editing != null;

  @override
  void initState() {
    super.initState();
    final s = widget.editing;
    if (s != null) {
      _draft = SessionDraft(
        target: SessionTarget(type: s.type, entityId: s.entityId, label: s.entityName),
        title: s.title,
        description: s.description,
        mode: s.mode == SessionMode.unknown ? SessionMode.online : s.mode,
        startsLocal: s.startsAt.toLocal(),
        endsLocal: s.endsAt.toLocal(),
        meetingLink: s.meetingLink ?? '',
        venue: s.venue ?? '',
      );
    } else {
      // Tomorrow 10:00–11:00 local; the mentor adjusts.
      final now = ref.read(clockProvider)().toLocal();
      final starts = DateTime(now.year, now.month, now.day + 1, 10);
      _draft = SessionDraft(
        target: widget.targets.where((t) => t.entityId == widget.preferredEntityId).firstOrNull ??
            (widget.targets.length == 1 ? widget.targets.single : null),
        title: '',
        description: '',
        mode: SessionMode.online,
        startsLocal: starts,
        endsLocal: starts.add(const Duration(hours: 1)),
        meetingLink: '',
        venue: '',
      );
    }
    _title = TextEditingController(text: _draft.title);
    _description = TextEditingController(text: _draft.description);
    _link = TextEditingController(text: _draft.meetingLink);
    _venue = TextEditingController(text: _draft.venue);
    _max = TextEditingController();
    _interval = TextEditingController(text: '1');
  }

  @override
  void dispose() {
    for (final c in [_title, _description, _link, _venue, _max, _interval]) {
      c.dispose();
    }
    super.dispose();
  }

  SessionDraft _current() => _draft.copyWith(
        title: _title.text,
        description: _description.text,
        meetingLink: _link.text,
        venue: _venue.text,
        maxParticipants: int.tryParse(_max.text.trim()),
        recurrenceInterval: int.tryParse(_interval.text.trim())?.clamp(1, 365) ?? 1,
      );

  Future<void> _pickDateTime({required bool start}) async {
    final initial = (start ? _draft.startsLocal : _draft.endsLocal) ?? DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(initial.year - 1),
      lastDate: DateTime(initial.year + 2),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(initial));
    if (time == null || !mounted) return;
    final picked = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() {
      if (start) {
        final length = (_draft.endsLocal ?? picked).difference(_draft.startsLocal ?? picked);
        _draft = _draft.copyWith(
          startsLocal: picked,
          endsLocal: length.isNegative || length == Duration.zero ? picked.add(const Duration(hours: 1)) : picked.add(length),
        );
      } else {
        _draft = _draft.copyWith(endsLocal: picked);
      }
    });
  }

  Future<void> _submit() async {
    final draft = _current();
    final problem = draft.validate();
    if (problem != null) {
      setState(() {
        _formError = problem;
        _fieldErrors = const {};
      });
      return;
    }
    setState(() {
      _busy = true;
      _formError = null;
      _fieldErrors = const {};
    });
    final actions = ref.read(sessionActionsProvider.notifier);
    try {
      final editing = widget.editing;
      if (editing != null) {
        final message = await actions.update(editing.id, draft);
        if (!mounted) return;
        MuToast.show(context, message: message.isEmpty ? 'Session updated' : message, type: MuToastType.success);
        context.canPop() ? context.pop() : context.go(RoutePaths.mentorSessionDetailPath(editing.id));
        return;
      }
      final created = await actions.create(draft);
      if (!mounted) return;
      MuToast.show(
        context,
        message: created.message.isEmpty ? 'Session created' : created.message,
        type: MuToastType.success,
      );
      // Show what was just created, in place of the form.
      if (created.id.isEmpty) {
        context.canPop() ? context.pop() : context.go(RoutePaths.mentorSessions);
      } else {
        context.pushReplacement(RoutePaths.mentorSessionDetailPath(created.id));
      }
    } on Object catch (e) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        if (e is ApiException && e.fieldErrors.isNotEmpty) {
          _fieldErrors = {for (final f in e.fieldErrors.entries) f.key: f.value.firstOrNull ?? ''};
          // A field this form doesn't show (recurrence_*, non_field_errors,
          // …) still has to reach the mentor, under the form.
          final hidden = [
            for (final f in e.fieldErrors.entries)
              if (!_shownFields.contains(f.key)) ...f.value,
          ];
          if (hidden.isNotEmpty) _formError = hidden.join('\n');
        } else {
          _formError = ApiException.messageFor(e);
        }
      });
    }
  }

  /// Backend fields that have a place under an input on this form.
  static const _shownFields = {
    'entity_id', 'title', 'description', 'meeting_link', 'venue', 'starts_at', 'ends_at', 'max_participants', //
  };

  /// A field's error: the backend's for that field, else the local one.
  String? _errorFor(String field) {
    final backend = _fieldErrors[field];
    if (backend != null) return backend;
    return switch ((field, _formError)) {
      ('title', 'Title is required.') => _formError,
      ('venue', 'Venue is required for a hybrid session.') => _formError,
      ('meeting_link', 'Meeting link is required for a hybrid session.') => _formError,
      _ => null,
    };
  }

  String? get _generalError {
    final e = _formError;
    if (e == null) return null;
    return ['title', 'venue', 'meeting_link'].any((f) => _errorFor(f) == e) ? null : e;
  }

  @override
  Widget build(BuildContext context) {
    final noTarget = !_isEdit && widget.targets.isEmpty;
    final mode = _draft.mode;
    return ListView(
      padding: const EdgeInsets.fromLTRB(MuSpace.screenH, MuSpace.m, MuSpace.screenH, MuSpace.xxl),
      children: [
        if (noTarget)
          MuCard(
            padding: const EdgeInsets.all(MuSpace.l),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('No mentoring scope yet', style: MuType.bodyMed),
                const SizedBox(height: MuSpace.xs),
                Text(
                  'An admin assigns the interest group, campus or company you mentor. '
                  'You can create sessions once you have one.',
                  style: MuType.body.copyWith(color: MuColors.inkSecondary),
                ),
              ],
            ),
          )
        else if (_isEdit)
          _ReadOnlyRow(label: 'Where', value: _draft.target?.label ?? '')
        else
          DropdownButtonFormField<SessionTarget>(
            initialValue: _draft.target,
            isExpanded: true,
            decoration: InputDecoration(labelText: 'Where', errorText: _fieldErrors['entity_id']),
            items: [
              for (final t in widget.targets)
                DropdownMenuItem(value: t, child: Text(t.label, overflow: TextOverflow.ellipsis)),
            ],
            onChanged: (t) => setState(() => _draft = _draft.copyWith(target: t)),
          ),
        const SizedBox(height: MuSpace.m),
        TextFormField(
          controller: _title,
          decoration: InputDecoration(labelText: 'Title', errorText: _errorFor('title')),
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: MuSpace.m),
        TextFormField(
          controller: _description,
          decoration: InputDecoration(labelText: 'Description', errorText: _fieldErrors['description']),
          minLines: 2,
          maxLines: 5,
        ),
        const SizedBox(height: MuSpace.l),
        SegmentedButton<SessionMode>(
          segments: const [
            ButtonSegment(value: SessionMode.online, label: Text('Online')),
            ButtonSegment(value: SessionMode.offline, label: Text('In person')),
            ButtonSegment(value: SessionMode.hybrid, label: Text('Hybrid')),
          ],
          selected: {mode},
          onSelectionChanged: (s) => setState(() => _draft = _draft.copyWith(mode: s.first)),
        ),
        const SizedBox(height: MuSpace.m),
        if (mode != SessionMode.offline)
          TextFormField(
            controller: _link,
            decoration: InputDecoration(
              labelText: 'Meeting link',
              errorText: _errorFor('meeting_link'),
              suffixIcon: IconButton(
                tooltip: 'Paste link',
                icon: const Icon(LucideIcons.clipboardPaste, size: 18),
                onPressed: () async {
                  final text = (await Clipboard.getData(Clipboard.kTextPlain))?.text?.trim();
                  if (text != null && text.isNotEmpty && mounted) setState(() => _link.text = text);
                },
              ),
            ),
            keyboardType: TextInputType.url,
          ),
        if (mode != SessionMode.online) ...[
          const SizedBox(height: MuSpace.m),
          TextFormField(
            controller: _venue,
            decoration: InputDecoration(labelText: 'Venue', errorText: _errorFor('venue')),
          ),
        ],
        const SizedBox(height: MuSpace.m),
        _PickerRow(
          label: 'Starts',
          value: _draft.startsLocal == null ? 'Pick' : formatDayTime(_draft.startsLocal!),
          onTap: () => _pickDateTime(start: true),
        ),
        _PickerRow(
          label: 'Ends',
          value: _draft.endsLocal == null ? 'Pick' : formatDayTime(_draft.endsLocal!),
          onTap: () => _pickDateTime(start: false),
          error: _fieldErrors['ends_at'] ?? _fieldErrors['starts_at'],
        ),
        if (!_isEdit) ...[
          const SizedBox(height: MuSpace.m),
          TextFormField(
            controller: _max,
            decoration: InputDecoration(labelText: 'Max participants (optional)', errorText: _fieldErrors['max_participants']),
            keyboardType: TextInputType.number,
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Repeats'),
            value: _draft.isRecurring,
            onChanged: (v) => setState(() => _draft = _draft.copyWith(isRecurring: v)),
          ),
          if (_draft.isRecurring) ...[
            SegmentedButton<RecurrenceType>(
              emptySelectionAllowed: true,
              segments: const [
                ButtonSegment(value: RecurrenceType.daily, label: Text('Daily')),
                ButtonSegment(value: RecurrenceType.weekly, label: Text('Weekly')),
                ButtonSegment(value: RecurrenceType.monthly, label: Text('Monthly')),
              ],
              selected: {if (_draft.recurrenceType != null) _draft.recurrenceType!},
              onSelectionChanged: (s) => setState(() => _draft = _draft.copyWith(recurrenceType: s.firstOrNull)),
            ),
            const SizedBox(height: MuSpace.m),
            TextFormField(
              controller: _interval,
              decoration: const InputDecoration(labelText: 'Every (1 = each time)'),
              keyboardType: TextInputType.number,
            ),
            _PickerRow(
              label: 'Until',
              value: _draft.recurrenceEndDate == null ? 'Pick a date' : formatDay(_draft.recurrenceEndDate!),
              onTap: () async {
                final starts = _draft.startsLocal ?? DateTime.now();
                final date = await showDatePicker(
                  context: context,
                  initialDate: _draft.recurrenceEndDate ?? starts.add(const Duration(days: 28)),
                  // The backend needs the end after the first session's day.
                  firstDate: starts.add(const Duration(days: 1)),
                  lastDate: DateTime(starts.year + 2),
                );
                if (date != null && mounted) setState(() => _draft = _draft.copyWith(recurrenceEndDate: date));
              },
            ),
          ],
        ],
        if (_generalError != null) ...[
          const SizedBox(height: MuSpace.m),
          Text(_generalError!, style: MuType.body.copyWith(color: MuColors.error)),
        ],
        const SizedBox(height: MuSpace.xl),
        MuPrimaryButton(
          label: _busy ? 'Please wait…' : (_isEdit ? 'Save changes' : 'Create session'),
          onPressed: _busy || noTarget ? null : _submit,
        ),
      ],
    );
  }
}

class _PickerRow extends StatelessWidget {
  const _PickerRow({required this.label, required this.value, required this.onTap, this.error});

  final String label;
  final String value;
  final VoidCallback onTap;
  final String? error;

  @override
  Widget build(BuildContext context) => ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(label, style: MuType.caption),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: MuType.bodyMed),
            if (error != null) Text(error!, style: MuType.caption.copyWith(color: MuColors.error)),
          ],
        ),
        trailing: const Icon(LucideIcons.chevronRight, size: 18, color: MuColors.inkSecondary),
        onTap: onTap,
      );
}

class _ReadOnlyRow extends StatelessWidget {
  const _ReadOnlyRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: MuType.caption),
          Text(value, style: MuType.bodyMed),
        ],
      );
}
