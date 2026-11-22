import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/search_debouncer.dart';
import 'package:mulearn_app/core/widgets/mu_paged_list.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/features/problem_statements/domain/entities/problem_statement.dart';
import 'package:mulearn_app/features/problem_statements/presentation/providers/problem_statements_providers.dart';
import 'package:mulearn_app/features/problem_statements/presentation/widgets/ps_labels.dart';

enum _Tab { browse, mine }

/// Problem statements, as on the dashboard: Browse the published feed
/// (search, "Open only"), or Participating — what you're trying and what
/// you've submitted. Each opens the statement.
class ProblemStatementsScreen extends ConsumerStatefulWidget {
  const ProblemStatementsScreen({super.key});

  @override
  ConsumerState<ProblemStatementsScreen> createState() =>
      _ProblemStatementsScreenState();
}

class _ProblemStatementsScreenState
    extends ConsumerState<ProblemStatementsScreen> {
  final _search = TextEditingController();
  _Tab _tab = _Tab.browse;
  String _query = '';
  bool _openOnly = false;
  late final _debouncer = SearchDebouncer((q) {
    if (mounted) setState(() => _query = q);
  });

  @override
  void dispose() {
    _debouncer.dispose();
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final mine = ref.watch(psParticipatingProvider);
    final mineCount = mine.value?.length ?? 0;

    return Scaffold(
      backgroundColor: c.chalk,
      body: SafeArea(
        bottom: false,
        child: MuRefresh(
          onRefresh: () => Future.wait([
            ref.refresh(psFeedProvider(_query, _openOnly).future),
            ref.refresh(psParticipatingProvider.future),
          ]),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  MuSpacing.space5,
                  MuSpacing.space2,
                  MuSpacing.space5,
                  MuSpacing.space8,
                ),
                sliver: SliverMainAxisGroup(
                  slivers: [
                    SliverList.list(
                      children: [
                        if (Navigator.of(context).canPop()) ...[
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: MuIconButton(
                              icon: LucideIcons.arrowLeft,
                              tooltip: 'Back',
                              onPressed: () => context.pop(),
                            ),
                          ),
                          const SizedBox(height: MuSpacing.space3),
                        ],
                        Semantics(
                          header: true,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Solve real\n',
                                  style: mu.text.displayLight.copyWith(
                                    fontSize: 36,
                                  ),
                                ),
                                TextSpan(
                                  text: 'problems',
                                  style: mu.text.display.copyWith(fontSize: 36),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: MuSpacing.space2),
                        Text(
                          'Problem statements from companies and μLearn. Say you’re trying one, then share a link to your solution.',
                          style: mu.text.body.copyWith(color: c.ink2),
                        ),
                        const SizedBox(height: MuSpacing.space5),
                        MuSegmented<_Tab>(
                          values: _Tab.values,
                          selected: _tab,
                          label: (t) => t == _Tab.browse
                              ? 'Browse'
                              : (mineCount == 0
                                    ? 'Participating'
                                    : 'Participating · $mineCount'),
                          onChanged: (t) => setState(() => _tab = t),
                        ),
                        const SizedBox(height: MuSpacing.space4),
                        if (_tab == _Tab.browse) ...[
                          Row(
                            children: [
                              Expanded(
                                child: MuSearchField(
                                  controller: _search,
                                  hint: 'Search title, company, category',
                                  onChanged: _debouncer.onChanged,
                                  onSubmitted: _debouncer.submit,
                                ),
                              ),
                              const SizedBox(width: MuSpacing.space2),
                              MuFilterChip(
                                label: 'Open only',
                                selected: _openOnly,
                                onTap: () =>
                                    setState(() => _openOnly = !_openOnly),
                              ),
                            ],
                          ),
                          const SizedBox(height: MuSpacing.space4),
                        ] else
                          ..._mine(mine),
                      ],
                    ),
                    if (_tab == _Tab.browse) _browse(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// The feed as a sliver, built row by row as it scrolls in.
  Widget _browse() => ref
      .watch(psFeedProvider(_query, _openOnly))
      .when(
        skipError: true,
        loading: () => const SliverToBoxAdapter(child: _Loading()),
        error: (e, _) => SliverToBoxAdapter(
          child: _Problem(
            error: e,
            onRetry: () => ref.invalidate(psFeedProvider(_query, _openOnly)),
          ),
        ),
        data: (paged) {
          if (paged.items.isEmpty && !paged.hasMore) {
            return SliverToBoxAdapter(
              child: MuEmptyLine(
                _query.isEmpty
                    ? (_openOnly
                          ? 'Nothing open right now. Check back soon.'
                          : 'No problem statements yet.')
                    : 'Nothing matches "$_query".',
              ),
            );
          }
          final now = ref.watch(clockProvider)();
          return MuPagedSliverList<ProblemStatement>(
            state: paged,
            grouped: true,
            onLoadMore: () =>
                ref.read(psFeedProvider(_query, _openOnly).notifier).loadMore(),
            itemBuilder: (context, statement, i) => psRow(
              context,
              statement,
              now,
              last: i == paged.items.length - 1,
            ),
          );
        },
      );

  List<Widget> _mine(AsyncValue<List<ProblemStatement>> mine) => mine.when(
    skipError: true,
    loading: () => const [_Loading()],
    error: (e, _) => [
      _Problem(
        error: e,
        onRetry: () => ref.invalidate(psParticipatingProvider),
      ),
    ],
    data: (items) {
      if (items.isEmpty) {
        return [
          const MuEmptyLine(
            "You're not on any yet. Pick one in Browse and say you're trying it.",
          ),
          const SizedBox(height: MuSpacing.space4),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: MuButton(
              label: 'Browse problem statements',
              variant: MuButtonVariant.outline,
              size: MuButtonSize.small,
              onPressed: () => setState(() => _tab = _Tab.browse),
            ),
          ),
        ];
      }
      final submitted = [
        for (final s in items)
          if (s.myStatus == PsStatus.submitted) s,
      ];
      final trying = [
        for (final s in items)
          if (s.myStatus == PsStatus.trying) s,
      ];
      return [
        if (trying.isNotEmpty) ...[
          MuSectionEyebrow('TRYING · ${trying.length}'),
          PsList(trying),
        ],
        if (submitted.isNotEmpty) ...[
          MuSectionEyebrow(
            'SUBMITTED · ${submitted.length}',
            top: trying.isEmpty ? 0 : MuSpacing.space6,
          ),
          PsList(submitted),
        ],
      ];
    },
  );
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsets.symmetric(vertical: MuSpacing.space8),
    child: Center(child: MuDotsLoader()),
  );
}

class _Problem extends StatelessWidget {
  const _Problem({required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(child: MuEmptyLine(ApiException.messageFor(error))),
      MuButton(
        label: 'Retry',
        variant: MuButtonVariant.ghost,
        size: MuButtonSize.small,
        onPressed: onRetry,
      ),
    ],
  );
}

/// Statements as feed rows: who posted it, the title, its category, when
/// it closes and your status. Each opens the statement.
class PsList extends ConsumerWidget {
  const PsList(this.items, {super.key});

  final List<ProblemStatement> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = ref.watch(clockProvider)();
    return MuFeedGroup(
      children: [
        for (var i = 0; i < items.length; i++)
          psRow(context, items[i], now, last: i == items.length - 1),
      ],
    );
  }
}

/// One statement as a feed row: who posted it, the title, its category,
/// when it closes and your status. Opens the statement.
Widget psRow(
  BuildContext context,
  ProblemStatement statement,
  DateTime now, {
  required bool last,
}) => MuFeedRow(
  leading: MuAvatar(
    name: statement.companyName,
    url: statement.companyLogo,
    size: MuSizes.avatarMd,
    ring: false,
  ),
  subject: statement.title,
  time: [statement.companyName, ?statement.category].join(' · '),
  trailing: Icon(
    LucideIcons.chevronRight,
    size: MuSizes.iconSm + 2,
    color: context.mu.colors.ink3,
  ),
  actions: [psDeadlinePill(statement, now), ?psStatusPill(statement.myStatus)],
  divider: !last,
  onTap: () => context.push(RoutePaths.problemStatementPath(statement.id)),
);
