import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/auth/current_user_claims.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_avatar_stack.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_chip.dart';
import 'package:mulearn_app/core/widgets/mu_icon_button.dart';
import 'package:mulearn_app/core/widgets/mu_load_more_footer.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/core/widgets/mu_section_header.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/circle_filter.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/circle_member.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/learning_circle.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/received_circle_invite.dart';
import 'package:mulearn_app/features/learning_circles/presentation/providers/learning_circles_controller.dart';
import 'package:mulearn_app/features/learning_circles/presentation/widgets/learning_circle_tile.dart';

/// Own circle(s) + discoverable circles to join, or create one
/// (DESIGN_SPEC.md §2 "10 — Learning circles"). Adapted to the real data
/// shape: [myCirclesProvider] (own circles, plural-capable) drives the
/// featured section, [circlesListControllerProvider] (paginated catalog)
/// drives "Circles near you", and [myPendingCircleInvitesProvider] (real,
/// already-wired accept/decline flow) surfaces as its own section rather
/// than being dropped — the mock has no equivalent, but this is live
/// functionality that would otherwise become unreachable.
class LearningCirclesScreen extends ConsumerStatefulWidget {
  const LearningCirclesScreen({super.key});

  @override
  ConsumerState<LearningCirclesScreen> createState() =>
      _LearningCirclesScreenState();
}

