import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_participant.dart';

/// What the mentor recorded for one participant.
typedef AttendanceResult = ({AttendanceStatus attendance, int? minutes, String? note});

/// Attended / Absent, minutes and a progress note (the dashboard's
/// participant editor). Returns null when dismissed.
Future<AttendanceResult?> showAttendanceSheet(BuildContext context, SessionParticipant participant) =>
    showModalBottomSheet<AttendanceResult>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: MuColors.surface,
      builder: (_) => _AttendanceSheet(participant: participant),
    );

class _AttendanceSheet extends StatefulWidget {
  const _AttendanceSheet({required this.participant});

  final SessionParticipant participant;

  @override
  State<_AttendanceSheet> createState() => _AttendanceSheetState();
}

class _AttendanceSheetState extends State<_AttendanceSheet> {
  late AttendanceStatus _attendance;
  late final TextEditingController _minutes;
  late final TextEditingController _note;
  String? _minutesError;

  @override
  void initState() {
    super.initState();
    final p = widget.participant;
    _attendance = p.attendance == AttendanceStatus.absent ? AttendanceStatus.absent : AttendanceStatus.attended;
    _minutes = TextEditingController(text: p.contributedMinutes?.toString() ?? '');
    _note = TextEditingController(text: p.progressNote ?? '');
  }

  @override
  void dispose() {
    _minutes.dispose();
    _note.dispose();
    super.dispose();
  }

  void _save() {
    final text = _minutes.text.trim();
    final minutes = text.isEmpty ? null : int.tryParse(text);
    if (text.isNotEmpty && (minutes == null || minutes <= 0)) {
      // The backend's ParticipantUpdateSerializer message.
      setState(() => _minutesError = 'Contributed minutes must be greater than zero.');
      return;
    }
    final note = _note.text.trim();
    Navigator.pop<AttendanceResult>(
      context,
      (attendance: _attendance, minutes: minutes, note: note.isEmpty ? null : note),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        MuSpace.screenH,
        0,
        MuSpace.screenH,
        MediaQuery.viewInsetsOf(context).bottom + MuSpace.l,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(widget.participant.fullName, style: MuType.title),
          const SizedBox(height: MuSpace.m),
          SegmentedButton<AttendanceStatus>(
            segments: const [
              ButtonSegment(value: AttendanceStatus.attended, label: Text('Attended')),
              ButtonSegment(value: AttendanceStatus.absent, label: Text('Absent')),
            ],
            selected: {_attendance},
            onSelectionChanged: (s) => setState(() => _attendance = s.first),
          ),
          const SizedBox(height: MuSpace.m),
          TextFormField(
            controller: _minutes,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Minutes', errorText: _minutesError),
          ),
          const SizedBox(height: MuSpace.m),
          TextFormField(
            controller: _note,
            minLines: 2,
            maxLines: 4,
            decoration: const InputDecoration(labelText: 'Progress note'),
          ),
          const SizedBox(height: MuSpace.l),
          MuPrimaryButton(label: 'Save', onPressed: _save),
        ],
      ),
    );
  }
}
