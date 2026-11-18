import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/models/reference_option.dart';
import 'package:mulearn_app/features/team/domain/entities/push_campaign.dart';
import 'package:mulearn_app/features/team/presentation/providers/audience_options_providers.dart';

/// Most μIDs one campaign can list.
const int kMaxAudienceMuids = 5000;

/// The μIDs in [text], split on commas, spaces and new lines, without
/// repeats, in the order typed.
List<String> parseMuids(String text) => {
  for (final id in text.split(RegExp(r'[\s,]+')))
    if (id.isNotEmpty) id,
}.toList();

/// Picks who a campaign goes to for one [type]: roles and interest groups
/// are chips over the options, colleges are searched and added one by one,
/// μIDs are typed. [selected] holds the roles, groups or colleges picked;
/// [muids] holds the typed μIDs. Everyone needs nothing.
class AudiencePicker extends ConsumerWidget {
  const AudiencePicker({
    required this.type,
    required this.selected,
    required this.onChanged,
    required this.muids,
    this.muidsError,
    super.key,
  });

  final AudienceType type;
  final List<ReferenceOption> selected;
  final ValueChanged<List<ReferenceOption>> onChanged;
  final TextEditingController muids;
  final String? muidsError;

  void _toggle(ReferenceOption option) {
    final has = selected.any((o) => o.id == option.id);
    onChanged(
      has
          ? selected.where((o) => o.id != option.id).toList()
          : [...selected, option],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) => switch (type) {
    AudienceType.all || AudienceType.custom => const SizedBox.shrink(),
    AudienceType.roles => _Options(
      options: ref.watch(teamRoleOptionsProvider),
      selected: selected,
      onToggle: _toggle,
      onRetry: () => ref.invalidate(teamRoleOptionsProvider),
    ),
    AudienceType.igs => _Options(
      options: ref.watch(teamIgOptionsProvider),
      selected: selected,
      onToggle: _toggle,
      onRetry: () => ref.invalidate(teamIgOptionsProvider),
    ),
    AudienceType.colleges => _Colleges(
      selected: selected,
      onAdd: (o) {
        if (!selected.any((s) => s.id == o.id)) onChanged([...selected, o]);
      },
      onRemove: _toggle,
      search: (query) async => [
        for (final o in await ref.read(teamCollegeSearchProvider(query).future))
          MuOption(o.id, o.title),
      ],
    ),
    AudienceType.muids => MuTextField(
      label: 'μIDs',
      controller: muids,
      hint: 'One per line, or separated by commas',
      help: 'Up to $kMaxAudienceMuids.',
      error: muidsError,
      maxLines: 6,
      minLines: 3,
      keyboardType: TextInputType.multiline,
    ),
  };
}

class _Options extends StatelessWidget {
  const _Options({
    required this.options,
    required this.selected,
    required this.onToggle,
    required this.onRetry,
  });

  final AsyncValue<List<ReferenceOption>> options;
  final List<ReferenceOption> selected;
  final ValueChanged<ReferenceOption> onToggle;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    return options.when(
      loading: () => const Padding(
        padding: EdgeInsets.all(MuSpacing.space4),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (_, _) => Row(
        children: [
          Expanded(
            child: Text(
              "Couldn't load the list.",
              style: mu.text.body.copyWith(color: mu.colors.ink3),
            ),
          ),
          MuButton(
            label: 'Try again',
            variant: MuButtonVariant.ghost,
            size: MuButtonSize.small,
            onPressed: onRetry,
          ),
        ],
      ),
      data: (items) => Wrap(
        spacing: MuSpacing.space2,
        runSpacing: MuSpacing.space1,
        children: [
          for (final o in items)
            MuFilterChip(
              label: o.title,
              selected: selected.any((s) => s.id == o.id),
              onTap: () => onToggle(o),
            ),
        ],
      ),
    );
  }
}

class _Colleges extends StatelessWidget {
  const _Colleges({
    required this.selected,
    required this.onAdd,
    required this.onRemove,
    required this.search,
  });

  final List<ReferenceOption> selected;
  final ValueChanged<ReferenceOption> onAdd;
  final ValueChanged<ReferenceOption> onRemove;
  final Future<List<MuOption>> Function(String query) search;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MuSelectField(
          label: 'Add a college',
          hint: 'Search colleges',
          options: const [],
          search: search,
          onChanged: (_) {},
          onPicked: (o) => onAdd(ReferenceOption(id: o.id, title: o.label)),
        ),
        if (selected.isNotEmpty) ...[
          const SizedBox(height: MuSpacing.space3),
          Wrap(
            spacing: MuSpacing.space2,
            runSpacing: MuSpacing.space2,
            children: [
              for (final o in selected)
                Container(
                  padding: const EdgeInsets.only(left: MuSpacing.space3),
                  decoration: BoxDecoration(
                    color: c.cobaltTint,
                    borderRadius: BorderRadius.circular(MuRadii.round),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          o.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: mu.text.label.copyWith(color: c.cobaltText),
                        ),
                      ),
                      IconButton(
                        tooltip: 'Remove ${o.title}',
                        icon: Icon(
                          LucideIcons.x,
                          size: MuSizes.iconSm,
                          color: c.cobaltText,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints.tightFor(
                          width: MuSizes.touchMin,
                          height: MuSizes.touchMin,
                        ),
                        onPressed: () => onRemove(o),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ],
    );
  }
}