class _LearningCirclesScreenState extends ConsumerState<LearningCirclesScreen> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  Timer? _searchDebounce;
  CircleFilter _filter = CircleFilter.discover;

  void _setFilter(CircleFilter filter) => setState(() => _filter = filter);

  /// Typing searches once, 300 ms after the last keystroke.
  void _onSearchChanged(String text) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 300), () {
      if (mounted) _setFilter(_filter.copyWith(search: text));
    });
  }

  void _clearFilters() {
    _searchDebounce?.cancel();
    _searchController.clear();
    _setFilter(CircleFilter.discover);
  }

  Future<void> _pickInterestGroup() async {
    final picked = await showModalBottomSheet<({String? id})>(
      context: context,
      showDragHandle: true,
      backgroundColor: MuColors.surface,
      builder: (sheetContext) => Consumer(
        builder: (context, ref, _) => ref.watch(circleIgOptionsProvider).when(
              loading: () => const Padding(
                padding: EdgeInsets.all(MuSpace.xl),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, _) => Padding(
                padding: const EdgeInsets.all(MuSpace.xl),
                child: Text(ApiException.messageFor(error)),
              ),
              data: (options) => ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    title: const Text('Any interest group'),
                    onTap: () => Navigator.of(sheetContext).pop((id: null)),
                  ),
                  for (final o in options)
                    ListTile(
                      title: Text(o.label),
                      selected: o.id == _filter.igId,
                      onTap: () => Navigator.of(sheetContext).pop((id: o.id)),
                    ),
                ],
              ),
            ),
      ),
    );
    if (picked != null && mounted) {
      _setFilter(CircleFilter(status: _filter.status, igId: picked.id, search: _filter.search));
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
    _searchDebounce?.cancel();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _requestToJoin(String circleId) async {
    await ref.read(circleActionsControllerProvider.notifier).requestToJoin(circleId);
    if (!mounted) return;
    final state = ref.read(circleActionsControllerProvider);
    MuToast.show(
      context,
      message: state.hasError
          ? ApiException.messageFor(state.error!)
          : 'Request sent to the circle lead.',
      type: state.hasError ? MuToastType.error : MuToastType.success,
    );
  }

  @override
  Widget build(BuildContext context) {
    final myCirclesState = ref.watch(myCirclesProvider);
    final circlesState = ref.watch(circlesListControllerProvider(_filter));
    final invitesState = ref.watch(myPendingCircleInvitesProvider);
    final actionState = ref.watch(circleActionsControllerProvider);

    final paged = circlesState.value;
    // The server filters by status; "Not joined" already excludes the
    // user's circles.
    final nearYou = paged?.items ?? const <LearningCircle>[];
    final igLabel = _filter.igId == null
        ? 'Interest group'
        : ref.watch(circleIgOptionsProvider).value?.where((o) => o.id == _filter.igId).firstOrNull?.label ??
            'Interest group';
    final hasMore = paged?.hasMore ?? false;

    return Scaffold(
      backgroundColor: MuColors.canvas,
      body: SafeArea(
        child: MuRefresh(
          onRefresh: () => Future.wait([
            ref.refresh(myCirclesProvider.future),
            ref.refresh(circlesListControllerProvider(_filter).future),
            ref.refresh(myPendingCircleInvitesProvider.future),
          ]),
          child: ListView(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(vertical: MuSpace.l),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: MuSpace.screenH),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Learning circles', style: MuType.display.copyWith(fontSize: 28)),
                          const SizedBox(height: MuSpace.xs),
                          Text(
                            'Small groups that learn a skill together. Karma is shared.',
                            style: MuType.body.copyWith(color: MuColors.inkSecondary),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: MuSpace.m),
                    GestureDetector(
                      onTap: () => context.push(RoutePaths.createLearningCircle),
                      child: Padding(
                        // Larger hit target than the text alone, and lines up
                        // with the title's cap-height rather than its top.
                        padding: const EdgeInsets.only(top: 6),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(LucideIcons.plus, size: 16, color: MuColors.primary),
                            const SizedBox(width: 2),
                            Text(
                              'Create',
                              style: MuType.chip.copyWith(color: MuColors.primary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: MuSpace.xxl),

              // -- Invites (real, wired accept/decline — no design-mock
              // equivalent, but preserved as its own section rather than
              // dropped).
              invitesState.maybeWhen(
                data: (invites) => invites.isEmpty
                    ? const SizedBox.shrink()
                    : _InvitesSection(invites: invites, isBusy: actionState.isLoading),
                orElse: () => const SizedBox.shrink(),
              ),

              // -- Featured: the user's own circle(s).
              myCirclesState.when(
                loading: () => const Padding(
                  padding: EdgeInsets.symmetric(vertical: MuSpace.l),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (_, __) => const SizedBox.shrink(),
                data: (circles) {
                  if (circles.isEmpty) return const SizedBox.shrink();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MuSectionHeader(title: circles.length > 1 ? 'Your circles' : 'Your circle'),
                      const SizedBox(height: MuSpace.m),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: MuSpace.screenH),
                        child: Column(
                          children: [
                            for (final circle in circles)
                              Padding(
                                padding: const EdgeInsets.only(bottom: MuSpace.m),
                                child: _FeaturedCircleCard(
                                  circle: circle,
                                  onTap: () => context
                                      .push(RoutePaths.learningCircleDetailPath(circle.id)),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: MuSpace.l),
                    ],
                  );
                },
              ),

              // -- Discover: search and filters (L7).
              const MuSectionHeader(title: 'Discover circles'),
              const SizedBox(height: MuSpace.m),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: MuSpace.screenH),
                child: TextField(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  textInputAction: TextInputAction.search,
                  decoration: const InputDecoration(
                    hintText: 'Search circles',
                    prefixIcon: Icon(LucideIcons.search, size: 18),
                  ),
                ),
              ),
              const SizedBox(height: MuSpace.m),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: MuSpace.screenH),
                child: Row(
                  children: [
                    for (final (status, label) in const [
                      ('not_joined', 'Not joined'),
                      (null, 'All'),
                      ('joined', 'Joined'),
                      ('pending', 'Pending'),
                    ]) ...[
                      MuFilterChip(
                        label: label,
                        selected: _filter.status == status,
                        onTap: () => _setFilter(
                          CircleFilter(status: status, igId: _filter.igId, search: _filter.search),
                        ),
                      ),
                      const SizedBox(width: MuSpace.s),
                    ],
                    MuFilterChip(
                      label: '$igLabel ▾',
                      selected: _filter.igId != null,
                      onTap: _pickInterestGroup,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: MuSpace.m),
              circlesState.when(
                skipError: true,
                loading: () => const Padding(
                  padding: EdgeInsets.symmetric(vertical: MuSpace.l),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (error, _) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: MuSpace.screenH),
                  child: Text(
                    ApiException.messageFor(error),
                    style: MuType.body.copyWith(color: MuColors.error),
                  ),
                ),
                data: (_) {
                  if (nearYou.isEmpty) {
                    final filtered = _filter != CircleFilter.discover;
                    // The dashboard's circle-list: StateDisplay "no-results";
                    // its own copy when nothing is filtered.
                    return MuStateDisplay(
                      variant: MuStateVariant.noResults,
                      size: MuStateSize.sm,
                      title: filtered ? null : 'No Learning Circles Yet',
                      description:
                          filtered ? null : 'Be the first to create a Learning Circle and start collaborating with peers!',
                      action: filtered ? TextButton(onPressed: _clearFilters, child: const Text('Clear filters')) : null,
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: MuSpace.screenH),
                    child: Column(
                      children: [
                        for (final circle in nearYou)
                          LearningCircleTile(
                            circle: circle,
                            isBusy: actionState.isLoading,
                            onTap: () => context
                                .push(RoutePaths.learningCircleDetailPath(circle.id)),
                            onJoinTap: () => _requestToJoin(circle.id),
                          ),
                        if (hasMore)
                          MuLoadMoreFooter(
                            isLoading: paged?.isLoadingMore ?? false,
                            error: paged?.loadMoreError,
                            onRetry: () => ref
                                .read(circlesListControllerProvider(_filter).notifier)
                                .loadMore(),
                          ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: MuSpace.navClearance),
            ],
          ),
        ),
      ),
    );
  }
}

class _InvitesSection extends StatelessWidget {
  const _InvitesSection({required this.invites, required this.isBusy});

  final List<ReceivedCircleInvite> invites;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MuSectionHeader(title: 'Invites'),
        const SizedBox(height: MuSpace.m),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MuSpace.screenH),
          child: Column(
            children: [
              for (final invite in invites)
                Padding(
                  padding: const EdgeInsets.only(bottom: MuSpace.m),
                  child: _InviteTile(invite: invite, isBusy: isBusy),
                ),
            ],
          ),
        ),
        const SizedBox(height: MuSpace.l),
      ],
    );
  }
}

