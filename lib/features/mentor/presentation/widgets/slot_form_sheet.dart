import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/core/widgets/mu_chip.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/features/mentor/domain/availability_rules.dart';
import 'package:mulearn_app/features/mentor/domain/entities/availability_slot.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_draft.dart';
import 'package:mulearn_app/features/mentor/presentation/providers/availability_controller.dart';
import 'package:mulearn_app/features/mentor/presentation/providers/mentor_sessions_controller.dart';

/// Add a slot, or edit [slot] (with Delete). Saves itself and closes; the
/// backend's field errors stay on the sheet.
Future<void> showSlotSheet(BuildContext context, {AvailabilitySlot? slot}) => showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: MuColors.surface,
      builder: (_) => _SlotSheet(slot: slot),
    );

const _dayShort = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

class _SlotSheet extends ConsumerStatefulWidget {
  const _SlotSheet({this.slot});

  final AvailabilitySlot? slot;

  @override
  ConsumerState<_SlotSheet> createState() => _SlotSheetState();
}

class _SlotSheetState extends ConsumerState<_SlotSheet> {
  late SlotInput _input = widget.slot == null
      ? const SlotInput(weekday: 1, startMinutes: 600, endMinutes: 660, timezone: defaultTimezone)
      : SlotInput.from(widget.slot!);
  bool _busy = false;
  String? _error;
  Map<String, String> _fieldErrors = const {};

