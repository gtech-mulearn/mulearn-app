import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/features/team/domain/entities/announcement.dart';
import 'package:mulearn_app/features/team/presentation/providers/announcements_controller.dart';

/// Sends a new announcement to everyone, or edits one ([announcementId]).
class AnnouncementFormScreen extends ConsumerWidget {
  const AnnouncementFormScreen({this.announcementId, super.key});

  final String? announcementId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = announcementId;
    if (id == null) return const _AnnouncementForm();
    return ref
        .watch(announcementsControllerProvider)
        .when(
          skipError: true,
          loading: () => const MuWorkspacePage(
            title: 'Edit announcement',
            body: Center(child: CircularProgressIndicator()),
          ),
          error: (error, _) => MuWorkspacePage(
            title: 'Edit announcement',
            body: ErrorRetryView(
              error: error,
              onRetry: () => ref.invalidate(announcementsControllerProvider),
            ),
          ),
          data: (data) {
            final matches = data.page.items.where((a) => a.id == id);
            if (matches.isEmpty) {
              return const MuWorkspacePage(
                title: 'Edit announcement',
                body: Center(
                  child: SingleChildScrollView(
                    child: MuStateDisplay(variant: MuStateVariant.notFound),
                  ),
                ),
              );
            }
            return _AnnouncementForm(announcement: matches.first);
          },
        );
  }
}

class _AnnouncementForm extends ConsumerStatefulWidget {
  const _AnnouncementForm({this.announcement});

  /// Null when sending a new one.
  final Announcement? announcement;

  @override
  ConsumerState<_AnnouncementForm> createState() => _AnnouncementFormState();
}

class _AnnouncementFormState extends ConsumerState<_AnnouncementForm> {
  static const _titleMax = 100;
  static const _messageMax = 300;
  static const _defaultDays = 7;

  final _formKey = GlobalKey<FormState>();
  late final Announcement? _original = widget.announcement;
  late final _title = TextEditingController(text: _original?.title);
  late final _message = TextEditingController(text: _original?.description);
  late final _link = TextEditingController(text: _original?.url);
  final _days = TextEditingController(text: '$_defaultDays');
  late DateTime? _expires = _original?.expiresAt.toLocal();
  bool _busy = false;

  bool get _editing => _original != null;

  @override
  void dispose() {
    _title.dispose();
    _message.dispose();
    _link.dispose();
    _days.dispose();
    super.dispose();
  }

  String? _required(String? value, String what) =>
      (value ?? '').trim().isEmpty ? 'Add $what.' : null;

  String? _linkError(String? value) {
    final link = (value ?? '').trim();
    if (link.isEmpty) return null;
    if (link.startsWith('/') || link.startsWith('https://')) return null;
    return 'Use a path like /events, or a link starting with https://.';
  }

  String? _daysError(String? value) {
    final days = int.tryParse((value ?? '').trim());
    if (days == null || days < 1 || days > 90) {
      return 'Enter a number of days from 1 to 90.';
    }
    return null;
  }

  void _toast(String message, MuToastType type) {
    if (mounted) MuToast.show(context, message: message, type: type);
  }

  void _leave() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(RoutePaths.teamAnnouncements);
    }
  }

  Future<void> _pickExpiry() async {
    final current = _expires ?? ref.read(clockProvider)().toLocal();
    final today = ref.read(clockProvider)().toLocal();
    final first = DateTime(today.year, today.month, today.day);
    final picked = await showDatePicker(
      context: context,
      initialDate: current.isBefore(first) ? first : current,
      firstDate: first,
      lastDate: first.add(const Duration(days: 365)),
    );
    if (picked == null || !mounted) return;
    setState(() {
      // Keep the time of day the announcement already has.
      _expires = DateTime(
        picked.year,
        picked.month,
        picked.day,
        current.hour,
        current.minute,
      );
    });
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    if (_editing) {
      await _save();
    } else {
      await _send();
    }
  }

  Future<void> _send() async {
    final confirmed = await showMuConfirm(
      context,
      title: 'Send to everyone?',
      body: "It appears in every member's notifications.",
      confirmLabel: 'Send',
    );
    if (!confirmed || !mounted) return;
    final link = _link.text.trim();
    setState(() => _busy = true);
    try {
      await ref
          .read(announcementsControllerProvider.notifier)
          .send(
            title: _title.text.trim(),
            description: _message.text.trim(),
            redirectUrl: link.isEmpty ? null : link,
            expiresInDays: int.parse(_days.text.trim()),
          );
      if (!mounted) return;
      _toast('Announcement sent', MuToastType.success);
      _leave();
    } on Object catch (e) {
      _toast(ApiException.messageFor(e), MuToastType.error);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  /// Sends only what differs from the loaded announcement.
  Future<void> _save() async {
    final original = _original!;
    final title = _title.text.trim();
    final message = _message.text.trim();
    final link = _link.text.trim();
    final expires = _expires!;
    final oldExpires = original.expiresAt.toLocal();
    final sameDay =
        expires.year == oldExpires.year &&
        expires.month == oldExpires.month &&
        expires.day == oldExpires.day;
    final newTitle = title == original.title ? null : title;
    final newMessage = message == original.description ? null : message;
    final newLink = link == (original.url ?? '') ? null : link;
    final newExpires = sameDay ? null : expires;
    if (newTitle == null &&
        newMessage == null &&
        newLink == null &&
        newExpires == null) {
      _leave();
      return;
    }
    setState(() => _busy = true);
    try {
      await ref
          .read(announcementsControllerProvider.notifier)
          .edit(
            original.id,
            title: newTitle,
            description: newMessage,
            url: newLink,
            expiresAt: newExpires,
          );
      if (!mounted) return;
      _toast('Announcement updated', MuToastType.success);
      _leave();
    } on Object catch (e) {
      _toast(ApiException.messageFor(e), MuToastType.error);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    return MuWorkspacePage(
      title: _editing ? 'Edit announcement' : 'New announcement',
      bottom: MuButton(
        label: _editing ? 'Save' : 'Send to everyone',
        block: true,
        loading: _busy,
        onPressed: _busy ? null : () => unawaited(_submit()),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: muListPadding,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            MuTextField(
              label: 'Title',
              controller: _title,
              maxLength: _titleMax,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
              validator: (v) => _required(v, 'a title'),
            ),
            const SizedBox(height: MuSpacing.space4),
            MuTextField(
              label: 'Message',
              controller: _message,
              maxLength: _messageMax,
              maxLines: 4,
              minLines: 3,
              textCapitalization: TextCapitalization.sentences,
              validator: (v) => _required(v, 'a message'),
            ),
            const SizedBox(height: MuSpacing.space4),
            MuTextField(
              label: 'Opens (optional)',
              controller: _link,
              hint: '/events or https://…',
              help: 'Where tapping it takes people.',
              keyboardType: TextInputType.url,
              validator: _linkError,
            ),
            const SizedBox(height: MuSpacing.space4),
            if (_editing) ...[
              Text('Expires', style: mu.text.label.copyWith(color: c.ink2)),
              const SizedBox(height: MuSpacing.space2),
              MuButton(
                label: formatDay(_expires!),
                variant: MuButtonVariant.outline,
                icon: LucideIcons.calendarDays,
                block: true,
                onPressed: () => unawaited(_pickExpiry()),
              ),
            ] else
              MuTextField(
                label: 'Show for (days)',
                controller: _days,
                help: 'From 1 to 90 days.',
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: _daysError,
              ),
          ],
        ),
      ),
    );
  }
}
