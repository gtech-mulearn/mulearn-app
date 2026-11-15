import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/auth/current_user_claims.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/utils/search_debouncer.dart';
import 'package:mulearn_app/core/widgets/mu_load_more_footer.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/circle_filter.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/circle_member.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/learning_circle.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/received_circle_invite.dart';
import 'package:mulearn_app/features/learning_circles/presentation/providers/learning_circles_controller.dart';

/// Learning circles (artifact CircleCard): invitations to answer first,
/// then your circles with their faces in the ring, then circles to
/// discover with search, status chips and an IG picker. Create sits in the
/// header.
class LearningCirclesScreen extends ConsumerStatefulWidget {
  const LearningCirclesScreen({super.key});

  @override
  ConsumerState<LearningCirclesScreen> createState() =>
      _LearningCirclesScreenState();
}

const _statuses = [
  ('not_joined', 'Not joined'),
  (null, 'All'),
  ('joined', 'Joined'),
  ('pending', 'Pending'),
];

class _LearningCirclesScreenState extends ConsumerState<LearningCirclesScreen> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  late final _debouncer = SearchDebouncer((q) {
    if (mounted) _setFilter(_filter.copyWith(search: q));
  });
  CircleFilter _filter = CircleFilter.discover;

  /// The circle whose join request is in flight, and those asked this visit.
  String? _requesting;
  final _requested = <String>{};

  void _setFilter(CircleFilter filter) => setState(() => _filter = filter);

  /// Typing searches once it pauses (see [SearchDebouncer]).
  void _onSearchChanged(String text) => _debouncer.onChanged(text);

  void _clearFilters() {
    _debouncer.reset();
    _searchController.clear();
    _setFilter(CircleFilter.discover);
  }

  Future<void> _pickInterestGroup() async {
    final picked = await showMuSheet<({String? id})>(
      context,
      builder: (_) => _IgPickerSheet(selected: _filter.igId),
    );
    if (picked != null && mounted) {
      _setFilter(
        CircleFilter(
          status: _filter.status,
          igId: picked.id,
          search: _filter.search,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final paged = ref.read(circlesListControllerProvider(_filter)).value;
    // After a failed page, only the explicit "Try again" retries — otherwise
    // every scroll frame would fire another request while offline.
    if (paged == null || paged.loadMoreError != null) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(circlesListControllerProvider(_filter).notifier).loadMore();
    }
  }

  @override
  void dispose() {
    _debouncer.dispose();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _requestToJoin(LearningCircle circle) async {
    setState(() => _requesting = circle.id);
    await ref
        .read(circleActionsControllerProvider.notifier)
        .requestToJoin(circle.id);
    if (!mounted) return;
    final state = ref.read(circleActionsControllerProvider);
    setState(() {
      _requesting = null;
      if (!state.hasError) _requested.add(circle.id);
    });
    MuToast.show(
      context,
      message: state.hasError
          ? ApiException.messageFor(state.error!)
          : 'Request sent to the circle lead.',
      type: state.hasError ? MuToastType.error : MuToastType.success,
    );
  }

  /// The card's one action, from what the list knows about this circle.
  Widget _actionFor(LearningCircle circle) {
    void open() => context.push(RoutePaths.learningCircleDetailPath(circle.id));
    if (_filter.status == 'joined') {
      return MuButton(
        label: 'Open',
        variant: MuButtonVariant.outline,
        size: MuButtonSize.small,
        onPressed: open,
      );
    }
    if (_filter.status == 'pending' || _requested.contains(circle.id)) {
      return const MuButton(
        label: 'Request sent',
        icon: LucideIcons.check,
        variant: MuButtonVariant.outline,
        size: MuButtonSize.small,
        onPressed: null,
      );
    }
    return MuButton(
      label: 'Ask to join',
      variant: MuButtonVariant.ink,
      size: MuButtonSize.small,
      loading: _requesting == circle.id,
      onPressed: _requesting != null ? null : () => _requestToJoin(circle),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final myCirclesState = ref.watch(myCirclesProvider);
    final circlesState = ref.watch(circlesListControllerProvider(_filter));
    final invites =
        ref.watch(myPendingCircleInvitesProvider).value ??
        const <ReceivedCircleInvite>[];
    final actionBusy = ref.watch(circleActionsControllerProvider).isLoading;

    final paged = circlesState.value;
    final discover = paged?.items ?? const <LearningCircle>[];
    final mine = myCirclesState.value ?? const <LearningCircle>[];
    final igLabel = _filter.igId == null
        ? 'Interest group'
        : ref
                  .watch(circleIgOptionsProvider)
                  .value
                  ?.where((o) => o.id == _filter.igId)
                  .firstOrNull
                  ?.label ??
              'Interest group';
    final hasMore = paged?.hasMore ?? false;
    final filtered = _filter != CircleFilter.discover;

    final Widget results;
    if (circlesState.hasError && paged == null) {
      results = Padding(
        padding: const EdgeInsets.symmetric(vertical: MuSpacing.space4),
        child: Text(
          ApiException.messageFor(circlesState.error!),
          style: mu.text.body.copyWith(color: c.danger),
        ),
      );
    } else if (paged == null) {
      results = const Padding(
        padding: EdgeInsets.symmetric(vertical: MuSpacing.space6),
        child: Center(child: MuDotsLoader(label: 'Finding circles…')),
      );
    } else if (discover.isEmpty) {
      // The dashboard's circle-list: StateDisplay "no-results"; its own copy
      // when nothing is filtered.
      results = MuStateDisplay(
        variant: MuStateVariant.noResults,
        size: MuStateSize.sm,
        title: filtered ? null : 'No Learning Circles Yet',
        description: filtered
            ? null
            : 'Be the first to create a Learning Circle and start collaborating with peers!',
        action: filtered
            ? MuButton(
                label: 'Clear filters',
                variant: MuButtonVariant.ghost,
                onPressed: _clearFilters,
              )
            : null,
      );
    } else {
      results = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < discover.length; i++) ...[
            if (i > 0) const SizedBox(height: MuSpacing.space3),
            MuCircleCard(
              title: discover[i].title,
              total: discover[i].totalMembers,
              igName: discover[i].ig,
              caption: [
                if (discover[i].org != null && discover[i].org!.isNotEmpty)
                  discover[i].org!,
                if (discover[i].totalMembers == 1)
                  '1 member'
                else
                  '${discover[i].totalMembers} members',
              ].join(' · '),
              action: _actionFor(discover[i]),
              onTap: () => context.push(
                RoutePaths.learningCircleDetailPath(discover[i].id),
              ),
            ),
          ],
          if (hasMore)
            MuLoadMoreFooter(
              isLoading: paged.isLoadingMore,
              error: paged.loadMoreError,
              onRetry: () => ref
                  .read(circlesListControllerProvider(_filter).notifier)
                  .loadMore(),
            ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: c.chalk,
      body: SafeArea(
        bottom: false,
        child: MuRefresh(
          onRefresh: () => Future.wait([
            ref.refresh(myCirclesProvider.future),
            ref.refresh(circlesListControllerProvider(_filter).future),
            ref.refresh(myPendingCircleInvitesProvider.future),
          ]),
          child: ListView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: const EdgeInsets.fromLTRB(
              MuSpacing.space5,
              MuSpacing.space2,
              MuSpacing.space5,
              0,
            ),
            children: [
              Row(
                children: [
                  if (Navigator.of(context).canPop())
                    MuIconButton(
                      icon: LucideIcons.arrowLeft,
                      tooltip: 'Back',
                      onPressed: () => context.pop(),
                    ),
                  const Spacer(),
                  MuButton(
                    label: 'Create',
                    icon: LucideIcons.plus,
                    size: MuButtonSize.small,
                    onPressed: () =>
                        context.push(RoutePaths.createLearningCircle),
                  ),
                ],
              ),
              const SizedBox(height: MuSpacing.space3),
              Semantics(
                header: true,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Learn\n',
                        style: mu.text.displayLight.copyWith(fontSize: 36),
                      ),
                      TextSpan(
                        text: 'together',
                        style: mu.text.display.copyWith(fontSize: 36),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: MuSpacing.space2),
              Text(
                'Small groups that learn a skill together and meet every week. Karma is shared.',
                style: mu.text.body.copyWith(color: c.ink2),
              ),

              if (invites.isNotEmpty) ...[
                _Eyebrow(
                  invites.length == 1
                      ? 'AN INVITATION'
                      : 'INVITATIONS · ${invites.length}',
                ),
                MuFeedGroup(
                  children: [
                    for (var i = 0; i < invites.length; i++)
                      _InviteRow(
                        invite: invites[i],
                        busy: actionBusy,
                        last: i == invites.length - 1,
                      ),
                  ],
                ),
              ],

              if (myCirclesState.isLoading && mine.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: MuSpacing.space6),
                  child: Center(
                    child: MuDotsLoader(label: 'Loading your circles…'),
                  ),
                ),
              if (mine.isNotEmpty) ...[
                _Eyebrow(mine.length > 1 ? 'YOUR CIRCLES' : 'YOUR CIRCLE'),
                for (var i = 0; i < mine.length; i++) ...[
                  if (i > 0) const SizedBox(height: MuSpacing.space3),
                  _MyCircleCard(circle: mine[i]),
                ],
              ],

              const _Eyebrow('DISCOVER CIRCLES'),
              MuSearchField(
                controller: _searchController,
                hint: 'Search circles',
                onChanged: _onSearchChanged,
              ),
              // A handful of chips: built all at once so each is reachable.
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                padding: const EdgeInsets.symmetric(vertical: MuSpacing.space3),
                child: Row(
                  children: [
                    for (final (status, label) in _statuses) ...[
                      MuFilterChip(
                        label: label,
                        selected: _filter.status == status,
                        onTap: () => _setFilter(
                          CircleFilter(
                            status: status,
                            igId: _filter.igId,
                            search: _filter.search,
                          ),
                        ),
                      ),
                      const SizedBox(width: MuSpacing.space2),
                    ],
                    Center(
                      child: Container(
                        width: 1,
                        height: 24,
                        color: c.lineStrong,
                      ),
                    ),
                    const SizedBox(width: MuSpacing.space2),
                    MuFilterChip(
                      label: igLabel,
                      icon: LucideIcons.chevronDown,
                      selected: _filter.igId != null,
                      onTap: _pickInterestGroup,
                    ),
                  ],
                ),
              ),
              results,
              const SizedBox(height: MuSpacing.navClearance),
            ],
          ),
        ),
      ),
    );
  }
}

