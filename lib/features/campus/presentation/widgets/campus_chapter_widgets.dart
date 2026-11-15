import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/utils/search_debouncer.dart';
import 'package:mulearn_app/features/campus/domain/entities/campus_chapter.dart';
import 'package:mulearn_app/features/campus/presentation/providers/campus_chapters_providers.dart';

String _membersLine(int n) => n == 1 ? '1 member' : '$n members';

/// "Lead: Asha · Co-lead: Ravi", or "No lead yet".
String chapterLeadLine(CampusChapter c) {
  if (c.leadName == null && c.coLeadName == null) return 'No lead yet';
  return [
    if (c.leadName != null) 'Lead: ${c.leadName}',
    if (c.coLeadName != null) 'Co-lead: ${c.coLeadName}',
  ].join(' · ');
}

/// A chapter as a feed row: the IG's code, its name, members and lead, a
/// bar against the biggest chapter shown. Opens the chapter.
class CampusChapterRow extends StatelessWidget {
  const CampusChapterRow({
    required this.chapter,
    required this.peak,
    required this.canManage,
    required this.last,
    super.key,
  });

  final CampusChapter chapter;

  /// The most members in any chapter shown, for the bar.
  final int peak;
  final bool canManage;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final ch = chapter;
    return MuFeedRow(
      leading: Container(
        width: MuSizes.avatarMd,
        height: MuSizes.avatarMd,
        decoration: BoxDecoration(
          color: c.surfaceSunk,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(4),
        child: FittedBox(
          child: Text(
            ch.igCode.isEmpty ? ch.igName.characters.first : ch.igCode,
            style: mu.text.codeSm.copyWith(color: c.ink),
          ),
        ),
      ),
      subject: ch.igName,
      time: '${_membersLine(ch.members)} · ${chapterLeadLine(ch)}',
      actions: [
        if (!ch.isActive)
          const MuPill('Inactive', icon: LucideIcons.pauseCircle),
      ],
      trailing: SizedBox(
        width: 56,
        child: MuBar(value: peak <= 0 ? 0 : ch.members / peak),
      ),
      divider: !last,
      onTap: () => CampusChapterSheet.show(context, ch, canManage: canManage),
    );
  }
}

/// One chapter: who leads it, how many learners it has, what it's about.
/// Opens its interest group; the Campus Lead and Lead Enabler can edit it.
class CampusChapterSheet extends StatelessWidget {
  const CampusChapterSheet({
    required this.chapter,
    required this.canManage,
    super.key,
  });

  final CampusChapter chapter;
  final bool canManage;

  static Future<void> show(
    BuildContext context,
    CampusChapter chapter, {
    required bool canManage,
  }) => showMuSheet<void>(
    context,
    builder: (_) => CampusChapterSheet(chapter: chapter, canManage: canManage),
  );

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final ch = chapter;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        MuSpacing.space5,
        0,
        MuSpacing.space5,
        MuSpacing.space5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            header: true,
            child: Text('${ch.igName} chapter', style: mu.text.title2),
          ),
          const SizedBox(height: MuSpacing.space2),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              if (ch.isActive)
                const MuPill(
                  'Active',
                  tone: MuPillTone.success,
                  icon: LucideIcons.check,
                )
              else
                const MuPill('Inactive', icon: LucideIcons.pauseCircle),
              if (ch.igCode.isNotEmpty) MuPill(ch.igCode, mono: true),
            ],
          ),
          const SizedBox(height: MuSpacing.space4),
          MuFeedGroup(
            children: [
              MuFeedRow(
                leading: const MuFeedIcon(LucideIcons.users),
                subject: _membersLine(ch.members),
                time: 'Learners from your campus',
              ),
              MuFeedRow(
                leading: MuAvatar(
                  name: ch.leadName ?? '?',
                  size: MuSizes.avatarMd,
                  ring: false,
                ),
                subject: ch.leadName ?? 'No lead yet',
                time: 'Chapter lead',
                divider: ch.coLeadName != null,
              ),
              if (ch.coLeadName != null)
                MuFeedRow(
                  leading: MuAvatar(
                    name: ch.coLeadName!,
                    size: MuSizes.avatarMd,
                    ring: false,
                  ),
                  subject: ch.coLeadName!,
                  time: 'Co-lead',
                  divider: false,
                ),
            ],
          ),
          if (ch.description != null) ...[
            const SizedBox(height: MuSpacing.space4),
            Text(
              ch.description!,
              style: mu.text.body.copyWith(color: mu.colors.ink2),
            ),
          ],
          const SizedBox(height: MuSpacing.space5),
          if (ch.igId.isNotEmpty)
            MuButton(
              label: 'Open the interest group',
              icon: LucideIcons.arrowUpRight,
              variant: MuButtonVariant.outline,
              block: true,
              onPressed: () {
                Navigator.of(context).pop();
                unawaited(
                  context.push(RoutePaths.interestGroupDetailPath(ch.igId)),
                );
              },
            ),
          if (canManage) ...[
            const SizedBox(height: MuSpacing.space2),
            MuButton(
              label: 'Edit chapter',
              icon: LucideIcons.pencil,
              block: true,
              onPressed: () {
                Navigator.of(context).pop();
                unawaited(CampusChapterForm.show(context, chapter: ch));
              },
            ),
          ],
        ],
      ),
    );
  }
}