  Future<void> _pickTime({required bool start}) async {
    final minutes = start ? _input.startMinutes : _input.endMinutes;
    final picked = await showTimePicker(context: context, initialTime: TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60));
    if (picked == null || !mounted) return;
    final value = picked.hour * 60 + picked.minute;
    setState(() {
      if (start) {
        final length = _input.endMinutes - _input.startMinutes;
        _input = _input.copyWith(startMinutes: value, endMinutes: (value + (length > 0 ? length : 60)).clamp(0, 24 * 60 - 1));
      } else {
        _input = _input.copyWith(endMinutes: value);
      }
    });
  }

  Future<void> _save() async {
    final problem = _input.problem();
    if (problem != null) {
      setState(() => _error = problem);
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
      _fieldErrors = const {};
    });
    final controller = ref.read(availabilityControllerProvider.notifier);
    try {
      final slot = widget.slot;
      final message = slot == null ? await controller.add(_input) : await controller.edit(slot.id, _input);
      if (!mounted) return;
      MuToast.show(context, message: message.isEmpty ? 'Slot saved' : message, type: MuToastType.success);
      Navigator.pop(context);
    } on Object catch (e) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        if (e is ApiException && e.fieldErrors.isNotEmpty) {
          _fieldErrors = {for (final f in e.fieldErrors.entries) f.key: f.value.firstOrNull ?? ''};
          _error = _fieldErrors['non_field_errors'];
        } else {
          _error = ApiException.messageFor(e);
        }
      });
    }
  }

  Future<void> _delete() async {
    final slot = widget.slot!;
    final ok = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete this slot?'),
        content: Text('${weekdayName(slot.weekday)}, ${clockLabel(slot.startMinutes)} – ${clockLabel(slot.endMinutes)}'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(dialogContext, true), child: const Text('Delete')),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    try {
      final message = await ref.read(availabilityControllerProvider.notifier).delete(slot.id);
      if (!mounted) return;
      MuToast.show(context, message: message.isEmpty ? 'Slot deleted' : message, type: MuToastType.success);
      Navigator.pop(context);
    } on Object catch (e) {
      if (mounted) setState(() => _error = ApiException.messageFor(e));
    }
  }

  @override
  Widget build(BuildContext context) {
    // The slot's own group stays a choice even before (or without) the
    // mentor's list loading — a dropdown must contain its value.
    final loaded = ref.watch(mentorIgsProvider).value ?? const [];
    final ownId = _input.igId;
    final igs = [
      ...loaded,
      if (ownId != null && !loaded.any((ig) => ig.id == ownId))
        IgOption(id: ownId, name: widget.slot?.igId == ownId ? (widget.slot?.igName ?? 'Interest group') : 'Interest group'),
    ];
    final slots = ref.watch(availabilityControllerProvider).value ?? const [];
    final overlap = _input.overlapWith(slots, editingId: widget.slot?.id);
    final zones = {...mentorTimezones, _input.timezone}.toList();
    return Padding(
      padding: EdgeInsets.fromLTRB(MuSpace.screenH, 0, MuSpace.screenH, MediaQuery.viewInsetsOf(context).bottom + MuSpace.l),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(widget.slot == null ? 'Add slot' : 'Edit slot', style: MuType.title),
            const SizedBox(height: MuSpace.m),
            Wrap(
              spacing: MuSpace.s,
              runSpacing: MuSpace.s,
              children: [
                for (var d = 1; d <= 7; d++)
                  MuFilterChip(
                    label: _dayShort[d - 1],
                    selected: _input.weekday == d,
                    onTap: () => setState(() => _input = _input.copyWith(weekday: d)),
                  ),
              ],
            ),
            const SizedBox(height: MuSpace.s),
            Row(
              children: [
                Expanded(child: _TimeTile(label: 'From', value: clockLabel(_input.startMinutes), onTap: () => _pickTime(start: true))),
                const SizedBox(width: MuSpace.m),
                Expanded(child: _TimeTile(label: 'To', value: clockLabel(_input.endMinutes), onTap: () => _pickTime(start: false))),
              ],
            ),
            if (overlap != null)
              Text(
                'Overlaps ${clockLabel(overlap.startMinutes)} – ${clockLabel(overlap.endMinutes)} on ${weekdayName(overlap.weekday)}.',
                style: MuType.caption.copyWith(color: MuColors.warning),
              ),
            const SizedBox(height: MuSpace.m),
            DropdownButtonFormField<String?>(
              initialValue: _input.igId,
              isExpanded: true,
              decoration: InputDecoration(labelText: 'Interest group', errorText: _fieldErrors['ig']),
              items: [
                const DropdownMenuItem<String?>(child: Text('Any of my interest groups')),
                for (final ig in igs) DropdownMenuItem<String?>(value: ig.id, child: Text(ig.name, overflow: TextOverflow.ellipsis)),
              ],
              onChanged: (v) => setState(() => _input = _input.copyWith(igId: v)),
            ),
            const SizedBox(height: MuSpace.m),
            DropdownButtonFormField<String>(
              initialValue: _input.timezone,
              isExpanded: true,
              decoration: InputDecoration(labelText: 'Time zone', errorText: _fieldErrors['timezone']),
              items: [for (final z in zones) DropdownMenuItem(value: z, child: Text(z))],
              onChanged: (v) => setState(() => _input = _input.copyWith(timezone: v ?? defaultTimezone)),
            ),
            if (_error != null) ...[
              const SizedBox(height: MuSpace.m),
              Text(_error!, style: MuType.body.copyWith(color: MuColors.error)),
            ],
            const SizedBox(height: MuSpace.l),
            MuPrimaryButton(label: _busy ? 'Please wait…' : 'Save', onPressed: _busy ? null : () => unawaited(_save())),
            if (widget.slot != null)
              TextButton.icon(
                onPressed: _busy ? null : () => unawaited(_delete()),
                icon: const Icon(LucideIcons.trash2, size: 16, color: MuColors.error),
                label: Text('Delete slot', style: MuType.bodyMed.copyWith(color: MuColors.error)),
              ),
          ],
        ),
      ),
    );
  }
}

class _TimeTile extends StatelessWidget {
  const _TimeTile({required this.label, required this.value, required this.onTap});

  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(label, style: MuType.caption),
        subtitle: Text(value, style: MuType.bodyMed),
        trailing: const Icon(LucideIcons.clock, size: 18, color: MuColors.inkSecondary),
        onTap: onTap,
      );
}
