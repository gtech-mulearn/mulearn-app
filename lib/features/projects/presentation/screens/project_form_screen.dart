import 'dart:async';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/features/projects/domain/entities/project.dart';
import 'package:mulearn_app/features/projects/presentation/providers/projects_providers.dart';

/// Start a project, or edit one ([projectId]). The dashboard's rules: a
/// title of up to 50 characters, a description of at least 50, and at least
/// two links. Skills, a logo and screenshots are optional; picking new
/// screenshots replaces the current ones.
class ProjectFormScreen extends ConsumerWidget {
  const ProjectFormScreen({this.projectId, super.key});

  final String? projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = projectId;
    return Scaffold(
      backgroundColor: context.mu.colors.chalk,
      body: SafeArea(
        child: Column(
          children: [
            MuTopBar.detail(title: id == null ? 'New project' : 'Edit project'),
            Expanded(
              child: id == null
                  ? const _Form(initial: null)
                  : ref
                        .watch(projectProvider(id))
                        .when(
                          loading: () => const Center(child: MuDotsLoader()),
                          error: (e, _) => ErrorRetryView(
                            error: e,
                            onRetry: () => ref.invalidate(projectProvider(id)),
                          ),
                          data: (p) => _Form(initial: p),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LinkRow {
  _LinkRow([ProjectLink? l])
    : label = TextEditingController(text: l?.label),
      url = TextEditingController(text: l?.url);

  final TextEditingController label;
  final TextEditingController url;

  void dispose() {
    label.dispose();
    url.dispose();
  }
}

typedef _Picked = ({Uint8List bytes, String name});

class _Form extends ConsumerStatefulWidget {
  const _Form({required this.initial});

  final Project? initial;

  @override
  ConsumerState<_Form> createState() => _FormState();
}

class _FormState extends ConsumerState<_Form> {
  final _formKey = GlobalKey<FormState>();
  late final _title = TextEditingController(text: widget.initial?.title);
  late final _about = TextEditingController(text: widget.initial?.description);
  late ProjectStatus _status = widget.initial?.status == ProjectStatus.published
      ? ProjectStatus.published
      : ProjectStatus.draft;
  late final List<_LinkRow> _links = [
    for (final l in widget.initial?.links ?? const <ProjectLink>[]) _LinkRow(l),
    for (var i = widget.initial?.links.length ?? 0; i < 2; i++) _LinkRow(),
  ];
  late final Set<String> _skills = {
    for (final s in widget.initial?.skills ?? const <ProjectSkill>[]) s.id,
  };
  _Picked? _logo;
  List<_Picked> _images = const [];
  String? _linksError;

  @override
  void dispose() {
    _title.dispose();
    _about.dispose();
    for (final l in _links) {
      l.dispose();
    }
    super.dispose();
  }

  Future<void> _pickLogo() async {
    final f = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
    );
    if (f == null) return;
    final bytes = await f.readAsBytes();
    if (mounted) setState(() => _logo = (bytes: bytes, name: f.name));
  }

  Future<void> _pickImages() async {
    final files = await ImagePicker().pickMultiImage(maxWidth: 1800, limit: 6);
    if (files.isEmpty) return;
    final picked = [
      for (final f in files) (bytes: await f.readAsBytes(), name: f.name),
    ];
    if (mounted) setState(() => _images = picked);
  }

  static String _https(String u) =>
      u.startsWith('http://') || u.startsWith('https://') ? u : 'https://$u';

  Future<void> _save() async {
    final filled = [
      for (final l in _links)
        if (l.url.text.trim().isNotEmpty) l,
    ];
    final linksError = filled.length < 2
        ? 'Add at least two links, like the repo and a demo.'
        : null;
    setState(() => _linksError = linksError);
    if (!(_formKey.currentState?.validate() ?? false) || linksError != null) {
      return;
    }
    final draft = ProjectDraft(
      title: _title.text.trim(),
      description: _about.text.trim(),
      status: _status,
      links: [
        for (final l in filled)
          (
            label: l.label.text.trim().isEmpty
                ? Uri.parse(_https(l.url.text.trim())).host
                : l.label.text.trim(),
            url: _https(l.url.text.trim()),
          ),
      ],
      skillIds: _skills.toList(),
      logo: _logo,
      images: _images,
    );
    final actions = ref.read(projectActionsProvider.notifier);
    final saved = widget.initial == null
        ? await actions.create(draft)
        : await actions.edit(widget.initial!.id, draft);
    if (!mounted) return;
    if (saved == null) {
      MuToast.show(
        context,
        message: ApiException.messageFor(
          ref.read(projectActionsProvider).error ?? "Couldn't save",
        ),
        type: MuToastType.error,
      );
      return;
    }
    MuToast.show(
      context,
      message: widget.initial == null
          ? (saved.status == ProjectStatus.published
                ? 'Project published'
                : 'Draft saved')
          : 'Project saved',
      type: MuToastType.success,
    );
    if (widget.initial == null) {
      context.pushReplacement(RoutePaths.projectPath(saved.id));
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final busy = ref.watch(projectActionsProvider).isLoading;
    final skills = ref.watch(projectSkillsProvider);
    final existing = widget.initial?.images ?? const <String>[];
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.fromLTRB(
                MuSpacing.space5,
                MuSpacing.space2,
                MuSpacing.space5,
                MuSpacing.space8,
              ),
              children: [
                const MuFormSection('What it is'),
                MuTextField(
                  label: 'Title',
                  controller: _title,
                  hint: 'A short name',
                  maxLength: 50,
                  textCapitalization: TextCapitalization.words,
                  validator: (v) =>
                      (v ?? '').trim().isEmpty ? 'Give it a name.' : null,
                ),
                const SizedBox(height: MuSpacing.space3),
                MuTextField(
                  label: 'Description',
                  controller: _about,
                  hint: 'The problem, what you built and how. Markdown works.',
                  minLines: 5,
                  maxLines: 12,
                  textCapitalization: TextCapitalization.sentences,
                  validator: (v) {
                    final n = (v ?? '').trim().length;
                    return n < 50
                        ? 'A little more: at least 50 characters (${50 - n} to go).'
                        : null;
                  },
                ),
                const SizedBox(height: MuSpacing.space3),
                MuSegmented<ProjectStatus>(
                  values: const [ProjectStatus.draft, ProjectStatus.published],
                  selected: _status,
                  label: (s) =>
                      s == ProjectStatus.draft ? 'Save as draft' : 'Publish',
                  onChanged: (s) => setState(() => _status = s),
                ),
                const SizedBox(height: MuSpacing.space1),
                Text(
                  _status == ProjectStatus.draft
                      ? 'Only you see a draft. Publish it when it is ready.'
                      : 'Everyone can see it, upvote it and comment.',
                  style: mu.text.caption,
                ),
                const MuFormSection(
                  'Links',
                  note: 'At least two: the code, a demo, a write-up.',
                ),
                for (final (i, l) in _links.indexed) ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 110,
                        child: MuTextField(
                          label: 'Label',
                          controller: l.label,
                          hint: i == 0 ? 'GitHub' : 'Demo',
                        ),
                      ),
                      const SizedBox(width: MuSpacing.space2),
                      Expanded(
                        child: MuTextField(
                          label: 'URL',
                          controller: l.url,
                          hint: 'github.com/you/project',
                          keyboardType: TextInputType.url,
                          validator: (v) {
                            final s = (v ?? '').trim();
                            if (s.isEmpty) return null;
                            return Uri.tryParse(
                                      _https(s),
                                    )?.host.contains('.') ??
                                    false
                                ? null
                                : 'That link looks incomplete';
                          },
                        ),
                      ),
                      if (_links.length > 2)
                        Padding(
                          padding: const EdgeInsets.only(top: 28),
                          child: MuIconButton(
                            icon: LucideIcons.x,
                            tooltip: 'Remove link',
                            variant: MuIconButtonVariant.sunk,
                            onPressed: () =>
                                setState(() => _links.removeAt(i).dispose()),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: MuSpacing.space2),
                ],
                if (_linksError != null)
                  Text(
                    _linksError!,
                    style: mu.text.caption.copyWith(color: c.danger),
                  ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: MuButton(
                    label: 'Add a link',
                    icon: LucideIcons.plus,
                    variant: MuButtonVariant.ghost,
                    size: MuButtonSize.small,
                    onPressed: () => setState(() => _links.add(_LinkRow())),
                  ),
                ),
                const MuFormSection('Skills'),
                ...skills.when(
                  loading: () => const [MuDotsLoader()],
                  error: (_, _) => const [
                    MuEmptyLine(
                      "Skills couldn't load. You can add them later.",
                    ),
                  ],
                  data: (list) => list.isEmpty
                      ? const [MuEmptyLine('No skills to pick from yet.')]
                      : [
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: [
                              for (final s in list)
                                MuFilterChip(
                                  label: s.name,
                                  selected: _skills.contains(s.id),
                                  onTap: () => setState(
                                    () => _skills.contains(s.id)
                                        ? _skills.remove(s.id)
                                        : _skills.add(s.id),
                                  ),
                                ),
                            ],
                          ),
                        ],
                ),
                const MuFormSection('Pictures'),
                Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: c.surfaceSunk,
                        borderRadius: BorderRadius.circular(MuRadii.control),
                      ),
                      child: _logo != null
                          ? Image.memory(_logo!.bytes, fit: BoxFit.cover)
                          : widget.initial?.logoUrl != null
                          ? CachedNetworkImage(
                              imageUrl: widget.initial!.logoUrl!,
                              fit: BoxFit.cover,
                            )
                          : Icon(LucideIcons.image, color: c.ink3),
                    ),
                    const SizedBox(width: MuSpacing.space3),
                    Expanded(child: Text('Logo', style: mu.text.bodyStrong)),
                    MuButton(
                      label: _logo == null && widget.initial?.logoUrl == null
                          ? 'Choose'
                          : 'Change',
                      variant: MuButtonVariant.outline,
                      size: MuButtonSize.small,
                      onPressed: _pickLogo,
                    ),
                  ],
                ),
                const SizedBox(height: MuSpacing.space4),
                if (_images.isNotEmpty || existing.isNotEmpty)
                  SizedBox(
                    height: 90,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _images.isNotEmpty
                          ? _images.length
                          : existing.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(width: MuSpacing.space2),
                      itemBuilder: (_, i) => ClipRRect(
                        borderRadius: BorderRadius.circular(MuRadii.control),
                        child: AspectRatio(
                          aspectRatio: 16 / 10,
                          child: _images.isNotEmpty
                              ? Image.memory(
                                  _images[i].bytes,
                                  fit: BoxFit.cover,
                                )
                              : CachedNetworkImage(
                                  imageUrl: existing[i],
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: MuSpacing.space2),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        existing.isNotEmpty && _images.isEmpty
                            ? 'New screenshots replace these.'
                            : 'Up to 6 screenshots.',
                        style: mu.text.caption,
                      ),
                    ),
                    MuButton(
                      label: _images.isEmpty && existing.isEmpty
                          ? 'Add screenshots'
                          : 'Choose new',
                      icon: LucideIcons.image,
                      variant: MuButtonVariant.outline,
                      size: MuButtonSize.small,
                      onPressed: _pickImages,
                    ),
                  ],
                ),
              ],
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: c.chalk,
              border: Border(top: BorderSide(color: c.line)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                MuSpacing.space5,
                MuSpacing.space3,
                MuSpacing.space5,
                MuSpacing.space3,
              ),
              child: MuButton(
                label: widget.initial == null
                    ? (_status == ProjectStatus.published
                          ? 'Publish project'
                          : 'Save draft')
                    : 'Save changes',
                block: true,
                loading: busy,
                onPressed: busy ? null : () => unawaited(_save()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
