import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
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
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(message)));
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
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
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Welcome to μLearn!', style: theme.textTheme.headlineMedium),
        const SizedBox(height: 8),
        Text(
          "Let's find the right pathways for you.",
          style: theme.textTheme.bodyMedium?.copyWith(color: MulearnColors.gray600),
        ),
        const SizedBox(height: 32),
        _ChoiceCard(
          emoji: '✨',
          title: 'Take the PathFinder Quiz',
          description: '5 quick questions to discover your pathways.',
          onTap: onQuiz,
        ),
        const SizedBox(height: 12),
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
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: MulearnColors.greyish),
        ),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: MulearnColors.gray600),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
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
    final theme = Theme.of(context);
    final question = _questions[_index];
    final isLoading = ref.watch(interestsControllerProvider).isLoading;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 16),
        LinearProgressIndicator(value: (_index + 1) / _questions.length),
        const SizedBox(height: 24),
        Text(
          'Question ${_index + 1} of ${_questions.length}',
          style: theme.textTheme.bodySmall?.copyWith(color: MulearnColors.gray600),
        ),
        const SizedBox(height: 8),
        Text(question.question, style: theme.textTheme.headlineSmall),
        const SizedBox(height: 24),
        for (final option in question.options) ...[
          OutlinedButton(
            onPressed: isLoading ? null : () => _answer(option.pathway),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              alignment: Alignment.centerLeft,
            ),
            child: Text(option.text),
          ),
          const SizedBox(height: 12),
        ],
        if (isLoading) ...[
          const SizedBox(height: 12),
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
    final theme = Theme.of(context);
    final isLoading = ref.watch(interestsControllerProvider).isLoading;

    if (!_onEndgoalsStep) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          Text('Pick your pathways', style: theme.textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text(
            'Select at least one — you can pick more than one.',
            style: theme.textTheme.bodyMedium?.copyWith(color: MulearnColors.gray600),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              for (final pathway in Pathway.values)
                FilterChip(
                  label: Text(_pathwayLabel(pathway)),
                  selected: _selectedPathways.contains(pathway),
                  onSelected: (selected) => setState(() {
                    if (selected) {
                      _selectedPathways.add(pathway);
                    } else {
                      _selectedPathways.remove(pathway);
                    }
                  }),
                ),
            ],
          ),
          const SizedBox(height: 28),
          FilledButton(
            onPressed: _selectedPathways.isEmpty
                ? null
                : () => setState(() => _onEndgoalsStep = true),
            child: const Text('Continue'),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 16),
        TextButton.icon(
          onPressed: () => setState(() => _onEndgoalsStep = false),
          icon: const Icon(Icons.arrow_back, size: 18),
          label: const Text('Back'),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            alignment: Alignment.centerLeft,
          ),
        ),
        const SizedBox(height: 8),
        Text('What are your end goals?', style: theme.textTheme.headlineMedium),
        const SizedBox(height: 8),
        Text(
          'Select at least one.',
          style: theme.textTheme.bodyMedium?.copyWith(color: MulearnColors.gray600),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (final endgoal in Endgoal.values)
              FilterChip(
                label: Text(_endgoalLabel(endgoal)),
                selected: _selectedEndgoals.contains(endgoal),
                onSelected: (selected) => setState(() {
                  if (selected) {
                    _selectedEndgoals.add(endgoal);
                  } else {
                    _selectedEndgoals.remove(endgoal);
                  }
                }),
              ),
          ],
        ),
        const SizedBox(height: 28),
        FilledButton(
          onPressed: isLoading || _selectedEndgoals.isEmpty ? null : _submit,
          child: isLoading
              ? const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(strokeWidth: 2.5),
                )
              : const Text("Let's go!"),
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
