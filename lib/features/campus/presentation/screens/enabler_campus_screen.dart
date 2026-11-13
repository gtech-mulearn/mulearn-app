import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_chip.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/features/campus/domain/entities/enabler.dart';
import 'package:mulearn_app/features/campus/presentation/providers/enabler_providers.dart';

String _cap(String s) => s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';

/// One campus an enabler looks after: who it is, and the enabler's notes
/// (newest first), with Add note. Notes can't be edited or deleted.
class EnablerCampusScreen extends ConsumerWidget {
  const EnablerCampusScreen({required this.campusId, super.key});

  final String campusId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campus = ref.watch(enablerCampusProvider(campusId));
    final notes = ref.watch(campusNotesControllerProvider(campusId));
    return Scaffold(
      backgroundColor: MuColors.canvas,
      appBar: AppBar(backgroundColor: MuColors.canvas, elevation: 0, title: const Text('Campus')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => unawaited(_addNote(context, ref)),
        icon: const Icon(LucideIcons.plus),
        label: const Text('Add note'),
      ),
      body: MuRefresh(
        onRefresh: () => Future.wait([
          ref.refresh(enablerCampusProvider(campusId).future),
          ref.refresh(campusNotesControllerProvider(campusId).future),
        ]),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(MuSpace.screenH, MuSpace.s, MuSpace.screenH, 96),
          children: [
            campus.when(
              skipError: true,
              skipLoadingOnReload: true,
              loading: () => const SizedBox(height: 60, child: Center(child: CircularProgressIndicator())),
              error: (e, _) => ErrorRetryView(error: e, onRetry: () => ref.invalidate(enablerCampusProvider(campusId))),
              data: (c) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(c.collegeName, style: MuType.title),
                  Text([c.campusCode, c.zone, c.orgType].where((x) => x.isNotEmpty).join(' · '), style: MuType.caption),
                ],
              ),
            ),
            const SizedBox(height: MuSpace.xl),
            Text('NOTES', style: MuType.eyebrow),
            const SizedBox(height: MuSpace.s),
            notes.when(
              skipError: true,
              skipLoadingOnReload: true,
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => ErrorRetryView(
                error: e,
                onRetry: () => ref.invalidate(campusNotesControllerProvider(campusId)),
              ),
              data: (list) => list.isEmpty
                  ? Text(
                      'No notes yet. Add what you discussed and when to follow up.',
                      style: MuType.body.copyWith(color: MuColors.inkSecondary),
                    )
                  : Column(children: [for (final n in list) _NoteCard(note: n)]),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addNote(BuildContext context, WidgetRef ref) async {
    final input = await showModalBottomSheet<({String note, String priority, DateTime? followUp})>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: MuColors.surface,
      builder: (_) => const _NoteSheet(),
    );
    if (input == null || !context.mounted) return;
    try {
      final message = await ref
          .read(campusNotesControllerProvider(campusId).notifier)
          .add(note: input.note, priority: input.priority, followUp: input.followUp);
      if (context.mounted) {
        MuToast.show(context, message: message.isEmpty ? 'Note added' : message, type: MuToastType.success);
      }
    } on Object catch (e) {
      if (context.mounted) MuToast.show(context, message: ApiException.messageFor(e), type: MuToastType.error);
    }
  }
}

class _NoteCard extends ConsumerWidget {
  const _NoteCard({required this.note});

  final CampusNote note;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final n = note;
    final now = ref.watch(clockProvider)().toLocal();
    final today = DateTime(now.year, now.month, now.day);
    final overdue = n.followUp != null && n.followUp!.isBefore(today) && n.status == 'open';
    return Padding(
      padding: const EdgeInsets.only(bottom: MuSpace.s),
      child: MuCard(
        padding: const EdgeInsets.all(MuSpace.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(n.note, style: MuType.body),
            const SizedBox(height: MuSpace.s),
            Wrap(
              spacing: MuSpace.s,
              runSpacing: MuSpace.xs,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                MuTagChip(
                  label: _cap(n.priority),
                  style: n.priority == 'high' ? MuTagStyle.deadline : MuTagStyle.neutral,
                ),
                MuTagChip(label: _cap(n.status), style: n.status == 'open' ? MuTagStyle.warning : MuTagStyle.success),
                if (n.followUp != null)
                  Text(
                    'Follow up ${formatDay(n.followUp!)}',
                    style: MuType.caption.copyWith(color: overdue ? MuColors.error : null),
                  ),
              ],
            ),
            const SizedBox(height: MuSpace.xs),
            Text(
              [if (n.author != null) n.author!, formatAgo(n.createdAt.toLocal(), now)].join(' · '),
              style: MuType.caption,
            ),
          ],
        ),
      ),
    );
  }
}

class _NoteSheet extends StatefulWidget {
  const _NoteSheet();

  @override
  State<_NoteSheet> createState() => _NoteSheetState();
}

class _NoteSheetState extends State<_NoteSheet> {
  final _note = TextEditingController();
  String _priority = 'medium';
  DateTime? _followUp;
  String? _error;

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(MuSpace.screenH, 0, MuSpace.screenH, MediaQuery.viewInsetsOf(context).bottom + MuSpace.l),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Add note', style: MuType.title),
            const SizedBox(height: MuSpace.m),
            TextField(
              controller: _note,
              autofocus: true,
              minLines: 3,
              maxLines: 6,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(labelText: 'Note', errorText: _error),
            ),
            const SizedBox(height: MuSpace.m),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'low', label: Text('Low')),
                ButtonSegment(value: 'medium', label: Text('Medium')),
                ButtonSegment(value: 'high', label: Text('High')),
              ],
              selected: {_priority},
              onSelectionChanged: (s) => setState(() => _priority = s.first),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Follow up', style: MuType.caption),
              subtitle: Text(_followUp == null ? 'No date' : formatDay(_followUp!), style: MuType.bodyMed),
              trailing: _followUp == null
                  ? const Icon(LucideIcons.calendarPlus, size: 18, color: MuColors.inkSecondary)
                  : IconButton(
                      tooltip: 'Clear follow-up date',
                      icon: const Icon(LucideIcons.x, size: 18),
                      onPressed: () => setState(() => _followUp = null),
                    ),
              onTap: () async {
                final now = DateTime.now();
                final picked = await showDatePicker(
                  context: context,
                  initialDate: now.add(const Duration(days: 7)),
                  firstDate: DateTime(now.year, now.month, now.day),
                  lastDate: DateTime(now.year + 2),
                );
                if (picked != null && mounted) setState(() => _followUp = picked);
              },
            ),
            const SizedBox(height: MuSpace.m),
            MuPrimaryButton(
              label: 'Save note',
              onPressed: () {
                final text = _note.text.trim();
                if (text.isEmpty) {
                  setState(() => _error = 'Write a note first.');
                  return;
                }
                Navigator.pop(context, (note: text, priority: _priority, followUp: _followUp));
              },
            ),
          ],
        ),
      ),
    );
  }
}
