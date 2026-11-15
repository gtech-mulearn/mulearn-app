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

  String? _labelFor(String? id) {
    if (id == null) return null;
    if (id == muOtherOptionValue) return otherValueLabel ?? otherLabel;
    for (final o in options) {
      if (o.id == id) return o.label;
    }
    return null;
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
          final picked = await showMuSheet<String>(
            context,
            builder: (_) => _SelectSheet(
              title: label,
              options: options,
              selected: field.value,
              allowOther: allowOther,
              otherLabel: otherLabel,
            ),
          );
          if (picked != null) {
            field.didChange(picked);
            onChanged(picked);
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
  });

  final String title;
  final List<MuOption> options;
  final String? selected;
  final bool allowOther;
  final String otherLabel;

  @override
  State<_SelectSheet> createState() => _SelectSheetState();
}

class _SelectSheetState extends State<_SelectSheet> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final q = _query.trim().toLowerCase();
    final shown = q.isEmpty
        ? widget.options
        : widget.options
              .where((o) => o.label.toLowerCase().contains(q))
              .toList();
    final searchable = widget.options.length > 7;

    Widget row(String id, String text, {IconData? icon}) {
      final on = widget.selected == id;
      return Semantics(
        button: true,
        selected: on,
        label: text,
        excludeSemantics: true,
        onTap: () => Navigator.of(context).pop(id),
        child: InkWell(
          onTap: () => Navigator.of(context).pop(id),
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
                onChanged: (v) => setState(() => _query = v),
              ),
            ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(
                bottom:
                    MuSpacing.space5 + MediaQuery.viewInsetsOf(context).bottom,
              ),
              children: [
                if (shown.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(MuSpacing.space5),
                    child: Text(
                      'Nothing matches "${_query.trim()}".',
                      style: mu.text.body.copyWith(color: c.ink3),
                    ),
                  ),
                for (final o in shown) row(o.id, o.label),
                if (widget.allowOther)
                  row(
                    muOtherOptionValue,
                    widget.otherLabel,
                    icon: LucideIcons.plus,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