/// Start a chapter ([chapter] null) or edit one. Starting picks the interest
/// group (those without an active chapter), a description and optionally a
/// lead; editing changes the description, the lead and whether it's active,
/// or removes it.
class CampusChapterForm extends ConsumerStatefulWidget {
  const CampusChapterForm({this.chapter, this.taken = const {}, super.key});

  final CampusChapter? chapter;

  /// IG ids that already have an active chapter.
  final Set<String> taken;

  static Future<void> show(
    BuildContext context, {
    CampusChapter? chapter,
    Set<String> taken = const {},
  }) => showMuSheet<void>(
    context,
    builder: (_) => CampusChapterForm(chapter: chapter, taken: taken),
  );

  @override
  ConsumerState<CampusChapterForm> createState() => _CampusChapterFormState();
}

class _CampusChapterFormState extends ConsumerState<CampusChapterForm> {
  final _formKey = GlobalKey<FormState>();
  late final _about = TextEditingController(
    text: widget.chapter?.description ?? '',
  );
  String? _ig;
  CampusMember? _lead;
  late bool _active = widget.chapter?.isActive ?? true;

  bool get _editing => widget.chapter != null;

  @override
  void dispose() {
    _about.dispose();
    super.dispose();
  }

  void _toast(String? message) {
    final error = ref.read(campusChapterActionsProvider).error;
    MuToast.show(
      context,
      message:
          message ?? ApiException.messageFor(error ?? "That didn't go through"),
      type: message != null ? MuToastType.success : MuToastType.error,
    );
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final actions = ref.read(campusChapterActionsProvider.notifier);
    final message = _editing
        ? await actions.edit(
            widget.chapter!.id,
            description: _about.text,
            isActive: _active,
            leadMuid: _lead?.muid,
          )
        : await actions.create(
            igId: _ig!,
            description: _about.text,
            leadMuid: _lead?.muid,
          );
    if (!mounted) return;
    _toast(message);
    if (message != null) Navigator.of(context).pop();
  }

  Future<void> _remove() async {
    final ch = widget.chapter!;
    final sure = await showMuConfirm(
      context,
      title: 'Remove the ${ch.igName} chapter?',
      body:
          'It stops being active at your campus and its lead loses the chapter lead role. '
          'You can start it again later.',
      confirmLabel: 'Remove',
      destructive: true,
    );
    if (!sure || !mounted) return;
    final message = await ref
        .read(campusChapterActionsProvider.notifier)
        .remove(ch.id);
    if (!mounted) return;
    _toast(message);
    if (message != null) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final busy = ref.watch(campusChapterActionsProvider).isLoading;
    final ch = widget.chapter;
    final igs = _editing ? null : ref.watch(chapterIgOptionsProvider);
    return Form(
      key: _formKey,
      child: MuFormSheet(
        title: _editing ? 'Edit the ${ch!.igName} chapter' : 'Start a chapter',
        lead: _editing
            ? null
            : 'A chapter is your campus’s own group for a μLearn interest group, with a lead.',
        action: MuButton(
          label: _editing ? 'Save chapter' : 'Start chapter',
          block: true,
          loading: busy,
          onPressed: busy ? null : _save,
        ),
        children: [
          if (!_editing)
            MuSelectField(
              label: 'Interest group',
              hint: 'Pick an interest group',
              loading: igs?.isLoading ?? false,
              error: (igs?.hasError ?? false)
                  ? "Interest groups couldn't load. Close and try again."
                  : null,
              options: [
                for (final g in igs?.value ?? const <ChapterIgOption>[])
                  if (!widget.taken.contains(g.id)) MuOption(g.id, g.name),
              ],
              value: _ig,
              onChanged: (v) => setState(() => _ig = v),
              validator: (_) => _ig == null ? 'Pick the interest group.' : null,
            ),
          MuTextField(
            label: 'Description (optional)',
            controller: _about,
            hint: 'What the chapter does at your campus',
            minLines: 2,
            maxLines: 5,
            textCapitalization: TextCapitalization.sentences,
          ),
          CampusLeadPicker(
            current: _editing ? ch!.leadName : null,
            picked: _lead,
            onPicked: (m) => setState(() => _lead = m),
          ),
          if (_editing) ...[
            MuSwitchTile(
              label: 'Active',
              subtitle: 'Inactive chapters stay listed but are paused',
              value: _active,
              onChanged: busy ? null : (v) => setState(() => _active = v),
            ),
            MuButton(
              label: 'Remove chapter',
              icon: LucideIcons.trash2,
              variant: MuButtonVariant.danger,
              block: true,
              onPressed: busy ? null : _remove,
            ),
          ],
        ],
      ),
    );
  }
}