class _Eyebrow extends StatelessWidget {
  const _Eyebrow(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(
      top: MuSpacing.space8,
      bottom: MuSpacing.space3,
    ),
    child: Semantics(
      header: true,
      child: Text(text, style: context.mu.text.eyebrow),
    ),
  );
}

/// An invitation to a circle, answered in the row.
class _InviteRow extends ConsumerWidget {
  const _InviteRow({
    required this.invite,
    required this.busy,
    required this.last,
  });

  final ReceivedCircleInvite invite;
  final bool busy;
  final bool last;

  Future<void> _respond(
    BuildContext context,
    WidgetRef ref, {
    required bool accept,
  }) async {
    await ref
        .read(circleActionsControllerProvider.notifier)
        .respondToInvite(invite.linkId, accept: accept);
    if (!context.mounted) return;
    final state = ref.read(circleActionsControllerProvider);
    MuToast.show(
      context,
      message: state.hasError
          ? ApiException.messageFor(state.error!)
          : (accept ? 'You joined ${invite.circleTitle}' : 'Invite declined.'),
      type: state.hasError ? MuToastType.error : MuToastType.success,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final who = invite.invitedByName;
    return MuFeedRow(
      leading: const MuFeedIcon(LucideIcons.mail, tone: MuFeedTone.event),
      subject: invite.circleTitle,
      body: invite.isLeadInvite
          ? 'wants you to lead it.'
          : (who != null ? 'from $who' : null),
      time: invite.igName,
      divider: !last,
      actions: [
        MuButton(
          label: 'Accept',
          size: MuButtonSize.small,
          onPressed: busy ? null : () => _respond(context, ref, accept: true),
        ),
        MuButton(
          label: 'Decline',
          variant: MuButtonVariant.outline,
          size: MuButtonSize.small,
          onPressed: busy ? null : () => _respond(context, ref, accept: false),
        ),
      ],
    );
  }
}

/// One of your circles: its members in the ring, "You lead" when you do.
class _MyCircleCard extends ConsumerWidget {
  const _MyCircleCard({required this.circle});

