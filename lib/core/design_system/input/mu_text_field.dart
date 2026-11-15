import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/input/mu_field_chrome.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// A filled text field (artifact TextField → Text): label above, 56 tall,
/// `surface-sunk` at rest, `surface` with a cobalt ring when focused, a
/// danger ring and tint with a how-to-fix message on error, help below.
///
/// Works inside a [Form]: [validator] runs on submit, on blur once the
/// person has typed, and on every change once an error is showing. Never
/// clears what was typed. [error] shows a server-side error (a DRF field
/// error) until the text changes.
class MuTextField extends StatefulWidget {
  /// A text field.
  const MuTextField({
    required this.label,
    this.controller,
    this.initialValue,
    this.hint,
    this.help,
    this.error,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.autofillHints,
    this.inputFormatters,
    this.obscure = false,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.focusNode,
    this.trailing,
    super.key,
  });

  /// Field label, shown above ("Email").
  final String label;

  /// Optional controller; the field owns one otherwise.
  final TextEditingController? controller;

  /// Starting text when there is no [controller].
  final String? initialValue;

  /// Placeholder.
  final String? hint;

  /// Help line under the field, hidden while an error shows.
  final String? help;

  /// An error from outside (the server); shown until the text changes.
  final String? error;

  /// Form validation; return a sentence saying how to fix it.
  final FormFieldValidator<String>? validator;

  /// Every edit.
  final ValueChanged<String>? onChanged;

  /// The keyboard's action key.
  final ValueChanged<String>? onSubmitted;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final Iterable<String>? autofillHints;
  final List<TextInputFormatter>? inputFormatters;

  /// A password: dots, with a show/hide toggle.
  final bool obscure;

  final bool enabled;

  /// Read-only: no fill, `ink-2` text.
  final bool readOnly;

  final bool autofocus;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final FocusNode? focusNode;

  /// A trailing widget inside the field (a unit, a small button).
  final Widget? trailing;

  @override
  State<MuTextField> createState() => _MuTextFieldState();
}

class _MuTextFieldState extends State<MuTextField> {
  late final TextEditingController _controller = widget.controller ?? TextEditingController(text: widget.initialValue);
  late final FocusNode _focus = widget.focusNode ?? FocusNode();
  final _fieldKey = GlobalKey<FormFieldState<String>>();
  bool _hidden = true;
  bool _edited = false;
  String? _serverError;

  @override
  void initState() {
    super.initState();
    _serverError = widget.error;
    _focus.addListener(_onFocus);
  }

  @override
  void didUpdateWidget(MuTextField old) {
    super.didUpdateWidget(old);
    if (widget.error != old.error) _serverError = widget.error;
  }

  void _onFocus() {
    // Validate on blur, once there is something the person typed.
    if (!_focus.hasFocus && _edited) _fieldKey.currentState?.validate();
    setState(() {});
  }

  @override
  void dispose() {
    _focus.removeListener(_onFocus);
    if (widget.focusNode == null) _focus.dispose();
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  void _changed(String value, FormFieldState<String> field) {
    _edited = true;
    field.didChange(value);
    if (field.hasError) field.validate();
    if (_serverError != null) setState(() => _serverError = null);
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;

    return FormField<String>(
      key: _fieldKey,
      initialValue: _controller.text,
      validator: widget.validator,
      enabled: widget.enabled,
      builder: (field) {
        final error = _serverError ?? field.errorText;
        final textStyle = mu.text.body.copyWith(
          fontSize: 16,
          height: 1.375,
          color: widget.readOnly ? c.ink2 : (widget.enabled ? c.ink : c.ink3),
        );
        final multiline = widget.maxLines > 1 || (widget.minLines ?? 1) > 1;
        final input = TextField(
          controller: _controller,
          focusNode: _focus,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          autofocus: widget.autofocus,
          obscureText: widget.obscure && _hidden,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          textCapitalization: widget.textCapitalization,
          autofillHints: widget.autofillHints,
          inputFormatters: widget.inputFormatters,
          maxLines: widget.obscure ? 1 : widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          style: textStyle,
          cursorColor: c.cobalt,
          onChanged: (v) => _changed(v, field),
          onSubmitted: widget.onSubmitted,
          decoration: InputDecoration(
            isCollapsed: true,
            filled: false,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            counterText: '',
            hintText: widget.hint,
            hintStyle: textStyle.copyWith(color: c.ink3),
          ),
        );

        return MuFieldChrome(
          label: widget.label,
          help: widget.help,
          error: error,
          focused: _focus.hasFocus,
          readOnly: widget.readOnly,
          enabled: widget.enabled,
          multiline: multiline,
          onTap: widget.enabled ? _focus.requestFocus : null,
          trailing: widget.obscure
              ? Semantics(
                  button: true,
                  label: _hidden ? 'Show password' : 'Hide password',
                  excludeSemantics: true,
                  onTap: () => setState(() => _hidden = !_hidden),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => setState(() => _hidden = !_hidden),
                    child: SizedBox.square(
                      dimension: MuSizes.touchMin,
                      child: Icon(_hidden ? LucideIcons.eye : LucideIcons.eyeOff, size: 20, color: c.ink3),
                    ),
                  ),
                )
              : widget.trailing,
          child: input,
        );
      },
    );
  }
}
