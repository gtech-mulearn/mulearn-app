import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/input/mu_button.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';
import 'package:mulearn_app/core/network/api_exception.dart';

/// A failed load: what went wrong in plain words and a Retry, in the design
/// system's colours (so it reads in light and dark).
class ErrorRetryView extends StatefulWidget {
  const ErrorRetryView({required this.error, required this.onRetry, super.key});

  final Object error;
  final VoidCallback onRetry;

  @override
  State<ErrorRetryView> createState() => _ErrorRetryViewState();
}

class _ErrorRetryViewState extends State<ErrorRetryView> {
  @override
  void initState() {
    super.initState();
    HapticFeedback.heavyImpact();
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(MuSpacing.space6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: c.dangerTint,
                shape: BoxShape.circle,
              ),
              child: Icon(LucideIcons.alertCircle, size: 28, color: c.danger),
            ),
            const SizedBox(height: MuSpacing.space4),
            Text(
              'Something went wrong',
              style: mu.text.title2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: MuSpacing.space2),
            Text(
              ApiException.messageFor(widget.error),
              style: mu.text.body.copyWith(color: c.ink2),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: MuSpacing.space5),
            MuButton(
              label: 'Retry',
              variant: MuButtonVariant.outline,
              onPressed: widget.onRetry,
            ),
          ],
        ),
      ),
    );
  }
}
