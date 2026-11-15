import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';

/// The frame every auth screen shares (artifact Screen patterns →
/// Authentication): back, an eyebrow naming the intent, a mixed-weight
/// headline ([light] then [bold]), a lead line, then the content. Sign-up
/// steps add one progress line at the top ([step] of [steps]) and keep
/// their action ([bottom]) pinned above the keyboard.
class AuthPage extends StatelessWidget {
  const AuthPage({
    required this.eyebrow,
    required this.light,
    required this.bold,
    required this.children,
    this.lead,
    this.step,
    this.steps,
    this.bottom,
    this.onBack,
    super.key,
  });

  final String eyebrow;
  final String light;
  final String bold;
  final String? lead;
  final List<Widget> children;

  /// 1-based step and total, for the sign-up progress line.
  final int? step;
  final int? steps;

  /// Pinned at the bottom (a Continue button).
  final Widget? bottom;

  /// Back; defaults to popping when there is somewhere to go.
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final canPop = onBack != null || (ModalRoute.of(context)?.canPop ?? false);

    return Scaffold(
      backgroundColor: c.chalk,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                MuSpacing.space3,
                MuSpacing.space2,
                MuSpacing.space5,
                0,
              ),
              child: Row(
                children: [
                  if (canPop)
                    MuIconButton(
                      icon: LucideIcons.arrowLeft,
                      tooltip: 'Back',
                      onPressed:
                          onBack ?? () => Navigator.of(context).maybePop(),
                    )
                  else
                    const SizedBox(height: MuSizes.touchMin),
                  if (step != null && steps != null) ...[
                    const SizedBox(width: MuSpacing.space3),
                    Expanded(
                      child: Semantics(
                        label: 'Step $step of $steps',
                        child: ExcludeSemantics(
                          child: Row(
                            children: [
                              for (var i = 1; i <= steps!; i++) ...[
                                if (i > 1) const SizedBox(width: 5),
                                Expanded(
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: i <= step! ? c.cobalt : c.line,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  MuSpacing.space5,
                  MuSpacing.space5,
                  MuSpacing.space5,
                  MuSpacing.space8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      eyebrow.toUpperCase(),
                      style: mu.text.eyebrow.copyWith(color: c.ink3),
                    ),
                    const SizedBox(height: MuSpacing.space2),
                    Semantics(
                      header: true,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: light,
                              style: mu.text.displayLight.copyWith(
                                fontSize: 36,
                              ),
                            ),
                            TextSpan(
                              text: bold,
                              style: mu.text.display.copyWith(fontSize: 36),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (lead != null) ...[
                      const SizedBox(height: MuSpacing.space2),
                      Text(
                        lead!,
                        style: mu.text.bodyLg.copyWith(
                          fontSize: 16,
                          color: c.ink2,
                        ),
                      ),
                    ],
                    const SizedBox(height: MuSpacing.space6),
                    ...children,
                  ],
                ),
              ),
            ),
            if (bottom != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  MuSpacing.space5,
                  MuSpacing.space2,
                  MuSpacing.space5,
                  MuSpacing.space4,
                ),
                child: bottom,
              ),
          ],
        ),
      ),
    );
  }
}
