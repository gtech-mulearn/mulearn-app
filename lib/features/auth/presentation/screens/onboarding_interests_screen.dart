import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_shadow.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_chip.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/features/auth/data/interests_quiz_data.dart';
import 'package:mulearn_app/features/auth/domain/entities/endgoal.dart';
import 'package:mulearn_app/features/auth/domain/entities/pathway.dart';
import 'package:mulearn_app/features/auth/presentation/providers/interests_controller.dart';

const double _kOnboardingPadH = 26;

enum _InterestsMode { choice, quiz, direct }

/// Post-registration onboarding tour, matching DESIGN_SPEC.md §2 "02 —
/// Onboarding": a 4-step tour (intro value-prop / interactive karma demo /
/// seven-levels list / goal picker) leading into the reference dashboard's
/// real `/onboarding/interests` mechanic.
///
/// Steps 0–2 are purely illustrative value-prop screens (static mock cards,
/// a non-persisted demo counter, and a hardcoded seven-level list — level
/// *names and karma thresholds* are a stable product fact, not per-user
/// data, so hardcoding them here rather than fabricating an unauthenticated
/// fetch is deliberate). Step 3 is the real picker: pick either the
/// PathFinder quiz (5 questions → top-2 pathways, no endgoals) or the direct
/// picker (pathways then endgoals, both required) — this is byte-for-byte
/// the same submission logic ([InterestsController.submitPathwaysOnly] /
/// [InterestsController.submitPathwaysAndEndgoals]) the screen made before
/// this restyle, just reskinned; nothing about how many items can be
/// selected or what gets submitted has changed.
///
/// "Skip" (new — the previous version of this screen had none) jumps
/// straight from an illustrative step (0–2) to the real goal-picker step
/// (3) rather than all the way to Home like the design mock does, since
/// skipping interest selection entirely would be a product-behavior change,
/// not a visual one — out of scope for this restyle.
///
/// The reference's "already onboarded? skip straight to dashboard" guard and
/// role-based redirect aren't replicated here — both need a `user info`
/// endpoint/role-specific dashboards this app doesn't have yet (flagged, not
/// silently built). Every path here still redirects to `/home` on
/// completion, unchanged from before.
class OnboardingInterestsScreen extends ConsumerStatefulWidget {
  const OnboardingInterestsScreen({super.key});

  @override
  ConsumerState<OnboardingInterestsScreen> createState() =>
      _OnboardingInterestsScreenState();
}