/// Picks a chapter lead from the campus's members by name or muid. Shows the
/// current lead until a new one is picked.
class CampusLeadPicker extends ConsumerStatefulWidget {
  const CampusLeadPicker({
    required this.onPicked,
    this.current,
    this.picked,
    super.key,
  });

  /// The lead today (editing), by name.
  final String? current;
  final CampusMember? picked;
  final ValueChanged<CampusMember?> onPicked;

  @override
  ConsumerState<CampusLeadPicker> createState() => _CampusLeadPickerState();
}

class _CampusLeadPickerState extends ConsumerState<CampusLeadPicker> {
  final _search = TextEditingController();
  String _query = '';
  late final _debouncer = SearchDebouncer((q) {
    if (mounted) setState(() => _query = q);
  });

  @override
  void dispose() {
    _debouncer.dispose();
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final picked = widget.picked;
    final found = ref.watch(campusMemberSearchProvider(_query));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Lead', style: mu.text.label),
        const SizedBox(height: MuSpacing.space2),
        if (picked != null)
          MuFeedRow(
            leading: MuAvatar(
              name: picked.name,
              url: picked.photoUrl,
              size: MuSizes.avatarMd,
              ring: false,
            ),
            subject: picked.name,
            time: picked.muid,
            trailing: MuIconButton(
              icon: LucideIcons.x,
              tooltip: 'Clear the new lead',
              variant: MuIconButtonVariant.sunk,
              onPressed: () => widget.onPicked(null),
            ),
            divider: false,
          )
        else ...[
          Text(
            widget.current == null
                ? 'No lead yet. Search your campus’s members to pick one (optional).'
                : 'Now: ${widget.current}. Search to change.',
            style: mu.text.caption,
          ),
          const SizedBox(height: MuSpacing.space2),
          MuSearchField(
            controller: _search,
            hint: 'Name or muid',
            onChanged: _debouncer.onChanged,
            onSubmitted: _debouncer.submit,
          ),
          if (_query.length >= 2)
            ...found.when(
              loading: () => const [
                Padding(
                  padding: EdgeInsets.all(MuSpacing.space3),
                  child: Center(child: MuDotsLoader()),
                ),
              ],
              error: (e, _) => [MuEmptyLine(ApiException.messageFor(e))],
              data: (people) => people.isEmpty
                  ? const [MuEmptyLine('No campus member matches that.')]
                  : [
                      MuFeedGroup(
                        children: [
                          for (final (i, m) in people.indexed)
                            MuFeedRow(
                              leading: MuAvatar(
                                name: m.name,
                                url: m.photoUrl,
                                size: MuSizes.avatarMd,
                                ring: false,
                              ),
                              subject: m.name,
                              time: m.muid,
                              trailing: MuButton(
                                label: 'Pick',
                                size: MuButtonSize.small,
                                variant: MuButtonVariant.outline,
                                onPressed: () {
                                  _search.clear();
                                  _debouncer.reset();
                                  setState(() => _query = '');
                                  widget.onPicked(m);
                                },
                              ),
                              divider: i < people.length - 1,
                            ),
                        ],
                      ),
                    ],
            ),
        ],
      ],
    );
  }
}
