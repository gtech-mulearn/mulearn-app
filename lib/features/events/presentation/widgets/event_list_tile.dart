import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_shadow.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/features/events/domain/entities/event.dart';
import 'package:mulearn_app/features/events/presentation/providers/events_controller.dart';

/// A single row in the full events list (DESIGN_SPEC.md §2 "13 — Events") —
/// gradient banner with a date pill + format tag, title, meta, and an
/// interest toggle that calls the exact same [eventInterestControllerProvider]
/// the detail screen already uses.
class EventListTile extends ConsumerWidget {
  const EventListTile({
    required this.event,
    required this.onTap,
    super.key,
    this.gradientIndex = 0,
  });

  final Event event;
  final VoidCallback onTap;

  /// Cycles through [_gradients] purely for per-card visual variety — not
  /// tied to any data field (DESIGN_SPEC.md §2 "13": "a couple of alternate
  /// gradient looks per card").
  final int gradientIndex;

  static const _gradients = <LinearGradient>[
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [MuColors.primary, MuColors.karmaAccent],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [MuColors.ink, MuColors.primary],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [MuColors.karmaAccent, MuColors.primary],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [MuColors.ink, MuColors.karmaAccent],
    ),
  ];

  static const _months = [
    'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', //
    'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC',
  ];

  DateTime? get _start => DateTime.tryParse(event.startDatetime);

  String get _month {
    final start = _start;
    return start == null ? '' : _months[start.month - 1];
  }

  String get _day {
    final start = _start;
    return start == null ? '' : '${start.day}';
  }

  bool get _isOnline => event.venue.venueType == 'online';

  String get _venueLabel {
    if (_isOnline) return 'Online';
    return event.venue.venueCity ?? 'TBA';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gradient = _gradients[gradientIndex % _gradients.length];
    final interestState = ref.watch(eventInterestControllerProvider);
    final isBusy = interestState.isLoading;

    return Padding(
      padding: const EdgeInsets.only(bottom: MuSpace.l),
      child: Container(
        decoration: BoxDecoration(
          color: MuColors.surface,
          borderRadius: BorderRadius.circular(MuRadius.card),
          boxShadow: MuShadow.card,
        ),
        clipBehavior: Clip.antiAlias,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 7.5,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (event.coverImage != null)
                        CachedNetworkImage(
                          imageUrl: event.coverImage!,
                          fit: BoxFit.cover,
                          errorWidget: (_, __, ___) =>
                              DecoratedBox(decoration: BoxDecoration(gradient: gradient)),
                        )
                      else
                        DecoratedBox(decoration: BoxDecoration(gradient: gradient)),
                      Positioned(
                        left: MuSpace.m,
                        top: MuSpace.m,
                        child: _DatePill(month: _month, day: _day),
                      ),
                      Positioned(
                        right: MuSpace.m,
                        top: MuSpace.m,
                        child: _FormatTag(label: _isOnline ? 'ONLINE' : 'IN PERSON'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(MuSpace.l),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title,
                        style: MuType.bodyMed.copyWith(fontSize: 16),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: MuSpace.xs),
                      Row(
                        children: [
                          const Icon(LucideIcons.users, size: 13, color: MuColors.inkTertiary),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              '${event.interestCount} interested · $_venueLabel',
                              style: MuType.caption,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: MuSpace.m),
                      SizedBox(
                        width: double.infinity,
                        child: event.isInterested
                            ? MuGhostButton(
                                label: 'Interested',
                                icon: LucideIcons.checkCircle2,
                                onPressed: isBusy
                                    ? null
                                    : () => ref
                                        .read(eventInterestControllerProvider.notifier)
                                        .toggle(event.id, interested: false),
                              )
                            : MuPrimaryButton(
                                label: "I'm interested",
                                icon: LucideIcons.star,
                                onPressed: isBusy
                                    ? null
                                    : () => ref
                                        .read(eventInterestControllerProvider.notifier)
                                        .toggle(event.id, interested: true),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DatePill extends StatelessWidget {
  const _DatePill({required this.month, required this.day});

  final String month;
  final String day;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: MuColors.surface,
        borderRadius: BorderRadius.circular(MuRadius.inner),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(month, style: MuType.tag.copyWith(color: MuColors.inkSecondary, fontSize: 9)),
          Text(
            day,
            style: MuType.statSmall.copyWith(color: MuColors.ink, fontSize: 15, height: 1.1),
          ),
        ],
      ),
    );
  }
}

class _FormatTag extends StatelessWidget {
  const _FormatTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.32),
        borderRadius: BorderRadius.circular(MuRadius.chip),
      ),
      child: Text(label, style: MuType.tag.copyWith(color: MuColors.surface)),
    );
  }
}