  final LearningCircle circle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final members =
        ref.watch(circleMembersProvider(circle.id)).value?.members ??
        const <CircleMember>[];
    final myMuid = ref.watch(currentUserMuidProvider).value;
    final isLead =
        myMuid != null && members.any((m) => m.muid == myMuid && m.isLeader);
    void open() => context.push(RoutePaths.learningCircleDetailPath(circle.id));

    return MuCircleCard(
      title: circle.title,
      total: circle.totalMembers,
      igName: circle.ig,
      members: [
        for (final m in members.take(5))
          (name: m.fullName, url: m.profilePicUrl),
      ],
      badge: isLead ? const MuPill('You lead', tone: MuPillTone.volt) : null,
      caption: [
        if (circle.org != null && circle.org!.isNotEmpty) circle.org!,
        if (circle.totalMembers == 1)
          '1 member'
        else
          '${circle.totalMembers} members',
      ].join(' · '),
      action: MuButton(
        label: 'Open',
        variant: MuButtonVariant.outline,
        size: MuButtonSize.small,
        onPressed: open,
      ),
      onTap: open,
    );
  }
}

/// Pick one interest group (or any) to narrow discovery.
class _IgPickerSheet extends ConsumerWidget {
  const _IgPickerSheet({required this.selected});

  final String? selected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final c = mu.colors;
    final options = ref.watch(circleIgOptionsProvider);

