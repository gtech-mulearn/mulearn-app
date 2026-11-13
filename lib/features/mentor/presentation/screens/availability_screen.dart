import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/features/mentor/domain/availability_rules.dart';
import 'package:mulearn_app/features/mentor/domain/entities/availability_slot.dart';
import 'package:mulearn_app/features/mentor/presentation/providers/availability_controller.dart';
import 'package:mulearn_app/features/mentor/presentation/widgets/slot_form_sheet.dart';

/// The mentor's weekly availability (M5): slots by weekday, each with a
/// switch to pause it; tap a slot to change or delete it.
class AvailabilityScreen extends ConsumerWidget {
  const AvailabilityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(availabilityControllerProvider);
    return Scaffold(
      backgroundColor: MuColors.canvas,
      appBar: AppBar(backgroundColor: MuColors.canvas, elevation: 0, title: const Text('Weekly availability')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => unawaited(showSlotSheet(context)),
        icon: const Icon(LucideIcons.plus),
        label: const Text('Add slot'),
      ),
      body: state.when(
        skipError: true,
        skipLoadingOnReload: true,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorRetryView(error: e, onRetry: () => ref.invalidate(availabilityControllerProvider)),
        data: (slots) => MuRefresh(
          onRefresh: () => ref.refresh(availabilityControllerProvider.future),
          child: slots.isEmpty
              ? ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: const [
                    // The dashboard's availability tab says "No availability set.".
                    MuStateDisplay(
                      variant: MuStateVariant.noResults,
                      title: 'No availability set.',
                      description: 'Add the times each week when learners can book you.',
                    ),
                  ],
                )
              : ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(MuSpace.screenH, MuSpace.m, MuSpace.screenH, 96),
                  children: [
                    for (var day = 1; day <= 7; day++)
                      if (slots.any((s) => s.weekday == day)) ...[
                        Padding(
                          padding: const EdgeInsets.only(top: MuSpace.m, bottom: MuSpace.s),
                          child: Text(weekdayName(day).toUpperCase(), style: MuType.eyebrow),
                        ),
                        for (final s in slots.where((s) => s.weekday == day)) _SlotRow(slot: s),
                      ],
                  ],
                ),
        ),
      ),
    );
  }
}

class _SlotRow extends ConsumerWidget {
  const _SlotRow({required this.slot});

  final AvailabilitySlot slot;

  Future<void> _toggle(BuildContext context, WidgetRef ref, bool active) async {
    try {
      await ref.read(availabilityControllerProvider.notifier).setActive(slot.id, active: active);
    } on Object catch (e) {
      if (context.mounted) MuToast.show(context, message: ApiException.messageFor(e), type: MuToastType.error);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = '${clockLabel(slot.startMinutes)} – ${clockLabel(slot.endMinutes)}';
    return Padding(
      padding: const EdgeInsets.only(bottom: MuSpace.s),
      child: MuCard(
        onTap: () => unawaited(showSlotSheet(context, slot: slot)),
        padding: const EdgeInsets.fromLTRB(MuSpace.l, MuSpace.m, MuSpace.s, MuSpace.m),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    time,
                    style: MuType.bodyMed.copyWith(color: slot.isActive ? MuColors.ink : MuColors.inkSecondary),
                  ),
                  Text(
                    [slot.igName ?? 'Any interest group', slot.timezone].join(' · '),
                    style: MuType.caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (!slot.isActive) Text('Paused', style: MuType.caption.copyWith(color: MuColors.warning)),
                ],
              ),
            ),
            Semantics(
              label: slot.isActive ? 'Pause $time' : 'Resume $time',
              child: Switch(value: slot.isActive, onChanged: (v) => unawaited(_toggle(context, ref, v))),
            ),
          ],
        ),
      ),
    );
  }
}
