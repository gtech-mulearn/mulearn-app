import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/feedback/mu_sheet.dart';
import 'package:mulearn_app/core/design_system/input/mu_field_chrome.dart';
import 'package:mulearn_app/core/design_system/input/mu_search_field.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// One choice in a [MuSelectField]: the value sent to the server and what
/// people read.
@immutable
class MuOption {
  /// An option.
  const MuOption(this.id, this.label);

  final String id;
  final String label;

  @override
  bool operator ==(Object other) =>
      other is MuOption && other.id == id && other.label == label;

  @override
  int get hashCode => Object.hash(id, label);
}

/// The value a [MuSelectField] reports when the person picks "not listed":
/// the caller then shows a field for the name they type.
const String muOtherOptionValue = 'others';

/// A select (artifact TextField → Select): looks like a field, opens a
/// sheet with search instead of a dropdown, because the lists people pick
/// from (colleges, districts, companies) are long. Works in a [Form] via
/// [validator].
///
/// With [search], the sheet asks the server as the person types instead of
/// filtering [options] (for lists too long to download, like every college):
/// pass [selectedLabel] (kept from [onPicked]) so the field can name the
/// pick.
class MuSelectField extends StatelessWidget {
  /// A select field.
  const MuSelectField({
    required this.label,
    required this.options,
    required this.onChanged,
    this.value,
    this.hint = 'Select',
    this.help,
    this.error,
    this.validator,
    this.loading = false,
    this.enabled = true,
    this.allowOther = false,
    this.otherLabel = 'Not listed? Add it',
    this.otherValueLabel,
    this.search,
    this.selectedLabel,
    this.onPicked,
    super.key,
  });

  final String label;
  final List<MuOption> options;

  /// The chosen option's id, [muOtherOptionValue], or null.
  final String? value;

  /// The new id.
  final ValueChanged<String?> onChanged;

  /// Shown when nothing is chosen.
  final String hint;

  final String? help;

  /// An error from outside (the server).
  final String? error;

  final FormFieldValidator<String>? validator;

  /// Options still loading: a spinner, can't open.
  final bool loading;

  final bool enabled;

  /// Adds a "not listed" row at the end.
  final bool allowOther;
  final String otherLabel;

  /// What the field reads when "not listed" is chosen (the typed name).
  final String? otherValueLabel;

  /// Server search for the sheet (2+ characters, debounced); [options] is
  /// then unused.
  final Future<List<MuOption>> Function(String query)? search;

  /// The chosen option's name when it isn't in [options] (a [search] pick).
  final String? selectedLabel;

  /// The whole option picked (with its name), after [onChanged].
  final ValueChanged<MuOption>? onPicked;

