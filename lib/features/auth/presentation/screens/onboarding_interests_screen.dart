import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/session/session_actions.dart';
import 'package:mulearn_app/features/auth/data/interests_quiz_data.dart';
import 'package:mulearn_app/features/auth/domain/entities/endgoal.dart';
import 'package:mulearn_app/features/auth/domain/entities/pathway.dart';
import 'package:mulearn_app/features/auth/presentation/providers/interests_controller.dart';
import 'package:mulearn_app/features/auth/presentation/widgets/auth_page.dart';

enum _Mode { choice, quiz, direct }

/// The dashboard's `/onboarding/interests` (`interests-client.tsx`), step by
/// step:
///  * "How would you like to discover your path?" — the PathFinder quiz or
///    "I know what I want".
///  * Quiz (`PathwayQuiz`): five questions in a shuffled order; pick an
///    answer, then Next; back takes the last answer back. Then the results —
///    "Welcome to the community!" with the two recommended paths — and only
///    "Begin your journey" saves them (pathways only, no end goals).
///  * Direct (`InterestSelector`): "Which one feels like you?" (one or more
///    pathways), then "What's your long-term tech goal?" (one or more end
///    goals); both are saved.
/// Every path lands on Home.
class OnboardingInterestsScreen extends ConsumerStatefulWidget {
  const OnboardingInterestsScreen({super.key});

  @override
  ConsumerState<OnboardingInterestsScreen> createState() =>
      _OnboardingInterestsScreenState();
}

/// The dashboard's eyebrow on every step.
const _eyebrow = 'Let’s bring out the true you';

class _OnboardingInterestsScreenState
    extends ConsumerState<OnboardingInterestsScreen> {
  _Mode _mode = _Mode.choice;

  void _complete() {
    if (context.mounted) context.go(RoutePaths.home);
  }

  void _to(_Mode mode) {
    unawaited(HapticFeedback.selectionClick());
    setState(() => _mode = mode);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(interestsControllerProvider, (_, next) {
      if (next.hasError && !next.isLoading) {
        MuToast.show(
          context,
          message: ApiException.messageFor(next.error!),
          type: MuToastType.error,
        );
      }
    });

    return PopScope(
      canPop: _mode == _Mode.choice,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _to(_Mode.choice);
      },
      child: switch (_mode) {
        _Mode.choice => _ChoiceView(
          onQuiz: () => _to(_Mode.quiz),
          onDirect: () => _to(_Mode.direct),
          // The router keeps a user without a pathway on this step, so it
          // needs its own way out (the wrong account, say).
          onSignOut: () => ref.read(sessionActionsProvider.notifier).signOut(),
        ),
        _Mode.quiz => _QuizView(
          onBack: () => _to(_Mode.choice),
          onComplete: _complete,
        ),
        _Mode.direct => _DirectView(
          onBack: () => _to(_Mode.choice),
          onComplete: _complete,
        ),
      },
    );
  }
}

class _ChoiceView extends StatelessWidget {
  const _ChoiceView({
    required this.onQuiz,
    required this.onDirect,
    required this.onSignOut,
  });

  final VoidCallback onQuiz;
  final VoidCallback onDirect;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    return AuthPage(
      eyebrow: _eyebrow,
      light: 'How would you like to ',
      bold: 'discover your path?',
      children: [
        _OptionCard(
          icon: LucideIcons.sparkles,
          title: 'Take the PathFinder quiz',
          subtitle: '5 quick questions to find your pathways.',
          onTap: onQuiz,
        ),
        const SizedBox(height: MuSpacing.space3),
        _OptionCard(
          icon: LucideIcons.listChecks,
          title: 'I know what I want',
          subtitle: 'Pick your pathways and end goals yourself.',
          onTap: onDirect,
        ),
        const SizedBox(height: MuSpacing.space6),
        Center(
          child: MuButton(
            label: 'Not you? Sign out',
            variant: MuButtonVariant.ghost,
            size: MuButtonSize.small,
            onPressed: onSignOut,
          ),
        ),
      ],
    );
  }
}

/// A large tappable card: icon well, title, line. A choice that moves on
/// ([selected] null) ends in a chevron; a pick ([selected] set) shows a
/// cobalt ring and a check when chosen.
class _OptionCard extends StatelessWidget {
  const _OptionCard({
    required this.title,
    required this.onTap,
    this.subtitle,
    this.icon,
    this.selected,
  });

