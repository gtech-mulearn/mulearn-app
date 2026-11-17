import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/models/reference_option.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/features/team/domain/entities/campaign_draft.dart';
import 'package:mulearn_app/features/team/domain/entities/push_campaign.dart';
import 'package:mulearn_app/features/team/presentation/campaign_links.dart';
import 'package:mulearn_app/features/team/presentation/providers/campaigns_controller.dart';
import 'package:mulearn_app/features/team/presentation/widgets/audience_picker.dart';

/// Writes a new push: the text, where it opens, who gets it and when. Save
/// creates the campaign (a draft, or scheduled) and opens it, where Send now
/// lives.
class CampaignFormScreen extends ConsumerStatefulWidget {
  const CampaignFormScreen({super.key});

  @override
  ConsumerState<CampaignFormScreen> createState() => _CampaignFormScreenState();
}

class _CampaignFormScreenState extends ConsumerState<CampaignFormScreen> {
  static const _titleMax = 100;
  static const _messageMax = 240;

  static const _audienceLabels = <AudienceType, String>{
    AudienceType.all: 'Everyone',
    AudienceType.roles: 'Roles',
    AudienceType.igs: 'Interest groups',
    AudienceType.colleges: 'Colleges',
    AudienceType.muids: 'μIDs',
  };

  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _message = TextEditingController();
  final _path = TextEditingController();
  final _muids = TextEditingController();

  String _link = kCampaignNoLink;
  AudienceType _type = AudienceType.all;
  List<ReferenceOption> _selected = const [];
  String? _audienceError;
  bool _schedule = false;
  DateTime? _when;
  bool _quietHours = true;
  bool _busy = false;

  @override
  void dispose() {
    _title.dispose();
    _message.dispose();
    _path.dispose();
    _muids.dispose();
    super.dispose();
  }

  String? _required(String? value, String what) =>
      (value ?? '').trim().isEmpty ? 'Add $what.' : null;

  String? _pathError(String? value) {
    final path = (value ?? '').trim();
    if (path.isEmpty) return 'Add the app path, like /events.';
    if (!path.startsWith('/')) return 'Start the path with /, like /events.';
    return null;
  }

  void _toast(String message, MuToastType type) {
    if (mounted) MuToast.show(context, message: message, type: type);
  }

  void _setType(AudienceType type) {
    if (type == _type) return;
    setState(() {
      _type = type;
      _selected = const [];
      _audienceError = null;
    });
  }

  void _setSchedule(bool on) {
    setState(() {
      _schedule = on;
      _when = on
          ? (_when ??
                ref
                    .read(clockProvider)()
                    .toLocal()
                    .add(const Duration(hours: 1)))
          : null;
    });
  }

  Future<void> _pickDay() async {
    final today = ref.read(clockProvider)().toLocal();
    final first = DateTime(today.year, today.month, today.day);
    final current = _when ?? today;
    final picked = await showDatePicker(
      context: context,
      initialDate: current.isBefore(first) ? first : current,
      firstDate: first,
      lastDate: first.add(const Duration(days: 365)),
    );
    if (picked == null || !mounted) return;
    setState(() {
      _when = DateTime(
        picked.year,
        picked.month,
        picked.day,
        current.hour,
        current.minute,
      );
    });
  }

