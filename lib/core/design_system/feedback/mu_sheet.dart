import 'package:flutter/material.dart';
import 'package:mulearn_app/core/design_system/input/mu_button.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// Opens a modal bottom sheet: `surface`, `radius-panel` top corners, a
/// grabber, the `scrim` behind. Drag down, tap the scrim or go back to close.
///
/// [builder] provides the content; use [MuSheetBody] for the standard
/// eyebrow / title / body / actions layout.
Future<T?> showMuSheet<T>(BuildContext context, {required WidgetBuilder builder, bool dismissible = true}) {
  final mu = context.mu;
  return showModalBottomSheet<T>(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    useSafeArea: true,
    isDismissible: dismissible,
    enableDrag: dismissible,
    backgroundColor: mu.colors.surface,
    barrierColor: mu.colors.scrim,
    elevation: 0,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(MuRadii.panel))),
    clipBehavior: Clip.antiAlias,
    sheetAnimationStyle: const AnimationStyle(
      duration: Duration(milliseconds: 380),
      reverseDuration: Duration(milliseconds: 260),
    ),
    builder: (context) => _SheetFrame(child: builder(context)),
  );
}

class _SheetFrame extends StatelessWidget {
  const _SheetFrame({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final c = context.mu.colors;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom + MediaQuery.paddingOf(context).bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 10, bottom: MuSpacing.space4),
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: c.lineStrong.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(MuRadii.round),
              ),
            ),
          ),
          Flexible(child: child),
        ],
      ),
    );
  }
}

/// The standard sheet content: eyebrow, title, body, then actions stacked
/// full width (primary first).
class MuSheetBody extends StatelessWidget {
  /// Sheet content.
  const MuSheetBody({required this.title, this.eyebrow, this.body, this.actions = const [], super.key});

  /// Small capitals above the title ("ONE STEP").
  final String? eyebrow;

  /// What this sheet is for ("Sign in to register for IoT Build Night").
  final String title;

  /// One or two sentences.
  final String? body;

  /// Buttons, primary first.
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    return Padding(
      padding: const EdgeInsets.fromLTRB(MuSpacing.space5, 0, MuSpacing.space5, MuSpacing.space6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (eyebrow != null) ...[Text(eyebrow!.toUpperCase(), style: mu.text.eyebrow), const SizedBox(height: 6)],
          Semantics(header: true, child: Text(title, style: mu.text.title2)),
          if (body != null) ...[
            const SizedBox(height: MuSpacing.space2),
            Text(body!, style: mu.text.body.copyWith(color: mu.colors.ink2)),
          ],
          if (actions.isNotEmpty) ...[
            const SizedBox(height: MuSpacing.space5),
            for (var i = 0; i < actions.length; i++) ...[
              if (i > 0) const SizedBox(height: MuSpacing.space2),
              actions[i],
            ],
          ],
        ],
      ),
    );
  }
}

/// Confirms an odd or irreversible action with context. Sits low (thumb
/// reach), safe choice on the left. Destructive confirms don't close on a
/// scrim tap. Resolves to `true` only when confirmed.
Future<bool> showMuConfirm(
  BuildContext context, {
  required String title,
  required String confirmLabel,
  String? body,
  String cancelLabel = 'Cancel',
  bool destructive = false,
}) async {
  final mu = context.mu;
  final result = await showGeneralDialog<bool>(
    context: context,
    barrierDismissible: !destructive,
    barrierLabel: cancelLabel,
    barrierColor: mu.colors.scrim,
    transitionDuration: const Duration(milliseconds: 280),
    pageBuilder: (context, _, _) => _ConfirmDialog(
      title: title,
      body: body,
      confirmLabel: confirmLabel,
      cancelLabel: cancelLabel,
      destructive: destructive,
    ),
    transitionBuilder: (context, animation, _, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic, reverseCurve: Curves.easeInCubic);
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          // Same path in and out: from below.
          position: Tween(begin: const Offset(0, 0.12), end: Offset.zero).animate(curved),
          child: child,
        ),
      );
    },
  );
  return result ?? false;
}

class _ConfirmDialog extends StatelessWidget {
  const _ConfirmDialog({
    required this.title,
    required this.body,
    required this.confirmLabel,
    required this.cancelLabel,
    required this.destructive,
  });

  final String title;
  final String? body;
  final String confirmLabel;
  final String cancelLabel;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Padding(
            padding: const EdgeInsets.all(MuSpacing.space4),
            child: Material(
              color: mu.colors.surface,
              borderRadius: BorderRadius.circular(MuRadii.panel),
              child: Padding(
                padding: const EdgeInsets.all(MuSpacing.space6),
                child: Semantics(
                  scopesRoute: true,
                  explicitChildNodes: true,
                  namesRoute: true,
                  label: title,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: mu.text.title2),
                      if (body != null) ...[
                        const SizedBox(height: MuSpacing.space2),
                        Text(body!, style: mu.text.body.copyWith(color: mu.colors.ink2)),
                      ],
                      const SizedBox(height: MuSpacing.space5),
                      Row(
                        children: [
                          Expanded(
                            child: MuButton(
                              label: cancelLabel,
                              variant: MuButtonVariant.outline,
                              block: true,
                              onPressed: () => Navigator.of(context).pop(false),
                            ),
                          ),
                          const SizedBox(width: MuSpacing.space3),
                          Expanded(
                            child: MuButton(
                              label: confirmLabel,
                              variant: destructive ? MuButtonVariant.danger : MuButtonVariant.cobalt,
                              block: true,
                              onPressed: () => Navigator.of(context).pop(true),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
