import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/features/auth/data/interests_quiz_data.dart';
import 'package:mulearn_app/features/auth/domain/entities/endgoal.dart';
import 'package:mulearn_app/features/auth/domain/entities/pathway.dart';
import 'package:mulearn_app/features/auth/presentation/providers/interests_controller.dart';
import 'package:mulearn_app/features/auth/presentation/widgets/auth_page.dart';

enum _Mode { choice, quiz, direct }

/// Sign-up step 4 of 4, the dashboard's `/onboarding/interests`: take the
/// PathFinder quiz (5 questions, the top two pathways are saved, no end
/// goals) or pick directly (pathways, then end goals; both required). The
/// submissions are [InterestsController.submitPathwaysOnly] and
/// [InterestsController.submitPathwaysAndEndgoals]; every path lands on
/// Home. What μLearn is was already told by the first-launch intro, so this
/// goes straight to the choice.
class OnboardingInterestsScreen extends ConsumerStatefulWidget {
  const OnboardingInterestsScreen({super.key});

  @override
  ConsumerState<OnboardingInterestsScreen> createState() => _OnboardingInterestsScreenState();
}

class _OnboardingInterestsScreenState extends ConsumerState<OnboardingInterestsScreen> {
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
        MuToast.show(context, message: ApiException.messageFor(next.error!), type: MuToastType.error);
      }
    });

    return PopScope(
      canPop: _mode == _Mode.choice,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _to(_Mode.choice);
      },
      child: switch (_mode) {
        _Mode.choice => _ChoiceView(onQuiz: () => _to(_Mode.quiz), onDirect: () => _to(_Mode.direct)),
        _Mode.quiz => _QuizView(onBack: () => _to(_Mode.choice), onComplete: _complete),
        _Mode.direct => _DirectView(onBack: () => _to(_Mode.choice), onComplete: _complete),
      },
    );
  }
}

class _ChoiceView extends StatelessWidget {
  const _ChoiceView({required this.onQuiz, required this.onDirect});

  final VoidCallback onQuiz;
  final VoidCallback onDirect;

  @override
  Widget build(BuildContext context) {
    return AuthPage(
      step: 4,
      steps: 4,
      eyebrow: 'One last thing',
      light: 'Where do you ',
      bold: 'want to start?',
      lead: 'We shape your first tasks around this. Nothing is locked in: change direction whenever you like.',
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
      ],
    );
  }
}

/// A large tappable choice: icon well, title, line, chevron.
class _OptionCard extends StatelessWidget {
  const _OptionCard({required this.title, required this.onTap, this.subtitle, this.icon});

