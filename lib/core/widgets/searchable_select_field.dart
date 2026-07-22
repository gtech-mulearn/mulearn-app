import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';

/// A `{id, label}` pair — UI-only, domain-agnostic wrapper so this widget can
/// present [ReferenceOption] (`{id, title}`) or [LocationOption]
/// (`{id, name}`) options without depending on either.
class SelectOption {
  const SelectOption({required this.id, required this.label});

  final String id;
  final String label;
}

/// Sentinel value for "not in the list, add it" — mirrors the reference
/// Combobox's `onCreateNew` behavior: selecting it sets the field's value to
/// this literal string, and the caller shows a parallel custom-text field.
const String kSearchableSelectOthersValue = 'others';

/// A searchable, single-select picker field styled like the app's other form
/// fields (same [InputDecorationTheme]), with an optional "not listed? add it
/// manually" entry — the Flutter equivalent of the reference dashboard's
/// `Combobox` component.
class SearchableSelectField extends StatelessWidget {
  const SearchableSelectField({
    required this.label,
    required this.options,
    required this.onSelected,
    super.key,
    this.initialValue,
    this.hintText,
    this.isLoading = false,
    this.enabled = true,
    this.allowOthers = false,
    this.othersLabel = 'Others (not listed)',
    this.othersSelectedLabel,
    this.validator,
  });

  final String label;
  final String? hintText;
  final List<SelectOption> options;
  final bool isLoading;
  final bool enabled;
  final bool allowOthers;
  final String othersLabel;

  /// Label shown when the current value is [kSearchableSelectOthersValue]
  /// (e.g. the custom text the user typed) — falls back to [othersLabel].
  final String? othersSelectedLabel;

  final String? initialValue;
  final ValueChanged<String?> onSelected;
  final FormFieldValidator<String>? validator;

  String? _labelFor(String? value) {
    if (value == kSearchableSelectOthersValue) {
      return othersSelectedLabel ?? othersLabel;
    }
    for (final option in options) {
      if (option.id == value) return option.label;
    }
    return null;
  }

  Future<void> _openPicker(BuildContext context, FormFieldState<String> field) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (context) => _SearchableSelectSheet(
        title: label,
        options: options,
        allowOthers: allowOthers,
        othersLabel: othersLabel,
      ),
    );
    if (selected != null) {
      field.didChange(selected);
      onSelected(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: initialValue,
      validator: validator,
      builder: (field) {
        final canOpen = enabled && !isLoading;
        final selectedLabel = _labelFor(field.value);
        return InkWell(
          onTap: canOpen ? () => _openPicker(context, field) : null,
          borderRadius: BorderRadius.circular(10),
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: label,
              errorText: field.errorText,
              suffixIcon: isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(14),
                      child: SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : const Icon(Icons.arrow_drop_down),
            ),
            child: Text(
              selectedLabel ?? hintText ?? 'Select',
              style: selectedLabel == null
                  ? Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: MuColors.inkSecondary)
                  : Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      },
    );
  }
}

class _SearchableSelectSheet extends StatefulWidget {
  const _SearchableSelectSheet({
    required this.title,
    required this.options,
    required this.allowOthers,
    required this.othersLabel,
  });

  final String title;
  final List<SelectOption> options;
  final bool allowOthers;
  final String othersLabel;

  @override
  State<_SearchableSelectSheet> createState() => _SearchableSelectSheetState();
}

class _SearchableSelectSheetState extends State<_SearchableSelectSheet> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _query.isEmpty
        ? widget.options
        : widget.options
            .where((o) => o.label.toLowerCase().contains(_query.toLowerCase()))
            .toList();

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: FractionallySizedBox(
          heightFactor: 0.75,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _searchController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search…',
                  ),
                  onChanged: (value) => setState(() => _query = value),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView(
                  children: [
                    for (final option in filtered)
                      ListTile(
                        title: Text(option.label),
                        onTap: () => Navigator.of(context).pop(option.id),
                      ),
                    if (filtered.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        child: Text(
                          'No matches.',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: MuColors.inkSecondary),
                        ),
                      ),
                    if (widget.allowOthers) ...[
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.add),
                        title: Text(widget.othersLabel),
                        onTap: () => Navigator.of(context)
                            .pop(kSearchableSelectOthersValue),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
