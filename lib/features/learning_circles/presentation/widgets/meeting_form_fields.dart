import 'package:flutter/material.dart';
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
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Pick a date and time.')));
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
      padding: const EdgeInsets.all(16),
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
            const SizedBox(height: 8),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'online', label: Text('Online')),
                ButtonSegment(value: 'offline', label: Text('Offline')),
              ],
              selected: {_mode},
              onSelectionChanged: (selection) =>
                  setState(() => _mode = selection.first),
            ),
            const SizedBox(height: 16),
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
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                  _meetTime == null ? 'Pick date & time' : _meetTime.toString()),
              trailing: const Icon(Icons.calendar_today),
              onTap: _pickMeetTime,
            ),
            TextFormField(
              controller: _durationController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Duration (hours)'),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Report required from attendees'),
              value: _isReportNeeded,
              onChanged: (value) => setState(() => _isReportNeeded = value),
            ),
            if (widget.errorMessage != null) ...[
              const SizedBox(height: 8),
              Text(
                widget.errorMessage!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
            const SizedBox(height: 16),
            FilledButton(
              onPressed: widget.isSubmitting ? null : _submit,
              child: Text(widget.isSubmitting ? 'Saving…' : widget.submitLabel),
            ),
          ],
        ),
      ),
    );
  }
}