class _OnboardingInterestsScreenState
    extends ConsumerState<OnboardingInterestsScreen> {
  int _step = 0;
  _InterestsMode _mode = _InterestsMode.choice;

  void _next() => setState(() => _step += 1);
  void _back() => setState(() => _step -= 1);
  void _skipToGoalStep() => setState(() => _step = 3);

  void _complete() {
    if (context.mounted) context.go(RoutePaths.home);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(interestsControllerProvider, (_, next) {
      if (next.hasError && !next.isLoading) {
        final error = next.error;
        final message = ApiException.messageFor(error!);
        MuToast.show(context, message: message, type: MuToastType.error);
      }
    });

    final dark = _step == 2;

    return Scaffold(
      backgroundColor: dark ? MuColors.ink : MuColors.canvas,
      body: Stack(
        children: [
          _OnboardingBackdrop(dark: dark),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: _kOnboardingPadH),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: MuSpace.m),
                  _ProgressRow(
                    step: _step,
                    dark: dark,
                    onSkip: _step < 3 ? _skipToGoalStep : null,
                  ),
                  const SizedBox(height: MuSpace.xl),
                  Expanded(
                    child: switch (_step) {
                      0 => _IntroStep(onNext: _next),
                      1 => _KarmaDemoStep(onNext: _next, onBack: _back),
                      2 => _LevelsStep(onNext: _next, onBack: _back),
                      _ => switch (_mode) {
                          _InterestsMode.choice => _ChoiceView(
                              onQuiz: () =>
                                  setState(() => _mode = _InterestsMode.quiz),
                              onDirect: () => setState(
                                  () => _mode = _InterestsMode.direct),
                              onBack: _back,
                            ),
                          _InterestsMode.quiz =>
                            _QuizView(onComplete: _complete),
                          _InterestsMode.direct =>
                            _DirectView(onComplete: _complete),
                        },
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Soft, static two-orb wash behind every onboarding step — a calmer stand-in
/// for the mock's CSS `drift` keyframe animation (DESIGN_SPEC.md §1
/// "Animations"), not ported pixel-for-pixel.
class _OnboardingBackdrop extends StatelessWidget {
  const _OnboardingBackdrop({required this.dark});

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: ClipRect(
          child: Stack(
            children: [
              Container(color: dark ? MuColors.ink : MuColors.canvas),
              Positioned(
                top: -70,
                left: -70,
                child: _orb(dark ? MuColors.primary : MuColors.primary, 240, dark ? 0.22 : 0.16),
              ),
              Positioned(
                bottom: -90,
                right: -80,
                child: _orb(MuColors.karmaAccent, 260, dark ? 0.22 : 0.14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _orb(Color color, double size, double opacity) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color.withValues(alpha: opacity)),
    );
  }
}

/// Top-of-screen 4-segment progress row (current segment wider) + optional
/// "Skip" link (DESIGN_SPEC.md §2 Onboarding "Shared chrome").
class _ProgressRow extends StatelessWidget {
  const _ProgressRow({required this.step, required this.dark, this.onSkip});

  final int step;
  final bool dark;
  final VoidCallback? onSkip;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              for (var i = 0; i < 4; i++) ...[
                if (i > 0) const SizedBox(width: 6),
                Expanded(
                  flex: i == step ? 3 : 1,
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: i <= step
                          ? (dark ? MuColors.surface : MuColors.primary)
                          : (dark ? Colors.white.withValues(alpha: 0.16) : MuColors.divider),
                      borderRadius: BorderRadius.circular(MuRadius.chip),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        if (onSkip != null) ...[
          const SizedBox(width: MuSpace.m),
          TextButton(
            onPressed: onSkip,
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            child: Text(
              'Skip',
              style: MuType.chip.copyWith(color: dark ? Colors.white70 : MuColors.inkTertiary),
            ),
          ),
        ],
      ],
    );
  }
}

/// Shared bottom CTA pill + optional text link below it, reused by steps 0–2.
class _StepCtaRow extends StatelessWidget {
  const _StepCtaRow({
    required this.ctaLabel,
    required this.onCta,
    this.backLabel,
    this.onBack,
    this.dark = false,
  });

  final String ctaLabel;
  final VoidCallback onCta;
  final String? backLabel;
  final VoidCallback? onBack;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: MuSpace.l, bottom: MuSpace.m),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MuPrimaryButton(label: ctaLabel, icon: LucideIcons.arrowRight, onPressed: onCta),
          if (backLabel != null) ...[
            const SizedBox(height: MuSpace.s),
            TextButton(
              onPressed: onBack,
              child: Text(
                backLabel!,
                style: MuType.chip.copyWith(color: dark ? Colors.white70 : MuColors.inkSecondary),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Step 0 — intro / value prop (DESIGN_SPEC.md §2 Onboarding "Step 0").
class _IntroStep extends StatelessWidget {
  const _IntroStep({required this.onNext});

  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '65,000 STUDENTS · A GTECH INITIATIVE',
                  style: MuType.eyebrow.copyWith(color: MuColors.primary),
                ),
                const SizedBox(height: MuSpace.s),
                Text(
                  'Your degree says what you studied. Karma says what you can do.',
                  style: MuType.display.copyWith(fontSize: 30),
                ),
                const SizedBox(height: MuSpace.s),
                Text(
                  'Students across Kerala are building the skills industry actually '
                  'asks for — one proven task at a time.',
                  style: MuType.body.copyWith(color: MuColors.inkSecondary),
                ),
                const SizedBox(height: MuSpace.xxl),
                const _IntroFloatingCards(),
              ],
            ),
          ),
        ),
        _StepCtaRow(ctaLabel: 'Show me how', onCta: onNext),
      ],
    );
  }
}

/// Simplified, static versions of the mock's floating illustrative cards —
/// not real data for this pre-onboarding user, purely value-prop dressing.
class _IntroFloatingCards extends StatelessWidget {
  const _IntroFloatingCards();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Transform.rotate(angle: -0.04, child: _taskCompleteCard()),
        const SizedBox(height: MuSpace.m),
        Align(
          alignment: Alignment.centerRight,
          child: Transform.rotate(angle: 0.04, child: _rankCard()),
        ),
        const SizedBox(height: MuSpace.m),
        Transform.rotate(angle: -0.02, child: _approvedCard()),
      ],
    );
  }

  Widget _taskCompleteCard() => Container(
        padding: const EdgeInsets.all(MuSpace.m),
        decoration: BoxDecoration(
          color: MuColors.surface,
          borderRadius: BorderRadius.circular(MuRadius.inner),
          boxShadow: MuShadow.card,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('TASK COMPLETE', style: MuType.tag.copyWith(color: MuColors.primary)),
            const SizedBox(height: MuSpace.xs),
            Text('Deployed my first landing page', style: MuType.bodyMed.copyWith(fontSize: 13)),
            const SizedBox(height: MuSpace.xs),
            Text(
              '+250 karma',
              style: MuType.bodyMed.copyWith(color: MuColors.karmaAccent, fontSize: 13),
            ),
          ],
        ),
      );

  Widget _rankCard() => Container(
        width: 170,
        padding: const EdgeInsets.all(MuSpace.m),
        decoration: BoxDecoration(
          color: MuColors.ink,
          borderRadius: BorderRadius.circular(MuRadius.inner),
          boxShadow: MuShadow.card,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('RANK', style: MuType.tag.copyWith(color: Colors.white60)),
            const SizedBox(height: MuSpace.xs),
            Text('#263', style: MuType.stat.copyWith(color: Colors.white, fontSize: 22)),
            const SizedBox(height: MuSpace.xs),
            Text('Top 1% this week', style: MuType.caption.copyWith(color: Colors.white60)),
          ],
        ),
      );

  Widget _approvedCard() => Container(
        padding: const EdgeInsets.all(MuSpace.m),
        decoration: BoxDecoration(
          color: MuColors.surface,
          borderRadius: BorderRadius.circular(MuRadius.inner),
          boxShadow: MuShadow.card,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 28,
              width: 28,
              decoration: const BoxDecoration(color: MuColors.successBg, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: const Icon(LucideIcons.check, size: 14, color: MuColors.success),
            ),
            const SizedBox(width: MuSpace.s),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Mentor approved it', style: MuType.bodyMed.copyWith(fontSize: 13)),
                  Text('Anand K · 4 hours ago', style: MuType.caption),
                ],
              ),
            ),
          ],
        ),
      );
}

