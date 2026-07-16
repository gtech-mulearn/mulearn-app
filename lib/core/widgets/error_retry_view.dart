
import 'package:flutter/material.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';

/// Simple centered error state with a retry button (build prompt §4b — keep the
/// error state minimal for this pass).
class ErrorRetryView extends StatelessWidget {
  const ErrorRetryView({
    required this.error,
    required this.onRetry,
    super.key,
  });


  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final message = ApiException.messageFor(error);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: MulearnColors.gray600),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
