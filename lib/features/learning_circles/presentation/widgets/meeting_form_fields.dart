import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting_form.dart';

const kMeetingPlatforms = ['Zoom', 'Google Meet', 'Microsoft Teams', 'Discord', 'Other'];

/// Shared create/edit meeting form, confirmed live (rules.md §3/§9):
/// `platform` is required whenever mode is online, `meet_place` may never be
/// blank, and `duration` is in hours. The fields scroll; [submitLabel] sits
/// pinned at the bottom.
class MeetingFormFields extends StatefulWidget {
  const MeetingFormFields({
    required this.title,
    required this.isSubmitting,
    required this.submitLabel,
    required this.onSubmit,
    super.key,
    this.initial,
    this.errorMessage,
  });

  /// The page heading ("New meeting").
  final String title;
  final MeetingForm? initial;
  final bool isSubmitting;
  final String submitLabel;
  final String? errorMessage;
  final ValueChanged<MeetingForm> onSubmit;

  @override
  State<MeetingFormFields> createState() => _MeetingFormFieldsState();
}

enum _Mode { online, offline }

class _MeetingFormFieldsState extends State<MeetingFormFields> {
  final _formKey = GlobalKey<FormState>();
  late final _title = TextEditingController(text: widget.initial?.title);
  late final _description = TextEditingController(text: widget.initial?.description);
  late final _place = TextEditingController(text: widget.initial?.meetPlace);
  late final _link = TextEditingController(text: widget.initial?.meetLink);
  late _Mode _mode = widget.initial?.mode == 'offline' ? _Mode.offline : _Mode.online;
  late String? _platform = widget.initial?.platform ?? kMeetingPlatforms.first;
  late DateTime? _meetTime = widget.initial?.meetTime != null
      ? DateTime.tryParse(widget.initial!.meetTime)?.toLocal()
      : null;
  late int _hours = (widget.initial?.duration ?? 1).clamp(1, 24);
  late bool _reportNeeded = widget.initial?.isReportNeeded ?? false;
  bool _timeMissing = false;

  @override
  void initState() {
    super.initState();
    if (_place.text.isEmpty && _mode == _Mode.online) _place.text = _platform ?? '';
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _place.dispose();
    _link.dispose();
    super.dispose();
  }