/// Step 1 — interactive karma demo (DESIGN_SPEC.md §2 Onboarding "Step 1").
/// Purely illustrative: local, non-persisted state that resets if the user
/// navigates away — matches the mock's own "tap to see how karma lands"
/// demo, not real task data.
class _KarmaDemoStep extends StatefulWidget {
  const _KarmaDemoStep({required this.onNext, required this.onBack});

  final VoidCallback onNext;
  final VoidCallback onBack;

  @override
  State<_KarmaDemoStep> createState() => _KarmaDemoStepState();
}

class _KarmaDemoStepState extends State<_KarmaDemoStep> {
  static const List<({String label, int karma})> _demoTasks = [
    (label: 'Self intro', karma: 20),
    (label: 'Discord guide', karma: 100),
    (label: 'First commit', karma: 50),
  ];

  final Set<int> _done = {};

  int get _earned => [for (final i in _done) _demoTasks[i].karma].fold(0, (a, b) => a + b);

  String get _hint {
    if (_done.isEmpty) return 'Tap a task to see how karma lands.';
    if (_done.length == _demoTasks.length) {
      return 'That is $_earned of 500. Level 2 is closer than it looks.';
    }
    final left = _demoTasks.length - _done.length;
    return '$_earned karma so far — $left more task${left == 1 ? '' : 's'} to go.';
  }

