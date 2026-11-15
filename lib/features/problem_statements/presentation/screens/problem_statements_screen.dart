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
import 'package:mulearn_app/core/widgets/mu_load_more_footer.dart';
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

  bool _onScroll(ScrollNotification n) {
    if (_tab != _Tab.browse) return false;
    final feed = ref.read(psFeedProvider(_query, _openOnly)).value;
    if (n.metrics.extentAfter < 400 &&
        feed != null &&
        feed.hasMore &&
        feed.loadMoreError == null) {
      unawaited(
        ref.read(psFeedProvider(_query, _openOnly).notifier).loadMore(),
      );
    }
    return false;
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
          child: NotificationListener<ScrollNotification>(
            onNotification: _onScroll,
            child: ListView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.fromLTRB(
                MuSpacing.space5,
                MuSpacing.space2,
                MuSpacing.space5,
                MuSpacing.space8,
              ),
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
                          style: mu.text.displayLight.copyWith(fontSize: 36),
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
                        onTap: () => setState(() => _openOnly = !_openOnly),
                      ),
                    ],
                  ),
                  const SizedBox(height: MuSpacing.space4),
                  ..._browse(),
                ] else
                  ..._mine(mine),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _browse() => ref
      .watch(psFeedProvider(_query, _openOnly))
      .when(
        skipError: true,
        loading: () => const [_Loading()],
        error: (e, _) => [
          _Problem(
            error: e,
            onRetry: () => ref.invalidate(psFeedProvider(_query, _openOnly)),
          ),
        ],
        data: (paged) => [
          if (paged.items.isEmpty)
            MuEmptyLine(
              _query.isEmpty
                  ? (_openOnly
                        ? 'Nothing open right now. Check back soon.'
                        : 'No problem statements yet.')
                  : 'Nothing matches "$_query".',
            )
          else
            PsList(paged.items),
          if (paged.hasMore || paged.loadMoreError != null)
            MuLoadMoreFooter(
              isLoading: paged.isLoadingMore,
              error: paged.loadMoreError,
              onRetry: () => ref
                  .read(psFeedProvider(_query, _openOnly).notifier)
                  .loadMore(),
            ),
        ],
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
    final c = context.mu.colors;
    return MuFeedGroup(
      children: [
        for (var i = 0; i < items.length; i++)
          MuFeedRow(
            leading: MuAvatar(
              name: items[i].companyName,
              url: items[i].companyLogo,
              size: MuSizes.avatarMd,
              ring: false,
            ),
            subject: items[i].title,
            time: [items[i].companyName, ?items[i].category].join(' · '),
            trailing: Icon(
              LucideIcons.chevronRight,
              size: MuSizes.iconSm + 2,
              color: c.ink3,
            ),
            actions: [
              psDeadlinePill(items[i], now),
              ?psStatusPill(items[i].myStatus),
            ],
            divider: i < items.length - 1,
            onTap: () =>
                context.push(RoutePaths.problemStatementPath(items[i].id)),
          ),
      ],
    );
  }
}
