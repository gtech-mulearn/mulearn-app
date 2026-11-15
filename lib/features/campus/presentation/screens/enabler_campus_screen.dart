import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/features/campus/domain/entities/enabler.dart';
import 'package:mulearn_app/features/campus/presentation/providers/enabler_providers.dart';

String _cap(String s) => s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';

enum _Priority { low, medium, high }

/// One campus an enabler looks after: its seal and name, and the enabler's
/// notes (newest first) with Add note pinned. Notes can be deleted, not
/// edited or closed (the backend's PATCH rejects its own note_id).
class EnablerCampusScreen extends ConsumerWidget {
  const EnablerCampusScreen({required this.campusId, super.key});

  final String campusId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final campus = ref.watch(enablerCampusProvider(campusId));
    final notes = ref.watch(campusNotesControllerProvider(campusId));
    return MuWorkspacePage(
      bottom: MuButton(
        label: 'Add note',
        icon: LucideIcons.plus,
        block: true,
        onPressed: () => unawaited(_addNote(context, ref)),
      ),
      body: MuRefresh(
        onRefresh: () => Future.wait([
          ref.refresh(enablerCampusProvider(campusId).future),
          ref.refresh(campusNotesControllerProvider(campusId).future),
        ]),
        child: ListView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          padding: muListPadding,
          children: [
            campus.when(
              skipError: true,
              skipLoadingOnReload: true,
              loading: () => const SizedBox(height: 64, child: Center(child: MuDotsLoader())),
              error: (e, _) => ErrorRetryView(error: e, onRetry: () => ref.invalidate(enablerCampusProvider(campusId))),
              data: (c) => Row(
                children: [
                  MuCampusSeal(code: c.campusCode, size: 64),
                  const SizedBox(width: MuSpacing.space4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Semantics(header: true, child: Text(c.collegeName, style: mu.text.title1)),
                        const SizedBox(height: 2),
                        Text(
                          [c.campusCode, c.zone, c.orgType].where((x) => x.isNotEmpty).join(' · '),
                          style: mu.text.caption,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const MuSectionEyebrow('Notes'),
            notes.when(
              skipError: true,
              skipLoadingOnReload: true,
              loading: () => const Center(child: MuDotsLoader(label: 'Loading notes…')),
              error: (e, _) =>
                  ErrorRetryView(error: e, onRetry: () => ref.invalidate(campusNotesControllerProvider(campusId))),
              data: (list) => list.isEmpty
                  ? const MuEmptyLine('No notes yet. Add what you discussed and when to follow up.')
                  : Column(
                      children: [
                        for (var i = 0; i < list.length; i++) ...[
                          if (i > 0) const SizedBox(height: MuSpacing.space3),
                          _NoteCard(campusId: campusId, note: list[i]),
                        ],
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addNote(BuildContext context, WidgetRef ref) async {
    final input = await showMuSheet<({String note, String priority, DateTime? followUp})>(
      context,
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
  const _NoteCard({required this.campusId, required this.note});

  final String campusId;
  final CampusNote note;

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final sheetChoice = await showMuSheet<bool>(
      context,
      builder: (sheet) => MuSheetBody(
        title: 'Note actions',
        body: note.note,
        actions: [
          MuButton(
            label: 'Delete note',
            icon: LucideIcons.trash2,
            variant: MuButtonVariant.danger,
            block: true,
            onPressed: () => Navigator.of(sheet).pop(true),
          ),
        ],
      ),
    );
    if (sheetChoice != true || !context.mounted) return;
    final sure = await showMuConfirm(
      context,
      title: 'Delete this note?',
      body: "It can't be undone.",
      confirmLabel: 'Delete',
      destructive: true,
    );
    if (!sure || !context.mounted) return;
    try {
      final message = await ref.read(campusNotesControllerProvider(campusId).notifier).delete(note.id);
      if (context.mounted) {
        MuToast.show(context, message: message.isEmpty ? 'Note deleted' : message, type: MuToastType.success);
      }
    } on Object catch (e) {
      if (context.mounted) MuToast.show(context, message: ApiException.messageFor(e), type: MuToastType.error);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final c = mu.colors;
    final n = note;
    final now = ref.watch(clockProvider)().toLocal();
    final today = DateTime(now.year, now.month, now.day);
    final open = n.status == 'open';
    final overdue = n.followUp != null && n.followUp!.isBefore(today) && open;
    return MuSurfaceCard(
      padding: const EdgeInsets.fromLTRB(MuSpacing.space4, MuSpacing.space3, MuSpacing.space1, MuSpacing.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: MuSpacing.space2),
                  child: Text(n.note, style: mu.text.body),
                ),
              ),
              MuIconButton(
                icon: LucideIcons.moreVertical,
                tooltip: 'Note actions',
                variant: MuIconButtonVariant.sunk,
                onPressed: () => unawaited(_delete(context, ref)),
              ),
            ],
          ),
          const SizedBox(height: MuSpacing.space2),
          Padding(
            padding: const EdgeInsets.only(right: MuSpacing.space3),
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                if (n.priority == 'high')
                  MuPill(_cap(n.priority), tone: MuPillTone.danger, icon: LucideIcons.flag)
                else
                  MuPill(_cap(n.priority)),
                if (open)
                  MuPill(_cap(n.status), tone: MuPillTone.warning, icon: LucideIcons.circleDot)
                else
                  MuPill(_cap(n.status), tone: MuPillTone.success, icon: LucideIcons.check),
                if (n.followUp != null)
                  Text(
                    'Follow up ${formatDay(n.followUp!)}',
                    style: mu.text.caption.copyWith(color: overdue ? c.danger : null),
                  ),
              ],
            ),
          ),
          const SizedBox(height: MuSpacing.space2),
          Text(
            [if (n.author != null) n.author!, formatAgo(n.createdAt.toLocal(), now)].join(' · '),
            style: mu.text.caption,
          ),
        ],
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
  _Priority _priority = _Priority.medium;
  DateTime? _followUp;
  String? _error;

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  Future<void> _pickFollowUp() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _followUp ?? now.add(const Duration(days: 7)),
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(now.year + 2),
    );
    if (picked != null && mounted) setState(() => _followUp = picked);
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    return MuFormSheet(
      title: 'Add note',
      lead: 'What you discussed, and when to check in again.',
      action: MuButton(
        label: 'Save note',
        block: true,
        onPressed: () {
          final text = _note.text.trim();
          if (text.isEmpty) {
            setState(() => _error = 'Write a note first.');
            return;
          }
          Navigator.pop(context, (note: text, priority: _priority.name, followUp: _followUp));
        },
      ),
      children: [
        MuTextField(
          label: 'Note',
          controller: _note,
          error: _error,
          autofocus: true,
          minLines: 3,
          maxLines: 6,
          textCapitalization: TextCapitalization.sentences,
          onChanged: (_) {
            if (_error != null) setState(() => _error = null);
          },
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Priority', style: mu.text.label.copyWith(color: c.ink2)),
            const SizedBox(height: MuSpacing.space2),
            MuSegmented<_Priority>(
              values: _Priority.values,
              selected: _priority,
              label: (p) => _cap(p.name),
              onChanged: (p) => setState(() => _priority = p),
            ),
          ],
        ),
        Semantics(
          button: true,
          label: 'Follow up, ${_followUp == null ? 'no date' : formatDay(_followUp!)}',
          excludeSemantics: true,
          onTap: _pickFollowUp,
          child: MuFieldChrome(
            label: 'Follow up',
            onTap: _pickFollowUp,
            trailing: _followUp == null
                ? SizedBox.square(
                    dimension: MuSizes.touchMin,
                    child: Icon(LucideIcons.calendarPlus, size: 20, color: c.ink3),
                  )
                : MuIconButton(
                    icon: LucideIcons.x,
                    tooltip: 'Clear follow-up date',
                    variant: MuIconButtonVariant.sunk,
                    onPressed: () => setState(() => _followUp = null),
                  ),
            child: Text(
              _followUp == null ? 'No date' : formatDay(_followUp!),
              style: mu.text.body.copyWith(fontSize: 16, color: _followUp == null ? c.ink3 : c.ink),
            ),
          ),
        ),
      ],
    );
  }
}
