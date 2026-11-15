import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/features/search/domain/entities/campus_search_result.dart';
import 'package:mulearn_app/features/search/domain/entities/user_search_result.dart';
import 'package:mulearn_app/features/search/presentation/providers/search_controller.dart';

enum _Who { people, mentors, campuses }

/// Find people, mentors or campuses, like the dashboard's search pages:
/// the search field opens focused, People / Mentors / Campuses picks what
/// to look for. People are rows with their karma and open the public
/// profile; campuses (colleges and schools) are crests that open the
/// campus's public page.
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _queryController = TextEditingController();
  final _scrollController = ScrollController();
  _Who _who = _Who.people;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      unawaited(
        _who == _Who.campuses
            ? ref.read(campusSearchControllerProvider.notifier).loadMore()
            : ref.read(searchControllerProvider.notifier).loadMore(),
      );
    }
  }

  void _runSearch() {
    if (_who == _Who.campuses) {
      unawaited(ref.read(campusSearchControllerProvider.notifier).search(_queryController.text));
      return;
    }
    unawaited(
      ref
          .read(searchControllerProvider.notifier)
          .search(_queryController.text, role: _who == _Who.mentors ? 'mentor' : null),
    );
  }

  @override
  void dispose() {
    _queryController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final resultsState = ref.watch(searchControllerProvider);
    final query = _queryController.text.trim();

    return Scaffold(
      backgroundColor: c.chalk,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(MuSpacing.space3, MuSpacing.space2, MuSpacing.space5, 0),
              child: Row(
                children: [
                  MuIconButton(
                    icon: LucideIcons.arrowLeft,
                    tooltip: 'Back',
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                  const SizedBox(width: MuSpacing.space1),
                  Expanded(
                    child: MuSearchField(
                      controller: _queryController,
                      hint: _who == _Who.campuses ? 'Campus name or code' : 'Name or muid',
                      autofocus: true,
                      onChanged: (_) => setState(() {}),
                      onSubmitted: (_) => _runSearch(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(MuSpacing.space5, MuSpacing.space3, MuSpacing.space5, 0),
              child: MuSegmented<_Who>(
                values: _Who.values,
                selected: _who,
                label: (w) => switch (w) {
                  _Who.people => 'People',
                  _Who.mentors => 'Mentors',
                  _Who.campuses => 'Campuses',
                },
                onChanged: (w) {
                  setState(() => _who = w);
                  if (query.isNotEmpty) _runSearch();
                },
              ),
            ),
            if (_who == _Who.campuses)
              Expanded(
                child: _CampusResults(query: query, scrollController: _scrollController),
              )
            else
              Expanded(
                child: resultsState.when(
                  loading: () => const Center(child: MuDotsLoader(label: 'Searching…')),
                  error: (error, _) => Center(
                    child: Padding(
                      padding: const EdgeInsets.all(MuSpacing.space8),
                      child: Text(ApiException.messageFor(error), textAlign: TextAlign.center, style: mu.text.body),
                    ),
                  ),
                  data: (results) {
                    if (query.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(MuSpacing.space8),
                        child: Column(
                          children: [
                            const SizedBox(height: MuSpacing.space8),
                            const MuFeedIcon(LucideIcons.search, tone: MuFeedTone.event),
                            const SizedBox(height: MuSpacing.space4),
                            Text('Find someone', style: mu.text.title2),
                            const SizedBox(height: MuSpacing.space1),
                            Text(
                              'Search learners and mentors by name or muid, or switch to Campuses.',
                              textAlign: TextAlign.center,
                              style: mu.text.body.copyWith(color: c.ink2),
                            ),
                          ],
                        ),
                      );
                    }
                    if (results.isEmpty) {
                      // The dashboard's SearchResults copy.
                      return SingleChildScrollView(
                        child: MuStateDisplay(
                          variant: MuStateVariant.noResults,
                          size: MuStateSize.sm,
                          description: 'No members match "$query". Try a different path and keep exploring.',
                        ),
                      );
                    }
                    final hasMore = ref.read(searchControllerProvider.notifier).hasMore;
                    return ListView(
                      controller: _scrollController,
                      padding: const EdgeInsets.fromLTRB(
                        MuSpacing.space5,
                        MuSpacing.space4,
                        MuSpacing.space5,
                        MuSpacing.space8,
                      ),
                      children: [
                        MuFeedGroup(
                          children: [
                            for (var i = 0; i < results.length; i++)
                              _ResultRow(result: results[i], last: i == results.length - 1),
                          ],
                        ),
                        if (hasMore)
                          const Padding(
                            padding: EdgeInsets.all(MuSpacing.space5),
                            child: Center(child: MuDotsLoader()),
                          ),
                      ],
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ResultRow extends StatelessWidget {
  const _ResultRow({required this.result, required this.last});

  final UserSearchResult result;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final org = result.organization;
    return MuFeedRow(
      leading: MuAvatar(name: result.fullName, url: result.profilePicUrl, size: MuSizes.avatarMd, ring: false),
      subject: result.fullName,
      time: [result.muid, if (org != null && org.isNotEmpty) org].join(' · '),
      trailing: MuFeedAmount(muGrouped(result.karma)),
      divider: !last,
      onTap: () => context.push(RoutePaths.publicProfilePath(result.muid)),
    );
  }
}

/// Colleges and schools matching the query, as crests; each opens the
/// campus's public page.
class _CampusResults extends ConsumerWidget {
  const _CampusResults({required this.query, required this.scrollController});

  final String query;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final c = mu.colors;
    return ref
        .watch(campusSearchControllerProvider)
        .when(
          loading: () => const Center(child: MuDotsLoader(label: 'Searching campuses…')),
          error: (error, _) => Center(
            child: Padding(
              padding: const EdgeInsets.all(MuSpacing.space8),
              child: Text(ApiException.messageFor(error), textAlign: TextAlign.center, style: mu.text.body),
            ),
          ),
          data: (results) {
            if (query.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(MuSpacing.space8),
                child: Column(
                  children: [
                    const SizedBox(height: MuSpacing.space8),
                    const MuCampusSeal(code: null),
                    const SizedBox(height: MuSpacing.space4),
                    Text('Find a campus', style: mu.text.title2),
                    const SizedBox(height: MuSpacing.space1),
                    Text(
                      'Search colleges and schools by name or code, and see how they learn.',
                      textAlign: TextAlign.center,
                      style: mu.text.body.copyWith(color: c.ink2),
                    ),
                  ],
                ),
              );
            }
            if (results.isEmpty) {
              return SingleChildScrollView(
                child: MuStateDisplay(
                  variant: MuStateVariant.noResults,
                  size: MuStateSize.sm,
                  description: 'No campus matches "$query". Try its short code, like CET.',
                ),
              );
            }
            final hasMore = ref.read(campusSearchControllerProvider.notifier).hasMore;
            return ListView(
              controller: scrollController,
              padding: const EdgeInsets.fromLTRB(
                MuSpacing.space5,
                MuSpacing.space4,
                MuSpacing.space5,
                MuSpacing.space8,
              ),
              children: [
                for (var i = 0; i < results.length; i++) ...[
                  if (i > 0) const SizedBox(height: MuSpacing.space3),
                  _CampusRow(campus: results[i]),
                ],
                if (hasMore)
                  const Padding(
                    padding: EdgeInsets.all(MuSpacing.space5),
                    child: Center(child: MuDotsLoader()),
                  ),
              ],
            );
          },
        );
  }
}

class _CampusRow extends StatelessWidget {
  const _CampusRow({required this.campus});

  final CampusSearchResult campus;

  @override
  Widget build(BuildContext context) {
    final c = campus;
    final place = [?c.district, ?c.zone].join(' · ');
    return MuCampusCrest(
      code: c.code.isEmpty ? null : c.code,
      name: c.title,
      caption: [
        if (c.isSchool) 'School',
        if (place.isNotEmpty) place,
        if (c.learners == 1) '1 learner' else '${muGrouped(c.learners)} learners',
      ].join(' · '),
      trailing: Icon(LucideIcons.chevronRight, size: MuSizes.iconSm + 2, color: context.mu.colors.ink3),
      onTap: () => context.push(RoutePaths.publicCampusPath(c.id)),
    );
  }
}
