import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/core/widgets/mu_chip.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/features/auth/data/interests_quiz_data.dart';
import 'package:mulearn_app/features/auth/domain/entities/endgoal.dart';
import 'package:mulearn_app/features/auth/domain/entities/pathway.dart';
import 'package:mulearn_app/features/auth/presentation/providers/interests_controller.dart';

enum _InterestsMode { choice, quiz, direct }

/// Post-registration interests onboarding, matching the reference
/// dashboard's `/onboarding/interests`: pick either the PathFinder quiz
/// (5 questions → top-2 pathways, no endgoals) or the direct picker
/// (pathways then endgoals, both required).
///
/// The reference's "already onboarded? skip straight to dashboard" guard and
/// role-based redirect aren't replicated here — both need a `user info`
/// endpoint/role-specific dashboards this app doesn't have yet (flagged, not
/// silently built). Every path here redirects to `/profile` on completion.
class OnboardingInterestsScreen extends ConsumerStatefulWidget {
  const OnboardingInterestsScreen({super.key});

  @override
  ConsumerState<OnboardingInterestsScreen> createState() =>
      _OnboardingInterestsScreenState();
}

class _OnboardingInterestsScreenState
    extends ConsumerState<OnboardingInterestsScreen> {
  _InterestsMode _mode = _InterestsMode.choice;

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

    return Scaffold(
      backgroundColor: MuColors.canvas,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: MuSpace.screenH),
          child: switch (_mode) {
            _InterestsMode.choice => _ChoiceView(
                onQuiz: () => setState(() => _mode = _InterestsMode.quiz),
                onDirect: () => setState(() => _mode = _InterestsMode.direct),
              ),
            _InterestsMode.quiz => _QuizView(onComplete: _complete),
            _InterestsMode.direct => _DirectView(onComplete: _complete),
          },
        ),
      ),
    );
  }
}

class _ChoiceView extends StatelessWidget {
  const _ChoiceView({required this.onQuiz, required this.onDirect});

  final VoidCallback onQuiz;
  final VoidCallback onDirect;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Welcome to μLearn!', style: MuType.headline),
        const SizedBox(height: MuSpace.s),
        Text(
          "Let's find the right pathways for you.",
          style: MuType.body.copyWith(color: MuColors.inkSecondary),
        ),
        const SizedBox(height: MuSpace.xxl),
        _ChoiceCard(
          emoji: '✨',
          title: 'Take the PathFinder Quiz',
          description: '5 quick questions to discover your pathways.',
          onTap: onQuiz,
        ),
        const SizedBox(height: MuSpace.m),
        _ChoiceCard(
          emoji: '📋',
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
    required this.emoji,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final String emoji;
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(MuRadius.inner),
      child: Container(
        padding: const EdgeInsets.all(MuSpace.l),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MuRadius.inner),
          color: MuColors.surface,
          border: Border.all(color: MuColors.divider),
        ),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 28)),
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
            const Icon(LucideIcons.chevronRight, color: MuColors.inkSecondary),
          ],
        ),
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: MuSpace.l),
        ClipRRect(
          borderRadius: BorderRadius.circular(MuRadius.chip),
          child: LinearProgressIndicator(
            value: (_index + 1) / _questions.length,
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
        Text(question.question, style: MuType.headline),
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
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: MuSpace.l),
          Text('Pick your pathways', style: MuType.headline),
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
      );
    }

    return Column(
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
        Text('What are your end goals?', style: MuType.headline),
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
