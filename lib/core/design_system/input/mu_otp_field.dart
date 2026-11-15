import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// A one-time code (artifact TextField → OTP): [length] cells of 48×60 with
/// `display` digits, the next cell ringed in cobalt. One hidden text input
/// carries the code, so pasting or the keyboard's SMS suggestion fills every
/// cell at once; [onCompleted] fires when the last digit lands.
class MuOtpField extends StatefulWidget {
  /// An OTP field.
  const MuOtpField({
    required this.label,
    required this.onCompleted,
    this.length = 6,
    this.onChanged,
    this.error,
    this.enabled = true,
    this.autofocus = true,
    this.controller,
    super.key,
  });

  /// "Code sent to aysha@cet.ac.in".
  final String label;

  final int length;

  /// The whole code, once every cell is filled.
  final ValueChanged<String> onCompleted;

  final ValueChanged<String>? onChanged;

  /// Wrong or expired code; clears nothing.
  final String? error;

  final bool enabled;
  final bool autofocus;
  final TextEditingController? controller;

  @override
  State<MuOtpField> createState() => _MuOtpFieldState();
}

class _MuOtpFieldState extends State<MuOtpField> {
  late final TextEditingController _controller =
      widget.controller ?? TextEditingController();
  final _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focus.dispose();
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  void _changed(String value) {
    setState(() {});
    widget.onChanged?.call(value);
    if (value.length == widget.length) widget.onCompleted(value);
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final code = _controller.text;
    final hasError = widget.error != null && widget.error!.isNotEmpty;

    final cells = Row(
      children: [
        for (var i = 0; i < widget.length; i++) ...[
          if (i > 0) const SizedBox(width: MuSpacing.space2),
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 140),
              height: 60,
              constraints: const BoxConstraints(maxWidth: 48),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: hasError
                    ? c.dangerTint
                    : (i == code.length && _focus.hasFocus
                          ? c.surface
                          : c.surfaceSunk),
                borderRadius: BorderRadius.circular(MuRadii.control),
                border: Border.all(
                  width: 2,
                  color: hasError
                      ? c.danger
                      : (i == code.length && _focus.hasFocus
                            ? c.cobalt
                            : c.surfaceSunk),
                ),
              ),
              child: Text(
                i < code.length ? code[i] : '',
                style: mu.text.display.copyWith(
                  fontSize: 24,
                  height: 1,
                  color: c.ink,
                ),
              ),
            ),
          ),
        ],
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.label, style: mu.text.label.copyWith(color: c.ink2)),
        const SizedBox(height: 6),
        Stack(
          children: [
            ExcludeSemantics(child: cells),
            // The real input sits over the cells, invisible, so taps focus
            // it and the platform can paste or autofill the whole code.
            Positioned.fill(
              child: Opacity(
                opacity: 0,
                child: TextField(
                  controller: _controller,
                  focusNode: _focus,
                  enabled: widget.enabled,
                  autofocus: widget.autofocus,
                  keyboardType: TextInputType.number,
                  autofillHints: const [AutofillHints.oneTimeCode],
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(widget.length),
                  ],
                  showCursor: false,
                  enableInteractiveSelection: false,
                  onChanged: _changed,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    counterText: '',
                    semanticCounterText: '',
                    labelText: widget.label,
                  ),
                ),
              ),
            ),
          ],
        ),
        if (hasError) ...[
          const SizedBox(height: 6),
          Semantics(
            liveRegion: true,
            child: Row(
              children: [
                Icon(LucideIcons.alertCircle, size: 14, color: c.danger),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    widget.error!,
                    style: mu.text.caption.copyWith(
                      color: c.danger,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