class _InviteTile extends ConsumerWidget {
  const _InviteTile({required this.invite, required this.isBusy});

  final ReceivedCircleInvite invite;
  final bool isBusy;

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
          : (accept ? 'Invite accepted.' : 'Invite declined.'),
      type: state.hasError ? MuToastType.error : MuToastType.success,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MuCard(
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: const BoxDecoration(
              color: MuColors.primaryTint,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(LucideIcons.mail, color: MuColors.primary, size: 20),
          ),
          const SizedBox(width: MuSpace.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(invite.circleTitle, style: MuType.bodyMed),
                if (invite.igName != null)
                  Text(invite.igName!, style: MuType.caption),
                if (invite.invitedByName != null)
                  Text('Invited by ${invite.invitedByName}', style: MuType.caption),
                if (invite.isLeadInvite)
                  Text('Invited as lead', style: MuType.caption),
              ],
            ),
          ),
          MuIconButton(
            tooltip: 'Accept invitation',
            icon: LucideIcons.check,
            onPressed: isBusy ? null : () => _respond(context, ref, accept: true),
          ),
          const SizedBox(width: MuSpace.s),
          MuIconButton(
            tooltip: 'Decline invitation',
            icon: LucideIcons.x,
            onPressed: isBusy ? null : () => _respond(context, ref, accept: false),
          ),
        ],
      ),
    );
  }
}

/// The featured "own circle" card — tag, "YOU LEAD" badge (derived from the
/// already-fetched member list rather than a fabricated field), name,
/// location, member avatar stack, member count, "Open →" (DESIGN_SPEC.md §2
/// "10").
class _FeaturedCircleCard extends ConsumerWidget {
  const _FeaturedCircleCard({required this.circle, required this.onTap});

  final LearningCircle circle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membersState = ref.watch(circleMembersProvider(circle.id));
    final myMuid = ref.watch(currentUserMuidProvider).value;
    final members = membersState.value?.members ?? const <CircleMember>[];
    final isLead = myMuid != null && members.any((m) => m.muid == myMuid && m.isLeader);

    return MuCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MuTagChip(label: circle.ig),
              if (isLead) ...[
                const SizedBox(width: MuSpace.s),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: MuColors.karmaAccent,
                    borderRadius: BorderRadius.circular(MuRadius.chip),
                  ),
                  child: Text(
                    'YOU LEAD',
                    style: MuType.tag.copyWith(color: MuColors.surface, fontSize: 10),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: MuSpace.m),
          Text(circle.title, style: MuType.headline.copyWith(fontSize: 20)),
          if (circle.org != null) ...[
            const SizedBox(height: 2),
            Text(
              circle.org!,
              style: MuType.body.copyWith(color: MuColors.inkSecondary),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          const SizedBox(height: MuSpace.l),
          Row(
            children: [
              if (members.isNotEmpty)
                MuAvatarStack(
                  names: members.take(4).map((m) => m.fullName).toList(),
                  urls: members.take(4).map((m) => m.profilePicUrl).toList(),
                  extraCount: members.length > 4 ? members.length - 4 : 0,
                ),
              const SizedBox(width: MuSpace.s),
              Expanded(
                child: Text(
                  '${circle.totalMembers} members',
                  style: MuType.caption,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Open', style: MuType.chip.copyWith(color: MuColors.primary)),
                  const SizedBox(width: 2),
                  const Icon(LucideIcons.arrowRight, size: 14, color: MuColors.primary),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