    Widget row(String label, String? id) {
      final on = id == selected;
      return Semantics(
        button: true,
        selected: on,
        label: label,
        excludeSemantics: true,
        child: InkWell(
          onTap: () => Navigator.of(context).pop((id: id)),
          child: Container(
            constraints: const BoxConstraints(minHeight: 52),
            padding: const EdgeInsets.symmetric(horizontal: MuSpacing.space5),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: c.line)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: on ? mu.text.bodyStrong : mu.text.body,
                  ),
                ),
                if (on)
                  Icon(
                    LucideIcons.check,
                    size: MuSizes.iconMd,
                    color: c.cobaltText,
                  ),
              ],
            ),
          ),
        ),
      );
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.75,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              MuSpacing.space5,
              0,
              MuSpacing.space5,
              MuSpacing.space3,
            ),
            child: Semantics(
              header: true,
              child: Text('Interest group', style: mu.text.title2),
            ),
          ),
          Flexible(
            child: options.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(MuSpacing.space6),
                child: Center(child: MuDotsLoader(label: 'Loading groups…')),
              ),
              error: (error, _) => Padding(
                padding: const EdgeInsets.all(MuSpacing.space5),
                child: Text(
                  ApiException.messageFor(error),
                  style: mu.text.body.copyWith(color: c.danger),
                ),
              ),
              data: (list) => ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: MuSpacing.space4),
                children: [
                  row('Any interest group', null),
                  for (final o in list) row(o.label, o.id),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
