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
import 'package:mulearn_app/core/widgets/mu_section_header.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/circle_invite.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/circle_member.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/learning_circle.dart';
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

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(circlesListControllerProvider.notifier).loadMore();
    }
  }

  @override
  void dispose() {
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
    final circlesState = ref.watch(circlesListControllerProvider);
    final invitesState = ref.watch(myPendingCircleInvitesProvider);
    final actionState = ref.watch(circleActionsControllerProvider);

    final myCircleIds =
        myCirclesState.value?.map((c) => c.id).toSet() ?? const <String>{};
    final nearYou =
        (circlesState.value ?? const <LearningCircle>[])
            .where((c) => !myCircleIds.contains(c.id))
            .toList();
    final hasMore = ref.read(circlesListControllerProvider.notifier).hasMore;

    return Scaffold(
      backgroundColor: MuColors.canvas,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref
              ..invalidate(myCirclesProvider)
              ..invalidate(circlesListControllerProvider)
              ..invalidate(myPendingCircleInvitesProvider);
          },
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

              // -- Circles near you.
              const MuSectionHeader(title: 'Circles near you'),
              const SizedBox(height: MuSpace.m),
              circlesState.when(
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
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: MuSpace.screenH),
                      child: Text(
                        'No other circles to discover right now.',
                        style: MuType.body.copyWith(color: MuColors.inkSecondary),
                      ),
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
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: MuSpace.m),
                            child: Center(child: CircularProgressIndicator()),
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

  final List<CircleInvite> invites;
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

  final CircleInvite invite;
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
                Text(
                  invite.circleTitle ?? 'You were invited to a circle',
                  style: MuType.bodyMed,
                ),
                if (invite.isLeadInvite)
                  Text('Invited as lead', style: MuType.caption),
              ],
            ),
          ),
          MuIconButton(
            icon: LucideIcons.check,
            onPressed: isBusy ? null : () => _respond(context, ref, accept: true),
          ),
          const SizedBox(width: MuSpace.s),
          MuIconButton(
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
