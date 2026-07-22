import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/features/profile/presentation/providers/interest_groups_controller.dart';

/// Multi-select checklist over the full interest-group catalog, pre-checked
/// with the user's current selections.
class EditInterestGroupsDialog extends ConsumerStatefulWidget {
  const EditInterestGroupsDialog({required this.initialSelectedIds, super.key});

  final Set<String> initialSelectedIds;

  @override
  ConsumerState<EditInterestGroupsDialog> createState() =>
      _EditInterestGroupsDialogState();
}

class _EditInterestGroupsDialogState
    extends ConsumerState<EditInterestGroupsDialog> {
  late final Set<String> _selected = {...widget.initialSelectedIds};
  String _query = '';

  Future<void> _save() async {
    try {
      await ref
          .read(interestGroupsEditControllerProvider.notifier)
          .save(_selected.toList());
      if (mounted) Navigator.of(context).pop();
    } on Object catch (e) {
      if (mounted) {
        MuToast.show(context, message: ApiException.messageFor(e), type: MuToastType.error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final catalog = ref.watch(interestGroupsListProvider);
    final saving = ref.watch(interestGroupsEditControllerProvider).isLoading;

    return AlertDialog(
      title: const Text('Edit interest groups'),
      content: SizedBox(
        width: 400,
        height: 480,
        child: catalog.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) =>
              Center(child: Text(ApiException.messageFor(error))),
          data: (groups) {
            final filtered = _query.isEmpty
                ? groups
                : groups
                    .where((g) =>
                        g.name.toLowerCase().contains(_query.toLowerCase()))
                    .toList();
            return Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search interest groups…',
                  ),
                  onChanged: (value) => setState(() => _query = value),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView(
                    children: [
                      for (final group in filtered)
                        CheckboxListTile(
                          title: Text(group.name),
                          value: _selected.contains(group.id),
                          onChanged: (checked) => setState(() {
                            if (checked ?? false) {
                              _selected.add(group.id);
                            } else {
                              _selected.remove(group.id);
                            }
                          }),
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: saving ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: saving ? null : _save,
          child: saving
              ? const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Save'),
        ),
      ],
    );
  }
}