  void _toggle(int i) => setState(() {
        if (!_done.remove(i)) _done.add(i);
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('HOW IT WORKS', style: MuType.eyebrow.copyWith(color: MuColors.primary)),
                const SizedBox(height: MuSpace.s),
                Text(
                  'Do a task. Prove it. Earn karma.',
                  style: MuType.display.copyWith(fontSize: 30),
                ),
                const SizedBox(height: MuSpace.s),
                Text(
                  'Tap the three starter tasks below and watch karma land. Real '
                  'submissions get reviewed by a mentor first.',
                  style: MuType.body.copyWith(color: MuColors.inkSecondary),
                ),
                const SizedBox(height: MuSpace.xl),
                _KarmaDemoCard(
                  demoTasks: _demoTasks,
                  done: _done,
                  earned: _earned,
                  hint: _hint,
                  onToggle: _toggle,
                ),
              ],
            ),
          ),
        ),
        _StepCtaRow(ctaLabel: 'Got it', onCta: widget.onNext, backLabel: 'Back', onBack: widget.onBack),
      ],
    );
  }
}

class _KarmaDemoCard extends StatelessWidget {
  const _KarmaDemoCard({
    required this.demoTasks,
    required this.done,
    required this.earned,
    required this.hint,
    required this.onToggle,
  });

  final List<({String label, int karma})> demoTasks;
  final Set<int> done;
  final int earned;
  final String hint;
  final ValueChanged<int> onToggle;

  static const _max = 500;

  @override
  Widget build(BuildContext context) {
    final pct = (earned / _max).clamp(0.0, 1.0);
    return Container(
      padding: const EdgeInsets.all(MuSpace.l),
      decoration: BoxDecoration(
        color: MuColors.ink,
        borderRadius: BorderRadius.circular(MuRadius.hero),
        boxShadow: MuShadow.hero,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('LEVEL 1 · INITIATE', style: MuType.tag.copyWith(color: Colors.white60)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: MuColors.karmaAccent.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(MuRadius.chip),
                ),
                child: Text('LIVE', style: MuType.tag.copyWith(color: MuColors.karmaAccent)),
              ),
            ],
          ),
          const SizedBox(height: MuSpace.m),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              '$earned',
              key: ValueKey(earned),
              style: MuType.stat.copyWith(color: Colors.white, fontSize: 46),
            ),
          ),
          Text('/ $_max karma', style: MuType.caption.copyWith(color: Colors.white60)),
          const SizedBox(height: MuSpace.m),
          ClipRRect(
            borderRadius: BorderRadius.circular(MuRadius.chip),
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              tween: Tween(begin: 0, end: pct),
              builder: (context, value, _) => LinearProgressIndicator(
                value: value,
                minHeight: 9,
                backgroundColor: Colors.white.withValues(alpha: 0.14),
                valueColor: const AlwaysStoppedAnimation(MuColors.primary),
              ),
            ),
          ),
          const SizedBox(height: MuSpace.l),
          for (var i = 0; i < demoTasks.length; i++) ...[
            _DemoTaskRow(task: demoTasks[i], done: done.contains(i), onTap: () => onToggle(i)),
            if (i != demoTasks.length - 1) const SizedBox(height: MuSpace.s),
          ],
          const SizedBox(height: MuSpace.m),
          Text(hint, style: MuType.caption.copyWith(color: Colors.white60)),
        ],
      ),
    );
  }
}

class _DemoTaskRow extends StatelessWidget {
  const _DemoTaskRow({required this.task, required this.done, required this.onTap});