  String? _labelFor(String? id) {
    if (id == null) return null;
    if (id == muOtherOptionValue) return otherValueLabel ?? otherLabel;
    for (final o in options) {
      if (o.id == id) return o.label;
    }
    return selectedLabel;
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;

    return FormField<String>(
      // Rebuild the field state when the value changes from outside.
      key: ValueKey('mu-select-$label-$value'),
      initialValue: value,
      validator: validator,
      builder: (field) {
        final chosen = _labelFor(field.value);
        final canOpen = enabled && !loading;

        Future<void> open() async {
          final picked = await showMuSheet<MuOption>(
            context,
            builder: (_) => _SelectSheet(
              title: label,
              options: options,
              selected: field.value,
              allowOther: allowOther,
              otherLabel: otherLabel,
              search: search,
            ),
          );
          if (picked != null) {
            field.didChange(picked.id);
            onChanged(picked.id);
            onPicked?.call(picked);
          }
        }

        return Semantics(
          button: true,
          label: '$label, ${chosen ?? hint}',
          excludeSemantics: true,
          onTap: canOpen ? open : null,
          child: MuFieldChrome(
            label: label,
            help: help,
            error: error ?? field.errorText,
            enabled: enabled,
            onTap: canOpen ? open : null,
            trailing: SizedBox.square(
              dimension: MuSizes.touchMin,
              child: Center(
                child: loading
                    ? SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: c.ink3,
                        ),
                      )
                    : Icon(LucideIcons.chevronDown, size: 20, color: c.ink3),
              ),
            ),
            child: Text(
              chosen ?? hint,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: mu.text.body.copyWith(
                fontSize: 16,
                color: chosen == null ? c.ink3 : c.ink,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SelectSheet extends StatefulWidget {
  const _SelectSheet({
    required this.title,
    required this.options,
    required this.selected,
    required this.allowOther,
    required this.otherLabel,
    this.search,
  });

  final String title;
  final List<MuOption> options;
  final String? selected;
  final bool allowOther;
  final String otherLabel;
  final Future<List<MuOption>> Function(String query)? search;

  @override
  State<_SelectSheet> createState() => _SelectSheetState();
}

class _SelectSheetState extends State<_SelectSheet> {
  String _query = '';

  // Server search (widget.search): the latest results, for _searched.
  Timer? _debounce;
  String _searched = '';
  List<MuOption> _found = const [];
  bool _searching = false;
  Object? _searchError;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onQuery(String v) {
    setState(() => _query = v);
    final search = widget.search;
    if (search == null) return;
    _debounce?.cancel();
    final q = v.trim();
    if (q.length < 2) {
      setState(() {
        _searched = '';
        _found = const [];
        _searching = false;
        _searchError = null;
      });
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 350), () async {
      if (q == _searched) return;
      setState(() {
        _searching = true;
        _searchError = null;
      });
      try {
        final found = await search(q);
        // A reply to an older query loses to the newer one.
        if (!mounted || _query.trim() != q) return;
        setState(() {
          _searched = q;
          _found = found;
          _searching = false;
        });
      } on Object catch (e) {
        if (!mounted || _query.trim() != q) return;
        setState(() {
          _searching = false;
          _searchError = e;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final remote = widget.search != null;
    final q = _query.trim().toLowerCase();
    final shown = remote
        ? _found
        : q.isEmpty
        ? widget.options
        : widget.options
              .where((o) => o.label.toLowerCase().contains(q))
              .toList();
    final searchable = remote || widget.options.length > 7;
    // In search mode, what to say instead of rows.
    final note = !remote
        ? (shown.isEmpty
              ? (q.isEmpty
                    ? 'Nothing listed yet.'
                    : 'Nothing matches "${_query.trim()}".')
              : null)
        : _query.trim().length < 2
        ? 'Type at least 2 letters to search.'
        : _searchError != null
        ? "Couldn't search. Check your connection and try again."
        : _searching && _found.isEmpty
        ? 'Searching…'
        : shown.isEmpty && _searched.isNotEmpty
        ? 'Nothing matches "${_query.trim()}".'
        : null;

    Widget row(String id, String text, {IconData? icon}) {
      final on = widget.selected == id;
      return Semantics(
        button: true,
        selected: on,
        label: text,
        excludeSemantics: true,
        onTap: () => Navigator.of(context).pop(MuOption(id, text)),
        child: InkWell(
          onTap: () => Navigator.of(context).pop(MuOption(id, text)),
          child: Container(
            constraints: const BoxConstraints(minHeight: 52),
            padding: const EdgeInsets.symmetric(
              horizontal: MuSpacing.space5,
              vertical: MuSpacing.space2,
            ),
            child: Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, size: MuSizes.iconSm, color: c.cobaltText),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: Text(
                    text,
                    style: mu.text.body.copyWith(
                      fontSize: 16,
                      color: icon != null ? c.cobaltText : c.ink,
                      fontWeight: on ? FontWeight.w700 : null,
                    ),
                  ),
                ),
                if (on) Icon(LucideIcons.check, size: 20, color: c.cobalt),
              ],
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: MediaQuery.sizeOf(context).height * (searchable ? 0.78 : 0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              MuSpacing.space5,
              0,
              MuSpacing.space5,
              MuSpacing.space3,
            ),
            child: Text(widget.title, style: mu.text.title2),
          ),
          if (searchable)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                MuSpacing.space5,
                0,
                MuSpacing.space5,
                MuSpacing.space2,
              ),
              child: MuSearchField(
                hint: 'Search ${widget.title.toLowerCase()}',
                autofocus: remote,
                onChanged: _onQuery,
              ),
            ),
          // Built as it scrolls: an option list can run to thousands.
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(
                bottom:
                    MuSpacing.space5 + MediaQuery.viewInsetsOf(context).bottom,
              ),
              itemCount:
                  (note != null ? 1 : shown.length) +
                  (widget.allowOther ? 1 : 0),
              itemBuilder: (context, i) {
                if (note != null && i == 0) {
                  return Padding(
                    padding: const EdgeInsets.all(MuSpacing.space5),
                    child: Text(
                      note,
                      style: mu.text.body.copyWith(color: c.ink3),
                    ),
                  );
                }
                final o = note != null ? null : shown.elementAtOrNull(i);
                if (o != null) return row(o.id, o.label);
                return row(
                  muOtherOptionValue,
                  widget.otherLabel,
                  icon: LucideIcons.plus,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