  final IconData? icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool? selected;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final on = selected ?? false;
    return Semantics(
      button: true,
      checked: selected,
      label: [title, ?subtitle].join(', '),
      excludeSemantics: true,
      child: MuPressable(
        onTap: onTap,
        pressedScale: 0.98,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          constraints: const BoxConstraints(minHeight: 64),
          padding: const EdgeInsets.all(MuSpacing.space4),
          decoration: BoxDecoration(
            color: on ? c.cobaltTint : c.surface,
            borderRadius: BorderRadius.circular(MuRadii.card),
            border: Border.all(color: on ? c.cobalt : c.surface, width: 2),
          ),
          child: Row(
            children: [
              if (icon != null) ...[
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: on ? c.surface : c.cobaltTint,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: MuSizes.iconMd, color: c.cobaltText),
                ),
                const SizedBox(width: MuSpacing.space3),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: mu.text.title3),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: mu.text.body.copyWith(
                          fontSize: 14,
                          color: c.ink2,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: MuSpacing.space2),
              if (selected == null)
                Icon(
                  LucideIcons.chevronRight,
                  size: MuSizes.iconSm,
                  color: c.ink3,
                )
              else
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 160),
                  opacity: on ? 1 : 0,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: c.cobalt,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(LucideIcons.check, size: 14, color: c.onCobalt),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

const _pathwayIcons = {
  Pathway.coder: LucideIcons.code2,
  Pathway.maker: LucideIcons.wrench,
  Pathway.manager: LucideIcons.barChart3,
  Pathway.creative: LucideIcons.palette,
};

/// The dashboard's `PathwayQuiz`.
class _QuizView extends ConsumerStatefulWidget {
  const _QuizView({required this.onBack, required this.onComplete});

  final VoidCallback onBack;
  final VoidCallback onComplete;

  @override
  ConsumerState<_QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends ConsumerState<_QuizView> {
  // Shuffled once per visit, like the dashboard's useMemo.
  late final List<QuizQuestion> _questions = List.of(kPathfinderQuizQuestions)
    ..shuffle();
  int _index = 0;
  final List<Pathway> _answers = [];
  Pathway? _picked;
  bool _results = false;

  bool get _last => _index == _questions.length - 1;

  void _next() {
    final picked = _picked;
    if (picked == null) return;
    unawaited(HapticFeedback.selectionClick());
    setState(() {
      _answers.add(picked);
      _picked = null;
      if (_last) {
        _results = true;
      } else {
        _index += 1;
      }
    });
  }

  /// Back takes the last answer back and shows it picked (the dashboard's
  /// handleBack), so it's never counted twice.
  void _back() {
    if (_results) {
      setState(() {
        _results = false;
        _picked = _answers.removeLast();
      });
    } else if (_index > 0) {
      setState(() {
        _index -= 1;
        _picked = _answers.removeLast();
      });
    } else {
      widget.onBack();
    }
  }

  Future<void> _begin(List<Pathway> recommended) async {
    try {
      await ref
          .read(interestsControllerProvider.notifier)
          .submitPathwaysOnly(recommended.map((p) => p.name).toList());
      widget.onComplete();
    } on Object catch (_) {
      // Surfaced via the ref.listen toast in the parent screen.
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_results) return _results_(context);
    final question = _questions[_index];
    return AuthPage(
      step: _index + 1,
      steps: _questions.length,
      eyebrow: _eyebrow,
      light: '',
      bold: question.question,
      onBack: _back,
      bottom: MuButton(
        label: _last ? 'See my paths' : 'Next',
        block: true,
        knob: true,
        onPressed: _picked == null ? null : _next,
      ),
      children: [
        for (final option in question.options) ...[
          _OptionCard(
            icon: _pathwayIcons[option.pathway],
            title: option.text,
            selected: _picked == option.pathway,
            onTap: () {
              unawaited(HapticFeedback.selectionClick());
              setState(() => _picked = option.pathway);
            },
          ),
          const SizedBox(height: MuSpacing.space3),
        ],
      ],
    );
  }

  /// The dashboard's results: welcome, the two recommended paths with
  /// three of what each covers, and "Begin your journey" (which saves).
  Widget _results_(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final recommended = recommendPathways(_answers);
    final loading = ref.watch(interestsControllerProvider).isLoading;
    return AuthPage(
      eyebrow: 'You’re officially one of us',
      light: 'Welcome to the ',
      bold: 'community!',
      lead: 'Let’s build something amazing together.',
      onBack: loading ? null : _back,
      bottom: MuButton(
        label: 'Begin your journey',
        block: true,
        knob: true,
        loading: loading,
        loadingLabel: 'Saving your paths…',
        onPressed: loading ? null : () => _begin(recommended),
      ),
      children: [
        Text('Your recommended paths', style: mu.text.label),
        const SizedBox(height: MuSpacing.space3),
        for (final p in recommended) ...[
          Container(
            padding: const EdgeInsets.all(MuSpacing.space4),
            decoration: BoxDecoration(
              color: c.surface,
              borderRadius: BorderRadius.circular(MuRadii.card),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      _pathwayIcons[p],
                      size: MuSizes.iconMd,
                      color: c.cobaltText,
                    ),
                    const SizedBox(width: MuSpacing.space2),
                    Text(kPathwayInfo[p]!.title, style: mu.text.title3),
                  ],
                ),
                const SizedBox(height: MuSpacing.space3),
                Wrap(
                  spacing: MuSpacing.space2,
                  runSpacing: MuSpacing.space2,
                  children: [
                    for (final skill in kPathwayInfo[p]!.includes.take(3))
                      MuPill(skill, tone: MuPillTone.cobalt),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: MuSpacing.space3),
        ],
      ],
    );
  }
}

/// The dashboard's `InterestSelector`.
class _DirectView extends ConsumerStatefulWidget {
  const _DirectView({required this.onBack, required this.onComplete});

  final VoidCallback onBack;
  final VoidCallback onComplete;

  @override
  ConsumerState<_DirectView> createState() => _DirectViewState();
}

class _DirectViewState extends ConsumerState<_DirectView> {
  bool _onEndgoals = false;
  final Set<Pathway> _pathways = {};
  final Set<Endgoal> _endgoals = {};

  Future<void> _submit() async {
    try {
      await ref
          .read(interestsControllerProvider.notifier)
          .submitPathwaysAndEndgoals(
            [
              for (final p in Pathway.values)
                if (_pathways.contains(p)) p.name,
            ],
            [
              for (final e in Endgoal.values)
                if (_endgoals.contains(e)) e.apiValue,
            ],
          );
      widget.onComplete();
    } on Object catch (_) {
      // Surfaced via the ref.listen toast in the parent screen.
    }
  }

  void _toggle<T>(Set<T> set, T value) {
    unawaited(HapticFeedback.selectionClick());
    setState(() => set.contains(value) ? set.remove(value) : set.add(value));
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(interestsControllerProvider).isLoading;

    if (!_onEndgoals) {
      return AuthPage(
        step: 1,
        steps: 2,
        eyebrow: _eyebrow,
        light: 'Which one feels ',
        bold: 'like you?',
        lead: 'Pick one or more.',
        onBack: widget.onBack,
        bottom: MuButton(
          label: 'Next',
          block: true,
          knob: true,
          onPressed: _pathways.isEmpty
              ? null
              : () => setState(() => _onEndgoals = true),
        ),
        children: [
          for (final p in Pathway.values) ...[
            _OptionCard(
              icon: _pathwayIcons[p],
              title: kPathwayInfo[p]!.title,
              subtitle: kPathwayInfo[p]!.includes.take(3).join(', '),
              selected: _pathways.contains(p),
              onTap: () => _toggle(_pathways, p),
            ),
            const SizedBox(height: MuSpacing.space3),
          ],
        ],
      );
    }

    return AuthPage(
      step: 2,
      steps: 2,
      eyebrow: _eyebrow,
      light: 'What’s your long-term ',
      bold: 'tech goal?',
      lead: 'Pick one or more.',
      onBack: loading ? null : () => setState(() => _onEndgoals = false),
      bottom: MuButton(
        label: 'Begin your journey',
        block: true,
        knob: true,
        loading: loading,
        loadingLabel: 'Saving…',
        onPressed: _endgoals.isEmpty || loading ? null : _submit,
      ),
      children: [
        for (final e in Endgoal.values) ...[
          _OptionCard(
            icon: LucideIcons.target,
            title: endgoalTitle(e),
            selected: _endgoals.contains(e),
            onTap: () => _toggle(_endgoals, e),
          ),
          const SizedBox(height: MuSpacing.space3),
        ],
      ],
    );
  }
}