  final ({String label, int karma}) task;
  final bool done;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: MuSpace.m, vertical: MuSpace.s + 2),
        decoration: BoxDecoration(
          color: done ? MuColors.karmaAccent.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(MuRadius.inner),
          border: Border.all(
            color: done ? MuColors.karmaAccent : Colors.white.withValues(alpha: 0.1),
          ),
        ),
        child: Row(
          children: [
            Icon(
              done ? LucideIcons.checkCircle2 : LucideIcons.circle,
              size: 18,
              color: done ? MuColors.karmaAccent : Colors.white38,
            ),
            const SizedBox(width: MuSpace.s),
            Expanded(
              child: Text(
                task.label,
                style: MuType.bodyMed.copyWith(color: Colors.white, fontSize: 14),
              ),
            ),
            Text(
              '+${task.karma}',
              style: MuType.bodyMed.copyWith(color: MuColors.karmaAccent, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

/// Step 2 — seven levels list (DESIGN_SPEC.md §2 Onboarding "Step 2"), dark
/// theme. Level names and karma thresholds are hardcoded static UI copy — a
/// stable product fact, not per-user data — since there's no clean
/// unauthenticated way to fetch level definitions pre-signup (`UserLevel`
/// only carries `name`/`karma` for the *current signed-in user's* progress,
/// fetched via `getUserLevels()`, which needs an authenticated session this
/// screen runs before). No per-user progress is shown or implied here.
class _LevelsStep extends StatelessWidget {
  const _LevelsStep({required this.onNext, required this.onBack});

  final VoidCallback onNext;
  final VoidCallback onBack;

  static const List<({int n, String name, String range, String? tag})> _levels = [
    (n: 1, name: 'Initiate', range: '0 – 500 karma', tag: null),
    (n: 2, name: 'Explorer', range: '500 – 1,500 karma', tag: null),
    (n: 3, name: 'Builder', range: '1,500 – 3,500 karma', tag: null),
    (n: 4, name: 'Specialist', range: '3,500 – 7,000 karma', tag: 'Interest groups'),
    (n: 5, name: 'Practitioner', range: '7,000 – 12,000 karma', tag: null),
    (n: 6, name: 'Mentor', range: '12,000 – 20,000 karma', tag: null),
    (n: 7, name: 'Master', range: '20,000+ karma', tag: 'Mastery'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('SEVEN LEVELS', style: MuType.eyebrow.copyWith(color: MuColors.karmaAccent)),
        const SizedBox(height: MuSpace.s),
        Text(
          'Every level unlocks harder work.',
          style: MuType.display.copyWith(fontSize: 30, color: MuColors.surface),
        ),
        const SizedBox(height: MuSpace.s),
        Text(
          'Interest groups open at level 4. By level 7 you have mastered a '
          'domain in public.',
          style: MuType.body.copyWith(color: Colors.white70),
        ),
        const SizedBox(height: MuSpace.l),
        Expanded(
          child: ListView.separated(
            itemCount: _levels.length,
            separatorBuilder: (_, __) => const SizedBox(height: MuSpace.s),
            itemBuilder: (context, i) => _LevelRow(level: _levels[i]),
          ),
        ),
        _StepCtaRow(
          ctaLabel: 'Makes sense',
          onCta: onNext,
          backLabel: 'Back',
          onBack: onBack,
          dark: true,
        ),
      ],
    );
  }
}

class _LevelRow extends StatelessWidget {
  const _LevelRow({required this.level});

  final ({int n, String name, String range, String? tag}) level;

  @override
  Widget build(BuildContext context) {
    final highlighted = level.tag != null;
    return Container(
      padding: const EdgeInsets.all(MuSpace.m),
      decoration: BoxDecoration(
        color: highlighted ? MuColors.karmaAccent.withValues(alpha: 0.16) : Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(MuRadius.inner),
        border: highlighted ? Border.all(color: MuColors.karmaAccent.withValues(alpha: 0.5)) : null,
      ),
      child: Row(
        children: [
          Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              color: highlighted ? MuColors.karmaAccent : Colors.white.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '${level.n}',
              style: MuType.bodyMed.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(width: MuSpace.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(level.name, style: MuType.bodyMed.copyWith(color: Colors.white)),
                Text(level.range, style: MuType.caption.copyWith(color: Colors.white60)),
              ],
            ),
          ),
          if (level.tag != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: MuColors.karmaAccent,
                borderRadius: BorderRadius.circular(MuRadius.chip),
              ),
              child: Text(level.tag!.toUpperCase(), style: MuType.tag.copyWith(color: Colors.white)),
            ),
        ],
      ),
    );
  }
}

/// Step 3 — the real goal picker (DESIGN_SPEC.md §2 Onboarding "Step 3").
/// The mock's single-select 4-option "Where do you want to start?" pattern
/// doesn't map onto this app's real backend mechanic (multi-select pathways,
/// then multi-select endgoals, with a PathFinder-quiz alternative), so per
/// the task's guidance this keeps the current screen's real picker
/// options/multi-select behavior exactly as before — only the visual
/// presentation (typography, spacing, chip/button chrome) changes.
class _ChoiceView extends StatelessWidget {
  const _ChoiceView({required this.onQuiz, required this.onDirect, required this.onBack});