  final IconData? icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    return Semantics(
      button: true,
      label: [title, ?subtitle].join(', '),
      excludeSemantics: true,
      child: MuPressable(
        onTap: onTap,
        pressedScale: 0.98,
        child: Container(
          constraints: const BoxConstraints(minHeight: 64),
          padding: const EdgeInsets.all(MuSpacing.space4),
          decoration: BoxDecoration(color: c.surface, borderRadius: BorderRadius.circular(MuRadii.card)),
          child: Row(
            children: [
              if (icon != null) ...[
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(color: c.cobaltTint, shape: BoxShape.circle),
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
                      Text(subtitle!, style: mu.text.body.copyWith(fontSize: 14, color: c.ink2)),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: MuSpacing.space2),
              Icon(LucideIcons.chevronRight, size: MuSizes.iconSm, color: c.ink3),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuizView extends ConsumerStatefulWidget {
  const _QuizView({required this.onBack, required this.onComplete});

  final VoidCallback onBack;
  final VoidCallback onComplete;

  @override
  ConsumerState<_QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends ConsumerState<_QuizView> {
  late final List<QuizQuestion> _questions = List.of(kPathfinderQuizQuestions)..shuffle();
  int _index = 0;
  final Map<Pathway, int> _tally = {};

  Future<void> _answer(Pathway pathway) async {
    unawaited(HapticFeedback.selectionClick());
    _tally[pathway] = (_tally[pathway] ?? 0) + 1;
    if (_index < _questions.length - 1) {
      setState(() => _index += 1);
      return;
    }
    final ranked = _tally.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    final topPathways = ranked.take(2).map((e) => e.key.name).toList();
    try {
      await ref.read(interestsControllerProvider.notifier).submitPathwaysOnly(topPathways);
      widget.onComplete();
    } on Object catch (_) {
      // Surfaced via the ref.listen toast in the parent screen.
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_index];
    final loading = ref.watch(interestsControllerProvider).isLoading;

    return AuthPage(
      step: _index + 1,
      steps: _questions.length,
      eyebrow: 'Question ${_index + 1} of ${_questions.length}',
      light: '',
      bold: question.question,
      onBack: () {
        if (_index == 0) {
          widget.onBack();
        } else {
          setState(() => _index -= 1);
        }
      },
      children: [
        for (final option in question.options) ...[
          _OptionCard(title: option.text, onTap: loading ? null : () => _answer(option.pathway)),
          const SizedBox(height: MuSpacing.space3),
        ],
        if (loading) const Center(child: MuDotsLoader(label: 'Saving your pathways…')),
      ],
    );
  }
}

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
          .submitPathwaysAndEndgoals(_pathways.map((p) => p.name).toList(), _endgoals.map((e) => e.apiValue).toList());
      widget.onComplete();
    } on Object catch (_) {
      // Surfaced via the ref.listen toast in the parent screen.
    }
  }

  void _toggle<T>(Set<T> set, T value) {
    HapticFeedback.selectionClick();
    setState(() => set.contains(value) ? set.remove(value) : set.add(value));
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(interestsControllerProvider).isLoading;

    if (!_onEndgoals) {
      return AuthPage(
        step: 4,
        steps: 4,
        eyebrow: 'Your pathways',
        light: 'What do you ',
        bold: 'like to do?',
        lead: 'Pick one or more. Your Interest Groups and first tasks follow from this.',
        onBack: widget.onBack,
        bottom: MuButton(
          label: 'Continue',
          block: true,
          knob: true,
          onPressed: _pathways.isEmpty ? null : () => setState(() => _onEndgoals = true),
        ),
        children: [
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: MuSpacing.space3,
            crossAxisSpacing: MuSpacing.space3,
            childAspectRatio: 1.05,
            children: [
              for (final p in Pathway.values)
                _PathwayTile(pathway: p, selected: _pathways.contains(p), onTap: () => _toggle(_pathways, p)),
            ],
          ),
        ],
      );
    }

    return AuthPage(
      step: 4,
      steps: 4,
      eyebrow: 'Your goals',
      light: 'Where do you ',
      bold: 'want it to lead?',
      lead: 'Pick one or more. You can change these later.',
      onBack: () => setState(() => _onEndgoals = false),
      bottom: MuButton(
        label: "Let's go",
        block: true,
        knob: true,
        loading: loading,
        loadingLabel: 'Saving…',
        onPressed: _endgoals.isEmpty ? null : _submit,
      ),
      children: [
        Wrap(
          spacing: MuSpacing.space2,
          runSpacing: MuSpacing.space2,
          children: [
            for (final e in Endgoal.values)
              MuFilterChip(
                label: _endgoalLabel(e),
                selected: _endgoals.contains(e),
                onTap: () => _toggle(_endgoals, e),
              ),
          ],
        ),
      ],
    );
  }

  static String _endgoalLabel(Endgoal endgoal) => switch (endgoal) {
    Endgoal.job => 'A job',
    Endgoal.researchAndDevelopment => 'Research & development',
    Endgoal.entrepreneurship => 'My own venture',
    Endgoal.gigWork => 'Gig work',
    Endgoal.higherEducation => 'Higher education',
    Endgoal.socialImpact => 'Social impact',
  };
}

/// A pathway as a sticker tile in its own Interest Group colour; selected
/// gets a night ring and a check.
class _PathwayTile extends StatelessWidget {
  const _PathwayTile({required this.pathway, required this.selected, required this.onTap});

  final Pathway pathway;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final (String name, String line, IgCategory tone, IconData icon) = switch (pathway) {
      Pathway.coder => ('Coder', 'Build software', IgCategory.coder, LucideIcons.code2),
      Pathway.maker => ('Maker', 'Build things you can hold', IgCategory.maker, LucideIcons.cpu),
      Pathway.manager => ('Manager', 'Lead people and projects', IgCategory.manager, LucideIcons.briefcase),
      Pathway.creative => ('Creative', 'Design, film and art', IgCategory.creative, LucideIcons.palette),
    };
    return Semantics(
      button: true,
      checked: selected,
      label: '$name, $line',
      excludeSemantics: true,
      child: MuPressable(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.all(MuSpacing.space4),
          decoration: BoxDecoration(
            color: MuTones.forIgCategory(c, tone),
            borderRadius: BorderRadius.circular(MuRadii.card),
            border: Border.all(color: selected ? c.inkPrint : MuTones.forIgCategory(c, tone), width: 3),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 26, color: c.inkPrint),
                  const Spacer(),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 160),
                    opacity: selected ? 1 : 0,
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(color: c.inkPrint, shape: BoxShape.circle),
                      child: Icon(LucideIcons.check, size: 16, color: MuTones.forIgCategory(c, tone)),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                name,
                style: mu.text.title2.copyWith(color: c.inkPrint, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 2),
              Text(line, style: mu.text.caption.copyWith(color: c.inkPrint.withValues(alpha: 0.75))),
            ],
          ),
        ),
      ),
    );
  }
}
