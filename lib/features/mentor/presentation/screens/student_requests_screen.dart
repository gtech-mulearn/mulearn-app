import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_load_more_footer.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/features/mentor/domain/entities/student_request.dart';
import 'package:mulearn_app/features/mentor/domain/request_review.dart';
import 'package:mulearn_app/features/mentor/presentation/providers/student_requests_controller.dart';
import 'package:mulearn_app/features/mentor/presentation/widgets/approve_request_sheet.dart';
import 'package:mulearn_app/features/mentor/presentation/widgets/session_labels.dart';

/// Learners' session requests (M4): who asked, what and when, with Approve
/// (proposal pre-filled, changeable) and Reject on each row.
class StudentRequestsScreen extends ConsumerWidget {
  const StudentRequestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(studentRequestsControllerProvider);
    Future<void> refresh() => ref.refresh(studentRequestsControllerProvider.future);
    return Scaffold(
      backgroundColor: MuColors.canvas,
      appBar: AppBar(backgroundColor: MuColors.canvas, elevation: 0, title: const Text('Session requests')),
      body: state.when(
        skipError: true,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorRetryView(error: e, onRetry: () => ref.invalidate(studentRequestsControllerProvider)),
        data: (paged) => MuRefresh(
          onRefresh: refresh,
          child: paged.items.isEmpty
              ? ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: const [
                    // The dashboard's incoming-requests copy, with the illustration.
                    MuStateDisplay(
                      variant: MuStateVariant.noResults,
                      title: 'No incoming session requests found.',
                      description: 'Requests from learners in your interest groups appear here.',
                    ),
                  ],
                )
              : NotificationListener<ScrollNotification>(
                  onNotification: (n) {
                    if (n.metrics.extentAfter < 400 && paged.hasMore && paged.loadMoreError == null) {
                      unawaited(ref.read(studentRequestsControllerProvider.notifier).loadMore());
                    }
                    return false;
                  },
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(MuSpace.screenH, MuSpace.m, MuSpace.screenH, MuSpace.xxl),
                    children: [
                      for (final r in paged.items) _RequestCard(request: r),
                      if (paged.hasMore || paged.loadMoreError != null)
                        MuLoadMoreFooter(
                          isLoading: paged.isLoadingMore,
                          error: paged.loadMoreError,
                          onRetry: () => ref.read(studentRequestsControllerProvider.notifier).loadMore(),
                        ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class _RequestCard extends ConsumerWidget {
  const _RequestCard({required this.request});

  final StudentSessionRequest request;

  Future<void> _approve(BuildContext context, WidgetRef ref) async {
    final choice = await showApproveRequestSheet(context, request);
    if (choice == null || !context.mounted) return;
    await _send(
      context,
      ref,
      verifyBody(
        request,
        approve: true,
        startsLocal: choice.startsLocal,
        endsLocal: choice.endsLocal,
        mode: choice.mode,
        meetingLink: choice.meetingLink,
        venue: choice.venue,
      ),
      success: 'Scheduled for ${formatDayTime(choice.startsLocal)}',
    );
  }

  Future<void> _reject(BuildContext context, WidgetRef ref) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Reject this request?'),
        content: Text('“${request.title}” from ${request.requesterName.isEmpty ? request.requesterMuid : request.requesterName}.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(dialogContext, true), child: const Text('Reject')),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;
    await _send(context, ref, verifyBody(request, approve: false), success: 'Request rejected');
  }

  Future<void> _send(BuildContext context, WidgetRef ref, Map<String, Object?> body, {required String success}) async {
    try {
      final message = await ref.read(studentRequestsControllerProvider.notifier).answer(request, body);
      if (!context.mounted) return;
      // Approval: say when it's scheduled; rejection: the backend's words.
      final approved = body['status'] == 'APPROVED';
      MuToast.show(context, message: approved || message.isEmpty ? success : message, type: MuToastType.success);
    } on Object catch (e) {
      if (context.mounted) MuToast.show(context, message: ApiException.messageFor(e), type: MuToastType.error);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final r = request;
    final now = ref.watch(clockProvider)().toLocal();
    return Padding(
      padding: const EdgeInsets.only(bottom: MuSpace.m),
      child: MuCard(
        onTap: () => unawaited(_approve(context, ref)),
        padding: const EdgeInsets.fromLTRB(MuSpace.l, MuSpace.l, MuSpace.l, MuSpace.s),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(r.requesterName.isEmpty ? r.requesterMuid : r.requesterName, style: MuType.bodyMed),
            if (r.requesterName.isNotEmpty) Text(r.requesterMuid, style: MuType.caption),
            const SizedBox(height: MuSpace.s),
            Text(r.title, style: MuType.title, maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 2),
            Text(
              formatWhen(starts: r.startsAt.toLocal(), ends: r.endsAt.toLocal(), now: now),
              style: MuType.bodyMed.copyWith(color: MuColors.primary),
            ),
            Text(
              [sessionModeLabel(r.mode), if (r.scopeName.isNotEmpty) r.scopeName].join(' · '),
              style: MuType.caption,
            ),
            if (r.description.isNotEmpty) ...[
              const SizedBox(height: MuSpace.s),
              Text(
                r.description,
                style: MuType.body.copyWith(color: MuColors.inkSecondary),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () => unawaited(_reject(context, ref)), child: const Text('Reject')),
                const SizedBox(width: MuSpace.s),
                FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: MuColors.primary),
                  onPressed: () => unawaited(_approve(context, ref)),
                  child: const Text('Approve'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
