import 'package:mulearn_app/core/utils/no_retry.dart';
import 'package:mulearn_app/features/campus/data/campus_repository_provider.dart';
import 'package:mulearn_app/features/campus/domain/entities/approvals.dart';
import 'package:mulearn_app/features/campus/domain/repositories/campus_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'approvals_providers.g.dart';

@Riverpod(retry: noRetry)
Future<List<OrgLinkRequest>> orgLinkRequests(Ref ref) => ref.watch(campusRepositoryProvider).getOrgLinks();

@Riverpod(retry: noRetry)
Future<List<PendingCampusEvent>> pendingCampusEvents(Ref ref) => ref.watch(campusRepositoryProvider).getPendingEvents();

@Riverpod(retry: noRetry)
Future<List<CollabInvite>> collabInvites(Ref ref) => ref.watch(campusRepositoryProvider).getInvites();

/// Every decision reloads its list afterwards — after a refusal too, since
/// the usual cause is someone else having handled it already.
@riverpod
class ApprovalActions extends _$ApprovalActions {
  @override
  void build() {}

  Future<String> verifyLink(String id) => _run((r) => r.verifyOrgLink(id), orgLinkRequestsProvider);

  Future<String> approveEvent(String id) => _run((r) => r.approveEvent(id), pendingCampusEventsProvider);

  Future<String> rejectEvent(String id, String reason) => _run((r) => r.rejectEvent(id, reason), pendingCampusEventsProvider);

  Future<String> acceptInvite(CollabInvite i) => _run((r) => r.acceptInvite(i.eventId, i.id), collabInvitesProvider);

  Future<String> rejectInvite(CollabInvite i, String reason) =>
      _run((r) => r.rejectInvite(i.eventId, i.id, reason), collabInvitesProvider);

  Future<String> _run(Future<String> Function(CampusRepository r) action, ProviderOrFamily list) async {
    final link = ref.keepAlive();
    final repository = ref.read(campusRepositoryProvider);
    try {
      return await action(repository);
    } finally {
      ref.invalidate(list);
      link.close();
    }
  }
}
