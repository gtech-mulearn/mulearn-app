import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// The TextField's search variant: a filled pill with a leading search icon
/// and a clear button once something is typed. No outline at rest; a cobalt
/// ring while focused.
class MuSearchField extends StatefulWidget {
  /// A search field; [onChanged] gets every edit, clearing included.
  const MuSearchField({required this.hint, required this.onChanged, this.controller, super.key});

  /// Placeholder, e.g. "Search title, hashtag, IG…".
  final String hint;

  /// Called with the current query.
  final ValueChanged<String> onChanged;

  /// Optional controller; the field makes its own otherwise.
  final TextEditingController? controller;

  @override
  State<MuSearchField> createState() => _MuSearchFieldState();
}

class _MuSearchFieldState extends State<MuSearchField> {
  late final TextEditingController _controller = widget.controller ?? TextEditingController();
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_rebuild);
    _focus.addListener(_rebuild);
  }

  void _rebuild() => setState(() {});

  @override
  void dispose() {
    _controller.removeListener(_rebuild);
    if (widget.controller == null) _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    widget.onChanged('');
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final focused = _focus.hasFocus;
    final filled = _controller.text.isNotEmpty;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      height: MuSizes.touchMin,
      decoration: BoxDecoration(
        color: focused ? c.surface : c.surfaceSunk,
        borderRadius: BorderRadius.circular(MuRadii.round),
        border: Border.all(color: focused ? c.cobalt : c.surfaceSunk, width: 2),
      ),
      child: Row(
        children: [
          const SizedBox(width: MuSpacing.space4),
          Icon(LucideIcons.search, size: MuSizes.iconSm + 2, color: c.ink3),
          const SizedBox(width: MuSpacing.space2),
          Expanded(
            // Optical centring: Plus Jakarta's ascender is taller than its
            // descender, so glyphs sit 2.5dp above the line's centre
            // (measured on device). Nudge the line down to meet the icon.
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: TextField(
                controller: _controller,
                focusNode: _focus,
                onChanged: widget.onChanged,
                textInputAction: TextInputAction.search,
                textAlignVertical: TextAlignVertical.center,
                // A single tight line so text and placeholder sit on the
                // field's centre line, level with the search icon.
                style: mu.text.body.copyWith(
                  fontSize: 16,
                  height: 1.25,
                  leadingDistribution: TextLeadingDistribution.even,
                  color: c.ink,
                ),
                strutStyle: const StrutStyle(
                  fontSize: 16,
                  height: 1.25,
                  leadingDistribution: TextLeadingDistribution.even,
                  forceStrutHeight: true,
                ),
                cursorColor: c.cobalt,
                decoration: InputDecoration(
                  isCollapsed: true,
                  // Explicit: the app theme's input padding must not leak in.
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  filled: false,
                  hintText: widget.hint,
                  hintStyle: mu.text.body.copyWith(
                    fontSize: 16,
                    height: 1.25,
                    leadingDistribution: TextLeadingDistribution.even,
                    color: c.ink3,
                  ),
                  hintMaxLines: 1,
                ),
              ),
            ),
          ),
          if (filled)
            Semantics(
              button: true,
              label: 'Clear search',
              excludeSemantics: true,
              onTap: _clear,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _clear,
                child: SizedBox(
                  width: MuSizes.touchMin,
                  height: MuSizes.touchMin,
                  child: Center(
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(color: c.ink3, shape: BoxShape.circle),
                      child: Icon(LucideIcons.x, size: 14, color: c.surface),
                    ),
                  ),
                ),
              ),
            )
          else
            const SizedBox(width: MuSpacing.space4),
        ],
      ),
    );
  }
}
