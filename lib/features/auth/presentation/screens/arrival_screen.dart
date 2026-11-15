import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/features/auth/domain/entities/public_community.dart';
import 'package:mulearn_app/features/auth/presentation/providers/welcome_providers.dart';
import 'package:mulearn_app/features/auth/presentation/widgets/arrival_panels.dart';

/// "1,949" or nothing: copy only ever states real numbers.
String? _n(int? v) => v == null || v <= 0 ? null : muGrouped(v);

/// The first-launch arrival (artifact Pre-login → The four beats): what
/// μLearn is, how learning works, who you learn with, and where it leads,
/// each on a live object you can touch. Swipe up through the beats;
/// Explore opens the app as a guest. Shown once per device.
class ArrivalScreen extends ConsumerStatefulWidget {
  const ArrivalScreen({super.key});

  @override
  ConsumerState<ArrivalScreen> createState() => _ArrivalScreenState();
}

class _ArrivalScreenState extends ConsumerState<ArrivalScreen> {
  final _pages = PageController();
  int _page = 0;

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  Future<void> _explore() async {
    unawaited(HapticFeedback.selectionClick());
    await ref.read(arrivalSeenProvider.notifier).markSeen();
    if (mounted) context.go(RoutePaths.commons);
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final stats = ref.watch(publicStatsProvider).value ?? const PublicStats();
    final groups = ref.watch(guestInterestGroupsProvider).value ?? const <GuestInterestGroup>[];
    final events = ref.watch(guestFeaturedEventsProvider).value ?? const <GuestEvent>[];

    final members = _n(stats.members);
    final campuses = _n(stats.campuses);
    final circles = _n(stats.circles);
    final mentors = _n(stats.mentors);
    final igs = _n(stats.interestGroups ?? (groups.isEmpty ? null : groups.length));
    final companies = _n(stats.companies);

    final beats = <_Beat>[
      _Beat(
        panel: RingPanel(groups: groups, groupCount: stats.interestGroups),
        lightIcons: true,
        eyebrow: [?(members == null ? null : '$members learners'), ?(campuses == null ? null : '$campuses campuses')],
        light: 'Your gateway to ',
        bold: 'peer-led growth',
        body:
            'An open community for learners, makers and innovators. '
            "Your degree doesn't define your potential. Your curiosity does.",
      ),
      const _Beat(
        panel: TaskPanel(),
        lightIcons: true,
        eyebrow: ['Tasks', 'Karma', '7 levels'],
        light: 'Learn by doing. ',
        bold: 'Prove it.',
        body:
            'Every task you finish earns karma: visible proof of what you have done, '
            'not just what you know. Karma carries you up seven levels.',
      ),
      _Beat(
        panel: const CirclePanel(),
        lightIcons: false,
        eyebrow: [
          ?(circles == null ? null : '$circles learning circles'),
          ?(mentors == null ? null : '$mentors mentors'),
        ],
        light: 'Learn from those ahead. ',
        bold: 'Mentor those behind.',
        body:
            '${igs == null ? 'Join a circle in your Interest Group.' : 'Join a circle in one of $igs Interest Groups.'} '
            "Meet every week, get unstuck together, and grow with peers who've been where you are.",
      ),
      _Beat(
        panel: TicketsPanel(event: events.isEmpty ? null : events.first, companies: stats.companies),
        lightIcons: false,
        eyebrow: ['Events', 'Career Lab', ?(companies == null ? null : '$companies companies')],
        light: 'From curious ',
        bold: 'to capable',
        body:
            'Bootcamps, hackathons and hiring calls with partner companies. '
            'Where it leads is yours to pick: a job, freelance work, research or a venture of your own.',
      ),
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: beats[_page].lightIcons ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: c.chalk,
        body: Stack(
          children: [
            PageView.builder(
              controller: _pages,
              scrollDirection: Axis.vertical,
              itemCount: beats.length,
              onPageChanged: (i) {
                HapticFeedback.selectionClick();
                setState(() => _page = i);
              },
              itemBuilder: (context, i) => Semantics(
                container: true,
                label: 'Step ${i + 1} of ${beats.length}',
                child: _BeatView(beat: beats[i]),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0, 0.3],
                    colors: [c.chalk.withValues(alpha: 0), c.chalk],
                  ),
                ),
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      MuSpacing.space5,
                      MuSpacing.space5,
                      MuSpacing.space5,
                      MuSpacing.space3,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: ExcludeSemantics(
                            child: Row(
                              children: [
                                for (var i = 0; i < beats.length; i++) ...[
                                  if (i > 0) const SizedBox(width: 5),
                                  Expanded(
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: i <= _page ? c.ink : c.line,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        MuButton(label: 'Explore', variant: MuButtonVariant.ink, knob: true, onPressed: _explore),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Beat {
  const _Beat({
    required this.panel,
    required this.lightIcons,
    required this.eyebrow,
    required this.light,
    required this.bold,
    required this.body,
  });

  final Widget panel;

  /// White status-bar icons over this panel.
  final bool lightIcons;

  /// Live facts, joined with dots; empty pieces are left out.
  final List<String> eyebrow;
  final String light;
  final String bold;
  final String body;
}

class _BeatView extends StatelessWidget {
  const _BeatView({required this.beat});

  final _Beat beat;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final screen = MediaQuery.sizeOf(context).height;
    // Copy and the bottom bar always get ~390dp; the panel takes the rest
    // (410 of 800 in the artifact), within sensible bounds.
    final panelH = (screen - 390).clamp(300.0, 480.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: panelH,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(MuRadii.poster)),
            child: beat.panel,
          ),
        ),
        Expanded(
          // Scrolls only when the copy doesn't fit (large text); a scroll
          // view whose content fits takes no drags, so swiping between beats
          // is unaffected. Bottom room keeps the last line clear of the bar.
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(MuSpacing.space6, 22, MuSpacing.space6, 96),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (beat.eyebrow.isNotEmpty)
                  Text(beat.eyebrow.join(' · ').toUpperCase(), style: mu.text.eyebrow.copyWith(color: c.ink3)),
                const SizedBox(height: MuSpacing.space2),
                Semantics(
                  header: true,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: beat.light, style: mu.text.displayLight.copyWith(fontSize: 34, height: 1.04)),
                        TextSpan(text: beat.bold, style: mu.text.display.copyWith(fontSize: 34, height: 1.04)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: MuSpacing.space3),
                Text(beat.body, style: mu.text.bodyLg.copyWith(fontSize: 16, color: c.ink2)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