  final VoidCallback onQuiz;
  final VoidCallback onDirect;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextButton.icon(
          onPressed: onBack,
          style: TextButton.styleFrom(padding: EdgeInsets.zero, alignment: Alignment.centerLeft),
          icon: const Icon(LucideIcons.arrowLeft, size: 18),
          label: const Text('Back'),
        ),
        const SizedBox(height: MuSpace.s),
        Text('ONE LAST THING', style: MuType.eyebrow.copyWith(color: MuColors.primary)),
        const SizedBox(height: MuSpace.s),
        Text('Where do you want to start?', style: MuType.display.copyWith(fontSize: 28)),
        const SizedBox(height: MuSpace.s),
        Text(
          'We shape your first tasks around this. Nothing is locked in — you '
          'can change direction whenever you like.',
          style: MuType.body.copyWith(color: MuColors.inkSecondary),
        ),
        const SizedBox(height: MuSpace.xl),
        _ChoiceCard(
          icon: LucideIcons.sparkles,
          title: 'Take the PathFinder Quiz',
          description: '5 quick questions to discover your pathways.',
          onTap: onQuiz,
        ),
        const SizedBox(height: MuSpace.m),
        _ChoiceCard(
          icon: LucideIcons.listChecks,
          title: 'I know what I want',
          description: 'Pick your pathways and end goals directly.',
          onTap: onDirect,
        ),
      ],
    );
  }
}

class _ChoiceCard extends StatelessWidget {
  const _ChoiceCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MuCard(
      onTap: onTap,
      padding: const EdgeInsets.all(MuSpace.l),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: MuColors.primaryTint,
              borderRadius: BorderRadius.circular(MuRadius.inner),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: MuColors.primary, size: 22),
          ),
          const SizedBox(width: MuSpace.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: MuType.bodyMed),
                const SizedBox(height: MuSpace.xs),
                Text(description, style: MuType.caption),
              ],
            ),
          ),
          const Icon(LucideIcons.chevronRight, color: MuColors.inkTertiary),
        ],
      ),
    );
  }
}

class _QuizView extends ConsumerStatefulWidget {
  const _QuizView({required this.onComplete});

  final VoidCallback onComplete;

  @override
  ConsumerState<_QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends ConsumerState<_QuizView> {
  late final List<QuizQuestion> _questions;
  int _index = 0;
  final Map<Pathway, int> _tally = {};

  @override
  void initState() {
    super.initState();
    _questions = List.of(kPathfinderQuizQuestions)..shuffle();
  }

  Future<void> _answer(Pathway pathway) async {
    _tally[pathway] = (_tally[pathway] ?? 0) + 1;
    if (_index < _questions.length - 1) {
      setState(() => _index += 1);
      return;
    }

    final ranked = _tally.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final topPathways = ranked.take(2).map((e) => e.key.name).toList();

    try {
      await ref
          .read(interestsControllerProvider.notifier)
          .submitPathwaysOnly(topPathways);
      widget.onComplete();
    } on Object catch (_) {
      // Surfaced via the ref.listen snackbar in the parent screen.
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_index];
    final isLoading = ref.watch(interestsControllerProvider).isLoading;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: MuSpace.l),
          ClipRRect(
            borderRadius: BorderRadius.circular(MuRadius.chip),
            child: LinearProgressIndicator(
              value: (_index + 1) / _questions.length,
              minHeight: 6,
              backgroundColor: MuColors.divider,
              valueColor: const AlwaysStoppedAnimation(MuColors.primary),
            ),
          ),
          const SizedBox(height: MuSpace.xl),
          Text(
            'Question ${_index + 1} of ${_questions.length}',
            style: MuType.caption,
          ),
          const SizedBox(height: MuSpace.s),
          Text(question.question, style: MuType.display.copyWith(fontSize: 24)),
          const SizedBox(height: MuSpace.xl),
          for (final option in question.options) ...[
            MuGhostButton(
              label: option.text,
              onPressed: isLoading ? null : () => _answer(option.pathway),
            ),
            const SizedBox(height: MuSpace.m),
          ],
          if (isLoading) ...[
            const SizedBox(height: MuSpace.m),
            const Center(child: CircularProgressIndicator()),
          ],
        ],
      ),
    );
  }
}

