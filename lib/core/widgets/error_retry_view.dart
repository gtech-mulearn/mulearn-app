import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/widgets/mu_empty_state.dart';

/// Centered error state with a retry button — built on [MuEmptyState]
/// (rules.md §8). Fires a haptic once when the error first appears, since
/// this is the shared error-display surface for nearly every screen-level
/// fetch failure in the app.
class ErrorRetryView extends StatefulWidget {
  const ErrorRetryView({
    required this.error,
    required this.onRetry,
    super.key,
  });

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
    return MuEmptyState(
      icon: LucideIcons.alertCircle,
      title: 'Something went wrong',
      message: ApiException.messageFor(widget.error),
      actionLabel: 'Retry',
      onAction: widget.onRetry,
    );
  }
}
