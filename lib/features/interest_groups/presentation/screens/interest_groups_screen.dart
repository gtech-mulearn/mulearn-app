import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/session/my_profile_payload.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/features/interest_groups/domain/entities/interest_group_summary.dart';
import 'package:mulearn_app/features/interest_groups/presentation/providers/interest_groups_controller.dart';
import 'package:mulearn_app/features/interest_groups/presentation/widgets/ig_membership_action.dart';

/// Every interest group as a sticker wall (artifact IGSticker, "Pick your
/// corner"): search and category chips on top, your own groups first, then
/// the rest, two to a row. Each sticker opens its group and joins or leaves
/// in place.
class InterestGroupsScreen extends ConsumerStatefulWidget {
  const InterestGroupsScreen({super.key});

  @override
  ConsumerState<InterestGroupsScreen> createState() => _InterestGroupsScreenState();
}

class _InterestGroupsScreenState extends ConsumerState<InterestGroupsScreen> {
  final _search = TextEditingController();
  String _query = '';
  IgCategory? _category;

  /// The group whose join/leave is in flight.
  String? _pending;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<void> _toggle(InterestGroupSummary group, {required bool join}) async {
    setState(() => _pending = group.id);
    try {
      await toggleIgMembership(context, ref, id: group.id, name: group.name, join: join);
    } finally {
      if (mounted) setState(() => _pending = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final catalogState = ref.watch(interestGroupsCatalogProvider);
    final myIds = ref.watch(myInterestGroupIdsProvider).value ?? const <String>[];

    return Scaffold(
      backgroundColor: c.chalk,
      body: SafeArea(
        bottom: false,
        child: catalogState.when(
          skipError: true,
          loading: () => const Center(child: MuDotsLoader(label: 'Loading groups…')),
          error: (error, _) =>
              ErrorRetryView(error: error, onRetry: () => ref.invalidate(interestGroupsCatalogProvider)),
          data: (groups) {
            final categories = {for (final g in groups) IgCategory.parse(g.category)}.toList()
              ..sort((a, b) => a.index.compareTo(b.index));
            final q = _query.trim().toLowerCase();
            final shown = [
              for (final g in groups)
                if ((_category == null || IgCategory.parse(g.category) == _category) &&
                    (q.isEmpty || g.name.toLowerCase().contains(q) || (g.code ?? '').toLowerCase().contains(q)))
                  g,
            ];
            final yours = [
              for (final g in shown)
                if (myIds.contains(g.id)) g,
            ];
            final rest = [
              for (final g in shown)
                if (!myIds.contains(g.id)) g,
            ];

            return MuRefresh(
              onRefresh: () => Future.wait([
                ref.refresh(interestGroupsCatalogProvider.future),
                ref.refresh(myProfilePayloadProvider.future),
              ]),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(MuSpacing.space5, MuSpacing.space2, MuSpacing.space5, 0),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (Navigator.of(context).canPop()) ...[
                            MuIconButton(icon: LucideIcons.arrowLeft, tooltip: 'Back', onPressed: () => context.pop()),
                            const SizedBox(height: MuSpacing.space3),
                          ],
                          Semantics(
                            header: true,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: 'Pick your\n', style: mu.text.displayLight.copyWith(fontSize: 36)),
                                  TextSpan(text: 'corner', style: mu.text.display.copyWith(fontSize: 36)),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: MuSpacing.space2),
                          Text(
                            'Join up to $maxLearnerGroups groups. Your tasks, mentors and events follow them.',
                            style: mu.text.body.copyWith(color: c.ink2),
                          ),
                          const SizedBox(height: MuSpacing.space5),
                          MuSearchField(
                            controller: _search,
                            hint: 'Search groups',
                            onChanged: (v) => setState(() => _query = v),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (categories.length > 1)
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: MuSizes.touchMin + MuSpacing.space3 * 2,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: MuSpacing.space5, vertical: MuSpacing.space3),
                          children: [
                            MuFilterChip(
                              label: 'All',
                              selected: _category == null,
                              onTap: () => setState(() => _category = null),
                            ),
                            for (final cat in categories) ...[
                              const SizedBox(width: MuSpacing.space2),
                              MuFilterChip(
                                label: _categoryLabel(cat),
                                selected: _category == cat,
                                onTap: () => setState(() => _category = _category == cat ? null : cat),
                              ),
                            ],
                          ],
                        ),
                      ),
                    )
                  else
                    const SliverToBoxAdapter(child: SizedBox(height: MuSpacing.space4)),
                  if (shown.isEmpty)
                    SliverToBoxAdapter(
                      child: MuStateDisplay(
                        variant: MuStateVariant.noResults,
                        description: groups.isEmpty
                            ? 'Check back later for new groups'
                            : 'No group matches that. Try another word or category.',
                      ),
                    ),
                  if (yours.isNotEmpty)
                    _Section(
                      title: 'YOURS · ${myIds.length} OF $maxLearnerGroups',
                      groups: yours,
                      joined: true,
                      pending: _pending,
                      onToggle: _toggle,
                    ),
                  if (rest.isNotEmpty)
                    _Section(
                      title: yours.isEmpty ? 'ALL GROUPS' : 'MORE TO EXPLORE',
                      groups: rest,
                      joined: false,
                      pending: _pending,
                      onToggle: _toggle,
                    ),
                  const SliverToBoxAdapter(child: SizedBox(height: MuSpacing.navClearance)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

String _categoryLabel(IgCategory c) => switch (c) {
  IgCategory.coder => 'Coder',
  IgCategory.maker => 'Maker',
  IgCategory.creative => 'Creative',
  IgCategory.manager => 'Manager',
  IgCategory.others => 'Others',
};

/// A titled wall of stickers, two to a row.
class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.groups,
    required this.joined,
    required this.pending,
    required this.onToggle,
  });

  final String title;
  final List<InterestGroupSummary> groups;
  final bool joined;
  final String? pending;
  final Future<void> Function(InterestGroupSummary, {required bool join}) onToggle;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(MuSpacing.space5, MuSpacing.space4, MuSpacing.space5, MuSpacing.space4),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Semantics(header: true, child: Text(title, style: mu.text.eyebrow)),
            const SizedBox(height: MuSpacing.space4),
            LayoutBuilder(
              builder: (context, box) {
                const gap = MuSpacing.space3;
                final cell = (box.maxWidth - gap) / 2;
                return Wrap(
                  spacing: gap,
                  runSpacing: MuSpacing.space4,
                  children: [
                    for (var i = 0; i < groups.length; i++)
                      MuIgSticker(
                        width: cell,
                        index: i,
                        name: groups[i].name,
                        code: groups[i].code,
                        category: IgCategory.parse(groups[i].category),
                        members: groups[i].memberCount,
                        joined: joined,
                        joining: pending == groups[i].id,
                        onTap: () => context.push(RoutePaths.interestGroupDetailPath(groups[i].id)),
                        onJoin: pending != null ? () {} : () => onToggle(groups[i], join: !joined),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