  Future<void> _pickTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _meetTime ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: _meetTime != null ? TimeOfDay.fromDateTime(_meetTime!) : const TimeOfDay(hour: 18, minute: 0),
    );
    if (time == null) return;
    setState(() {
      _meetTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
      _timeMissing = false;
    });
  }

  void _submit() {
    final valid = _formKey.currentState?.validate() ?? false;
    setState(() => _timeMissing = _meetTime == null);
    if (!valid || _meetTime == null) return;
    final online = _mode == _Mode.online;
    widget.onSubmit(
      MeetingForm(
        title: _title.text.trim(),
        description: _description.text.trim(),
        mode: online ? 'online' : 'offline',
        meetPlace: _place.text.trim(),
        meetTime: _meetTime!.toUtc().toIso8601String(),
        duration: _hours,
        isRecurring: widget.initial?.isRecurring ?? false,
        isReportNeeded: _reportNeeded,
        platform: online ? _platform : null,
        meetLink: online && _link.text.trim().isNotEmpty ? _link.text.trim() : null,
        recurrenceType: widget.initial?.recurrenceType,
        recurrence: widget.initial?.recurrence,
        reportDescription: widget.initial?.reportDescription,
      ),
    );
  }

  static String? _required(String? v) => (v == null || v.trim().isEmpty) ? 'Fill this in' : null;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final online = _mode == _Mode.online;
    final hourChoices = {1, 2, 3, 4, _hours}.toList()..sort();

    return Column(
      children: [
        Expanded(
          child: Form(
            key: _formKey,
            child: ListView(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              padding: const EdgeInsets.fromLTRB(
                MuSpacing.space5,
                MuSpacing.space2,
                MuSpacing.space5,
                MuSpacing.space8,
              ),
              children: [
                Semantics(header: true, child: Text(widget.title, style: mu.text.display.copyWith(fontSize: 32))),
                const SizedBox(height: MuSpacing.space6),
                MuTextField(
                  label: 'Title',
                  controller: _title,
                  hint: 'Week 3: Pandas groupby',
                  maxLength: 100,
                  textCapitalization: TextCapitalization.sentences,
                  validator: _required,
                ),
                const SizedBox(height: MuSpacing.space4),
                MuTextField(
                  label: 'What you will cover',
                  controller: _description,
                  maxLength: 1000,
                  maxLines: 5,
                  minLines: 3,
                  textCapitalization: TextCapitalization.sentences,
                  validator: _required,
                ),
                const SizedBox(height: MuSpacing.space5),
                Text('Where', style: mu.text.label.copyWith(color: c.ink2)),
                const SizedBox(height: MuSpacing.space2),
                MuSegmented<_Mode>(
                  values: _Mode.values,
                  selected: _mode,
                  label: (m) => m == _Mode.online ? 'Online' : 'In person',
                  onChanged: (m) => setState(() {
                    _mode = m;
                    // The place label defaults to the platform online; an
                    // address is typed for in person.
                    if (m == _Mode.online && _place.text.isEmpty) _place.text = _platform ?? '';
                    if (m == _Mode.offline && kMeetingPlatforms.contains(_place.text)) _place.clear();
                  }),
                ),
                const SizedBox(height: MuSpacing.space4),
                if (online) ...[
                  MuSelectField(
                    label: 'Platform',
                    value: _platform,
                    options: [for (final p in kMeetingPlatforms) MuOption(p, p)],
                    onChanged: (v) => setState(() {
                      final previous = _platform;
                      _platform = v;
                      if (v != null && (_place.text.isEmpty || _place.text == previous)) _place.text = v;
                    }),
                  ),
                  const SizedBox(height: MuSpacing.space4),
                  MuTextField(
                    label: 'Meeting link',
                    controller: _link,
                    hint: 'https://meet.google.com/…',
                    help: 'Shown to people going, once they RSVP.',
                    keyboardType: TextInputType.url,
                  ),
                  const SizedBox(height: MuSpacing.space4),
                  MuTextField(label: 'Place label', controller: _place, hint: 'Google Meet', validator: _required),
                ] else
                  MuTextField(
                    label: 'Venue',
                    controller: _place,
                    hint: 'Room 204, Main block',
                    textCapitalization: TextCapitalization.sentences,
                    validator: _required,
                  ),
                const SizedBox(height: MuSpacing.space5),
                Semantics(
                  button: true,
                  label: 'When, ${_meetTime == null ? 'not set' : formatDayTime(_meetTime!)}',
                  excludeSemantics: true,
                  onTap: _pickTime,
                  child: MuFieldChrome(
                    label: 'When',
                    error: _timeMissing ? 'Pick a date and time' : null,
                    onTap: _pickTime,
                    trailing: SizedBox.square(
                      dimension: MuSizes.touchMin,
                      child: Icon(LucideIcons.calendarClock, size: 20, color: c.ink3),
                    ),
                    child: Text(
                      _meetTime == null ? 'Pick a date and time' : formatDayTime(_meetTime!),
                      style: mu.text.body.copyWith(fontSize: 16, color: _meetTime == null ? c.ink3 : c.ink),
                    ),
                  ),
                ),
                const SizedBox(height: MuSpacing.space5),
                Text('How long', style: mu.text.label.copyWith(color: c.ink2)),
                const SizedBox(height: MuSpacing.space2),
                Wrap(
                  spacing: MuSpacing.space2,
                  runSpacing: MuSpacing.space2,
                  children: [
                    for (final h in hourChoices)
                      MuFilterChip(
                        label: h == 1 ? '1 hour' : '$h hours',
                        selected: _hours == h,
                        onTap: () => setState(() => _hours = h),
                      ),
                  ],
                ),
                const SizedBox(height: MuSpacing.space5),
                MuSwitchTile(
                  label: 'Ask attendees for a report',
                  subtitle: 'Each one writes what they learned after the meeting.',
                  value: _reportNeeded,
                  onChanged: (v) => setState(() => _reportNeeded = v),
                ),
              ],
            ),
          ),
        ),
        DecoratedBox(
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
                if (widget.errorMessage != null) ...[
                  Text(widget.errorMessage!, style: mu.text.caption.copyWith(color: c.danger)),
                  const SizedBox(height: MuSpacing.space2),
                ],
                MuButton(
                  label: widget.submitLabel,
                  block: true,
                  loading: widget.isSubmitting,
                  onPressed: widget.isSubmitting ? null : _submit,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
