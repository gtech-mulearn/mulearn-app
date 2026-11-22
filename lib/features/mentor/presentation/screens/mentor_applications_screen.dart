import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/session/mentor_application.dart';
import 'package:mulearn_app/core/session/session_providers.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';

/// A mentor's applications (the dashboard's mentor home before approval):
/// each with where it stands and the one thing to do about it — edit one
/// under review, apply again after a no — and a way to apply for another
/// tier. With none yet, what each tier is and who decides.
class MentorApplicationsScreen extends ConsumerWidget {
  const MentorApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apps = ref.watch(mentorApplicationsProvider);
    final hasAny = apps.value?.isNotEmpty ?? false;
    return MuWorkspacePage(
      bottom: apps.hasValue
          ? MuButton(
              label: hasAny ? 'Apply for another tier' : 'Apply to mentor',
              block: true,
              variant: hasAny ? MuButtonVariant.outline : MuButtonVariant.ink,
              knob: !hasAny,
              onPressed: () => context.push(RoutePaths.mentorApply),
            )
          : null,
      body: apps.when(
        skipLoadingOnReload: true,
        loading: () => const Center(child: MuDotsLoader()),
        error: (e, _) => ErrorRetryView(
          error: e,
          onRetry: () => ref.invalidate(mentorApplicationsProvider),
        ),
        data: (list) {
          final now = ref.watch(clockProvider)();
          final sorted = [...list]
            ..sort(
              (a, b) => (b.createdAt ?? DateTime(0)).compareTo(
                a.createdAt ?? DateTime(0),
              ),
            );
          return MuRefresh(
            onRefresh: () => ref.refresh(mentorApplicationsProvider.future),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: muListPadding,
              children: [
                _Heading(hasAny: sorted.isNotEmpty),
                const SizedBox(height: MuSpacing.space5),
                if (sorted.isEmpty)
                  const _Tiers()
                else
                  for (final (i, a) in sorted.indexed) ...[
                    if (i > 0) const SizedBox(height: MuSpacing.space3),
                    _ApplicationCard(application: a, now: now),
                  ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading({required this.hasAny});

  final bool hasAny;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          header: true,
          child: Text(
            hasAny ? 'Your mentor applications' : 'Become a mentor',
            style: mu.text.display.copyWith(fontSize: 32),
          ),
        ),
        const SizedBox(height: MuSpacing.space2),
        Text(
          hasAny
              ? 'Once one is approved, your mentor workspace opens: sessions, '
                    'requests and the learners you guide.'
              : 'Pick how you want to mentor. Your application goes to the '
                    'people who look after that tier.',
          style: mu.text.body.copyWith(color: mu.colors.ink2),
        ),
      ],
    );
  }
}

/// With no application yet: the three tiers, what each is, who decides.
class _Tiers extends StatelessWidget {
  const _Tiers();

  static const _what = {
    MentorTier.ig: 'Guide learners in the Interest Groups you know well.',
    MentorTier.campus: 'Mentor the learners of one college.',
    MentorTier.company: 'Mentor on behalf of the company you work at.',
  };

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final (i, t) in MentorTier.values.indexed) ...[
          if (i > 0) const SizedBox(height: MuSpacing.space3),
          // Each tier opens the form with it chosen.
          Semantics(
            button: true,
            label: 'Apply as ${t.label}. ${_what[t]} ${t.reviewer}',
            excludeSemantics: true,
            child: MuPressable(
              onTap: () =>
                  context.push(RoutePaths.mentorApplyTierPath(t.value)),
              pressedScale: 0.98,
              child: MuSurfaceCard(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(t.label, style: mu.text.title3),
                          const SizedBox(height: MuSpacing.space1),
                          Text(_what[t]!, style: mu.text.body),
                          const SizedBox(height: MuSpacing.space1),
                          Text(t.reviewer, style: mu.text.caption),
                        ],
                      ),
                    ),
                    const SizedBox(width: MuSpacing.space3),
                    Icon(
                      LucideIcons.chevronRight,
                      size: MuSizes.iconSm,
                      color: mu.colors.ink3,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _ApplicationCard extends StatelessWidget {
  const _ApplicationCard({required this.application, required this.now});

  final MentorApplication application;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final a = application;
    final tier = MentorTier.parse(a.mentorTier);
    final (status, tone, icon) = switch (a.status) {
      MentorStatus.approved => (
        'Approved',
        MuPillTone.success,
        LucideIcons.check,
      ),
      MentorStatus.rejected => (
        'Not approved',
        MuPillTone.danger,
        LucideIcons.x,
      ),
      MentorStatus.revoked => (
        'Access revoked',
        MuPillTone.danger,
        LucideIcons.shieldOff,
      ),
      _ => ('Under review', MuPillTone.warning, LucideIcons.clock),
    };
    final sent = a.createdAt == null
        ? null
        : 'Sent ${formatAgo(a.createdAt!.toLocal(), now)}';
    return MuSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tier?.label ?? 'Mentor', style: mu.text.title3),
                    if ((a.organization ?? '').isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        a.organization!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: mu.text.body,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: MuSpacing.space3),
              MuPill(status, tone: tone, icon: icon),
            ],
          ),
          const SizedBox(height: MuSpacing.space2),
          Text(
            [?sent, if (a.isPending && tier != null) tier.reviewer].join(' · '),
            style: mu.text.caption,
          ),
          if (a.isRejected && a.rejectionReason != null) ...[
            const SizedBox(height: MuSpacing.space3),
            Text('Why', style: mu.text.label),
            const SizedBox(height: 2),
            Text(a.rejectionReason!, style: mu.text.body),
          ],
          if (a.isPending || a.isRejected) ...[
            const SizedBox(height: MuSpacing.space3),
            MuButton(
              label: a.isPending ? 'Edit application' : 'Apply again',
              size: MuButtonSize.small,
              variant: a.isPending
                  ? MuButtonVariant.outline
                  : MuButtonVariant.cobalt,
              icon: a.isPending ? LucideIcons.pencil : LucideIcons.rotateCcw,
              onPressed: () => context.push(
                a.isPending
                    ? RoutePaths.mentorApplyEditPath(a.id)
                    : RoutePaths.mentorApplyAgainPath(a.id),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
