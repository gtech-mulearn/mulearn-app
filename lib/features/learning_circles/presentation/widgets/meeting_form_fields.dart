import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_chip.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting_form.dart';

const kMeetingPlatforms = [
  'Zoom',
  'Google Meet',
  'Microsoft Teams',
  'Discord',
  'Other',
];

/// Shared create/edit meeting form — confirmed live (rules.md §3/§9):
/// `platform` is required whenever mode is online, and `meet_place` may
/// never be blank. Used by both [CreateMeetingScreen] and
/// [EditMeetingScreen] to avoid duplicating this form twice.
class MeetingFormFields extends StatefulWidget {
  const MeetingFormFields({
    required this.isSubmitting,
    required this.submitLabel,
    required this.onSubmit,
    super.key,
    this.initial,
    this.errorMessage,
  });

  final MeetingForm? initial;
  final bool isSubmitting;
  final String submitLabel;
  final String? errorMessage;
  final ValueChanged<MeetingForm> onSubmit;

  @override
  State<MeetingFormFields> createState() => _MeetingFormFieldsState();
}

class _MeetingFormFieldsState extends State<MeetingFormFields> {
  final _formKey = GlobalKey<FormState>();
  late final _titleController =
      TextEditingController(text: widget.initial?.title);
  late final _descriptionController =
      TextEditingController(text: widget.initial?.description);
  late final _meetPlaceController =
      TextEditingController(text: widget.initial?.meetPlace);
  late final _meetLinkController =
      TextEditingController(text: widget.initial?.meetLink);
  late final _durationController =
      TextEditingController(text: '${widget.initial?.duration ?? 1}');
  late String _mode = widget.initial?.mode ?? 'online';
  late String? _platform = widget.initial?.platform ?? kMeetingPlatforms.first;
  late DateTime? _meetTime = widget.initial?.meetTime != null
      ? DateTime.tryParse(widget.initial!.meetTime)?.toLocal()
      : null;
  late bool _isReportNeeded = widget.initial?.isReportNeeded ?? false;

  @override
  void initState() {
    super.initState();
    if (_meetPlaceController.text.isEmpty) {
      _meetPlaceController.text = _platform ?? '';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _meetPlaceController.dispose();
    _meetLinkController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  Future<void> _pickMeetTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _meetTime ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: _meetTime != null
          ? TimeOfDay.fromDateTime(_meetTime!)
          : TimeOfDay.now(),
    );
    if (time == null) return;
    setState(() {
      _meetTime =
          DateTime(date.year, date.month, date.day, time.hour, time.minute);
    });
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_meetTime == null) {
      MuToast.show(context, message: 'Pick a date and time.', type: MuToastType.error);
      return;
    }
    widget.onSubmit(MeetingForm(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      mode: _mode,
      meetPlace: _meetPlaceController.text.trim(),
      meetTime: _meetTime!.toUtc().toIso8601String(),
      duration: int.tryParse(_durationController.text) ?? 1,
      isRecurring: widget.initial?.isRecurring ?? false,
      isReportNeeded: _isReportNeeded,
      platform: _mode == 'online' ? _platform : null,
      meetLink: _mode == 'online' && _meetLinkController.text.trim().isNotEmpty
          ? _meetLinkController.text.trim()
          : null,
      recurrenceType: widget.initial?.recurrenceType,
      recurrence: widget.initial?.recurrence,
      reportDescription: widget.initial?.reportDescription,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(MuSpace.screenH),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _titleController,
              maxLength: 100,
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            TextFormField(
              controller: _descriptionController,
              maxLength: 1000,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Description'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: MuSpace.s),
            Row(
              children: [
                MuFilterChip(
                  label: 'Online',
                  selected: _mode == 'online',
                  onTap: () => setState(() => _mode = 'online'),
                ),
                const SizedBox(width: MuSpace.s),
                MuFilterChip(
                  label: 'Offline',
                  selected: _mode == 'offline',
                  onTap: () => setState(() => _mode = 'offline'),
                ),
              ],
            ),
            const SizedBox(height: MuSpace.l),
            if (_mode == 'online') ...[
              DropdownButtonFormField<String>(
                initialValue: _platform,
                decoration: const InputDecoration(labelText: 'Platform'),
                items: kMeetingPlatforms
                    .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                    .toList(),
                onChanged: (value) => setState(() {
                  _platform = value;
                  if (_meetPlaceController.text.isEmpty && value != null) {
                    _meetPlaceController.text = value;
                  }
                }),
              ),
              TextFormField(
                controller: _meetLinkController,
                decoration: const InputDecoration(labelText: 'Meeting link'),
              ),
              TextFormField(
                controller: _meetPlaceController,
                decoration: const InputDecoration(labelText: 'Meeting place label'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
            ] else
              TextFormField(
                controller: _meetPlaceController,
                decoration: const InputDecoration(labelText: 'Venue address'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
            const SizedBox(height: MuSpace.l),
            MuCard(
              onTap: _pickMeetTime,
              child: Row(
                children: [
                  const Icon(LucideIcons.calendarClock, size: 18, color: MuColors.inkSecondary),
                  const SizedBox(width: MuSpace.s),
                  Expanded(
                    child: Text(
                      _meetTime == null ? 'Pick date & time' : _meetTime.toString(),
                      style: MuType.body,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: MuSpace.l),
            TextFormField(
              controller: _durationController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Duration (hours)'),
            ),
            const SizedBox(height: MuSpace.l),
            Row(
              children: [
                Expanded(
                  child: Text('Report required from attendees', style: MuType.body),
                ),
                Switch(
                  value: _isReportNeeded,
                  activeThumbColor: MuColors.primary,
                  onChanged: (value) => setState(() => _isReportNeeded = value),
                ),
              ],
            ),
            if (widget.errorMessage != null) ...[
              const SizedBox(height: MuSpace.s),
              Text(
                widget.errorMessage!,
                style: MuType.caption.copyWith(color: MuColors.coral),
              ),
            ],
            const SizedBox(height: MuSpace.l),
            MuPrimaryButton(
              label: widget.isSubmitting ? 'Saving…' : widget.submitLabel,
              onPressed: widget.isSubmitting ? null : _submit,
            ),
          ],
        ),
      ),
    );
  }
}