class _DirectView extends ConsumerStatefulWidget {
  const _DirectView({required this.onComplete});

  final VoidCallback onComplete;

  @override
  ConsumerState<_DirectView> createState() => _DirectViewState();
}

class _DirectViewState extends ConsumerState<_DirectView> {
  bool _onEndgoalsStep = false;
  final Set<Pathway> _selectedPathways = {};
  final Set<Endgoal> _selectedEndgoals = {};

  Future<void> _submit() async {
    try {
      await ref.read(interestsControllerProvider.notifier).submitPathwaysAndEndgoals(
            _selectedPathways.map((p) => p.name).toList(),
            _selectedEndgoals.map((e) => e.apiValue).toList(),
          );
      widget.onComplete();
    } on Object catch (_) {
      // Surfaced via the ref.listen snackbar in the parent screen.
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(interestsControllerProvider).isLoading;

    if (!_onEndgoalsStep) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: MuSpace.l),
            Text('Pick your pathways', style: MuType.display.copyWith(fontSize: 26)),
            const SizedBox(height: MuSpace.s),
            Text(
              'Select at least one — you can pick more than one.',
              style: MuType.body.copyWith(color: MuColors.inkSecondary),
            ),
            const SizedBox(height: MuSpace.xl),
            Wrap(
              spacing: MuSpace.m,
              runSpacing: MuSpace.m,
              children: [
                for (final pathway in Pathway.values)
                  MuFilterChip(
                    label: _pathwayLabel(pathway),
                    selected: _selectedPathways.contains(pathway),
                    onTap: () => setState(() {
                      if (_selectedPathways.contains(pathway)) {
                        _selectedPathways.remove(pathway);
                      } else {
                        _selectedPathways.add(pathway);
                      }
                    }),
                  ),
              ],
            ),
            const SizedBox(height: MuSpace.xl),
            MuPrimaryButton(
              label: 'Continue',
              onPressed: _selectedPathways.isEmpty
                  ? null
                  : () => setState(() => _onEndgoalsStep = true),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: MuSpace.l),
          TextButton.icon(
            onPressed: () => setState(() => _onEndgoalsStep = false),
            icon: const Icon(LucideIcons.arrowLeft, size: 18),
            label: const Text('Back'),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              alignment: Alignment.centerLeft,
            ),
          ),
          const SizedBox(height: MuSpace.s),
          Text('What are your end goals?', style: MuType.display.copyWith(fontSize: 26)),
          const SizedBox(height: MuSpace.s),
          Text(
            'Select at least one.',
            style: MuType.body.copyWith(color: MuColors.inkSecondary),
          ),
          const SizedBox(height: MuSpace.xl),
          Wrap(
            spacing: MuSpace.m,
            runSpacing: MuSpace.m,
            children: [
              for (final endgoal in Endgoal.values)
                MuFilterChip(
                  label: _endgoalLabel(endgoal),
                  selected: _selectedEndgoals.contains(endgoal),
                  onTap: () => setState(() {
                    if (_selectedEndgoals.contains(endgoal)) {
                      _selectedEndgoals.remove(endgoal);
                    } else {
                      _selectedEndgoals.add(endgoal);
                    }
                  }),
                ),
            ],
          ),
          const SizedBox(height: MuSpace.xl),
          MuPrimaryButton(
            label: isLoading ? 'Submitting…' : "Let's go!",
            onPressed: isLoading || _selectedEndgoals.isEmpty ? null : _submit,
          ),
        ],
      ),
    );
  }

  String _pathwayLabel(Pathway pathway) => switch (pathway) {
        Pathway.coder => 'Coder',
        Pathway.maker => 'Maker',
        Pathway.manager => 'Manager',
        Pathway.creative => 'Creative',
      };

  String _endgoalLabel(Endgoal endgoal) => switch (endgoal) {
        Endgoal.job => 'Job',
        Endgoal.researchAndDevelopment => 'Research & Development',
        Endgoal.entrepreneurship => 'Entrepreneurship',
        Endgoal.gigWork => 'Gig Work',
        Endgoal.higherEducation => 'Higher Education',
        Endgoal.socialImpact => 'Social Impact',
      };
}