  Future<void> _pickTime() async {
    final current = _when ?? ref.read(clockProvider)().toLocal();
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: current.hour, minute: current.minute),
    );
    if (picked == null || !mounted) return;
    setState(() {
      _when = DateTime(
        current.year,
        current.month,
        current.day,
        picked.hour,
        picked.minute,
      );
    });
  }

  /// The audience ids to send, or null (with [_audienceError] set) when the
  /// audience isn't filled in. Roles go by title, the rest by id.
  List<String>? _audienceIds() {
    String? error;
    List<String>? ids;
    switch (_type) {
      case AudienceType.all:
        ids = const [];
      case AudienceType.roles:
        ids = [for (final o in _selected) o.title];
        error = ids.isEmpty ? 'Pick at least one role.' : null;
      case AudienceType.igs:
        ids = [for (final o in _selected) o.id];
        error = ids.isEmpty ? 'Pick at least one interest group.' : null;
      case AudienceType.colleges:
        ids = [for (final o in _selected) o.id];
        error = ids.isEmpty ? 'Add at least one college.' : null;
      case AudienceType.muids:
        ids = parseMuids(_muids.text);
        error = ids.isEmpty
            ? 'Add at least one μID.'
            : ids.length > kMaxAudienceMuids
            ? 'Up to $kMaxAudienceMuids μIDs, you have ${ids.length}.'
            : null;
    }
    setState(() => _audienceError = error);
    return error == null ? ids : null;
  }

  Future<void> _submit() async {
    final valid = _formKey.currentState?.validate() ?? false;
    final ids = _audienceIds();
    if (!valid || ids == null) return;
    final when = _schedule ? _when : null;
    if (when != null && !when.isAfter(ref.read(clockProvider)().toLocal())) {
      _toast('Pick a time in the future.', MuToastType.error);
      return;
    }
    FocusScope.of(context).unfocus();
    final route = switch (_link) {
      kCampaignNoLink => null,
      kCampaignCustomLink => _path.text.trim(),
      final path => path,
    };
    setState(() => _busy = true);
    try {
      final created = await ref
          .read(campaignsControllerProvider.notifier)
          .create(
            CampaignDraft(
              title: _title.text.trim(),
              body: _message.text.trim(),
              route: route,
              audienceType: _type,
              audienceIds: ids,
              scheduledAt: when,
              respectQuietHours: _quietHours,
            ),
          );
      if (!mounted) return;
      _toast('Campaign saved', MuToastType.success);
      context.pushReplacement(RoutePaths.teamCampaignPath(created.id));
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
    final when = _when;
    return MuWorkspacePage(
      title: 'New push',
      bottom: MuButton(
        label: 'Save',
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
            MuSelectField(
              label: 'Opens',
              value: _link,
              options: [
                for (final (value, label) in kCampaignLinks)
                  MuOption(value, label),
              ],
              onChanged: (v) => setState(() => _link = v ?? kCampaignNoLink),
            ),
            if (_link == kCampaignCustomLink) ...[
              const SizedBox(height: MuSpacing.space4),
              MuTextField(
                label: 'App path',
                controller: _path,
                hint: '/events',
                keyboardType: TextInputType.url,
                validator: _pathError,
              ),
            ],
            const SizedBox(height: MuSpacing.space6),
            Text('Send to', style: mu.text.label.copyWith(color: c.ink2)),
            const SizedBox(height: MuSpacing.space2),
            Wrap(
              spacing: MuSpacing.space2,
              runSpacing: MuSpacing.space1,
              children: [
                for (final entry in _audienceLabels.entries)
                  MuFilterChip(
                    label: entry.value,
                    selected: _type == entry.key,
                    onTap: () => _setType(entry.key),
                  ),
              ],
            ),
            const SizedBox(height: MuSpacing.space3),
            AudiencePicker(
              type: _type,
              selected: _selected,
              muids: _muids,
              muidsError: _type == AudienceType.muids ? _audienceError : null,
              onChanged: (list) => setState(() {
                _selected = list;
                _audienceError = null;
              }),
            ),
            if (_audienceError != null && _type != AudienceType.muids)
              Padding(
                padding: const EdgeInsets.only(top: MuSpacing.space2),
                child: Text(
                  _audienceError!,
                  style: mu.text.label.copyWith(color: c.danger),
                ),
              ),
            const SizedBox(height: MuSpacing.space5),
            MuSwitchTile(
              label: 'Schedule',
              subtitle: 'Send later instead of saving a draft.',
              value: _schedule,
              onChanged: _setSchedule,
            ),
            if (_schedule && when != null)
              Padding(
                padding: const EdgeInsets.only(top: MuSpacing.space2),
                child: Row(
                  children: [
                    Expanded(
                      child: MuButton(
                        label: formatDay(when),
                        variant: MuButtonVariant.outline,
                        icon: LucideIcons.calendarDays,
                        onPressed: () => unawaited(_pickDay()),
                      ),
                    ),
                    const SizedBox(width: MuSpacing.space3),
                    Expanded(
                      child: MuButton(
                        label: formatTime(when),
                        variant: MuButtonVariant.outline,
                        icon: LucideIcons.clock,
                        onPressed: () => unawaited(_pickTime()),
                      ),
                    ),
                  ],
                ),
              ),
            MuSwitchTile(
              label: 'Respect quiet hours',
              subtitle: 'Hold pushes for people who are asleep.',
              value: _quietHours,
              onChanged: (v) => setState(() => _quietHours = v),
            ),
          ],
        ),
      ),
    );
  }
}
