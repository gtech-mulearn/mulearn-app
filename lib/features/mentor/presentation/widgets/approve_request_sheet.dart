import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_enums.dart';
import 'package:mulearn_app/features/mentor/domain/entities/student_request.dart';

/// What the mentor settled on when approving.
typedef ApproveChoice = ({DateTime startsLocal, DateTime endsLocal, SessionMode mode, String meetingLink, String venue});

/// Approve with the learner's proposal pre-filled; the mentor can move the
/// time, change the mode and add the link. Null when dismissed.
Future<ApproveChoice?> showApproveRequestSheet(BuildContext context, StudentSessionRequest request) =>
    showModalBottomSheet<ApproveChoice>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: MuColors.surface,
      builder: (_) => _ApproveSheet(request: request),
    );

class _ApproveSheet extends StatefulWidget {
  const _ApproveSheet({required this.request});

  final StudentSessionRequest request;

  @override
  State<_ApproveSheet> createState() => _ApproveSheetState();
}

class _ApproveSheetState extends State<_ApproveSheet> {
  late DateTime _starts = widget.request.startsAt.toLocal();
  late DateTime _ends = widget.request.endsAt.toLocal();
  late SessionMode _mode = widget.request.mode == SessionMode.unknown ? SessionMode.online : widget.request.mode;
  late final _link = TextEditingController(text: widget.request.meetingLink ?? '');
  late final _venue = TextEditingController(text: widget.request.venue ?? '');

  @override
  void initState() {
    super.initState();
    _link.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _link.dispose();
    _venue.dispose();
    super.dispose();
  }

  Future<void> _pick({required bool start}) async {
    final initial = start ? _starts : _ends;
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
        final length = _ends.difference(_starts);
        _starts = picked;
        _ends = picked.add(length.isNegative ? const Duration(hours: 1) : length);
      } else {
        _ends = picked;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.request;
    final needsLink = _mode != SessionMode.offline && _link.text.trim().isEmpty;
    final endsBeforeStart = !_ends.isAfter(_starts);
    return Padding(
      padding: EdgeInsets.fromLTRB(MuSpace.screenH, 0, MuSpace.screenH, MediaQuery.viewInsetsOf(context).bottom + MuSpace.l),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Approve session request', style: MuType.title),
            Text('Requested by ${r.requesterName.isEmpty ? r.requesterMuid : r.requesterName}', style: MuType.caption),
            const SizedBox(height: MuSpace.m),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Starts', style: MuType.caption),
              subtitle: Text(formatDayTime(_starts), style: MuType.bodyMed),
              trailing: const Icon(LucideIcons.chevronRight, size: 18, color: MuColors.inkSecondary),
              onTap: () => _pick(start: true),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Ends', style: MuType.caption),
              subtitle: Text(
                endsBeforeStart ? 'Session start time must be before end time.' : formatDayTime(_ends),
                style: endsBeforeStart ? MuType.caption.copyWith(color: MuColors.error) : MuType.bodyMed,
              ),
              trailing: const Icon(LucideIcons.chevronRight, size: 18, color: MuColors.inkSecondary),
              onTap: () => _pick(start: false),
            ),
            SegmentedButton<SessionMode>(
              segments: const [
                ButtonSegment(value: SessionMode.online, label: Text('Online')),
                ButtonSegment(value: SessionMode.offline, label: Text('In person')),
                ButtonSegment(value: SessionMode.hybrid, label: Text('Hybrid')),
              ],
              selected: {_mode},
              onSelectionChanged: (s) => setState(() => _mode = s.first),
            ),
            const SizedBox(height: MuSpace.m),
            if (_mode != SessionMode.offline)
              TextFormField(
                controller: _link,
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                  labelText: 'Meeting link',
                  hintText: 'https://meet.google.com/...',
                  helperText: needsLink ? 'Add a meeting link so the learner can join.' : null,
                  suffixIcon: IconButton(
                    tooltip: 'Paste link',
                    icon: const Icon(LucideIcons.clipboardPaste, size: 18),
                    onPressed: () async {
                      final text = (await Clipboard.getData(Clipboard.kTextPlain))?.text?.trim();
                      if (text != null && text.isNotEmpty) _link.text = text;
                    },
                  ),
                ),
              ),
            if (_mode != SessionMode.online) ...[
              const SizedBox(height: MuSpace.m),
              TextFormField(controller: _venue, decoration: const InputDecoration(labelText: 'Venue', hintText: 'e.g. Room 1')),
            ],
            const SizedBox(height: MuSpace.l),
            MuPrimaryButton(
              // The dashboard's button.
              label: 'Approve & Schedule',
              onPressed: endsBeforeStart
                  ? null
                  : () => Navigator.pop<ApproveChoice>(context, (
                        startsLocal: _starts,
                        endsLocal: _ends,
                        mode: _mode,
                        meetingLink: _mode == SessionMode.offline ? '' : _link.text,
                        venue: _mode == SessionMode.online ? '' : _venue.text,
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
