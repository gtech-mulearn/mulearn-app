import 'package:flutter/material.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';

/// Pull-to-refresh, the same on every screen (UX-05): the indicator stays
/// until [onRefresh]'s refetch finishes, and a failure is a toast with the
/// backend's message — the screen keeps what it already shows (pair it with
/// `AsyncValue.when(skipError: true, ...)`).
class MuRefresh extends StatelessWidget {
  const MuRefresh({required this.onRefresh, required this.child, super.key});

  /// Await the real refetch here, e.g. `ref.refresh(provider.future)`.
  final Future<void> Function() onRefresh;
  final Widget child;

  @override
  Widget build(BuildContext context) => RefreshIndicator(
        onRefresh: () async {
          try {
            await onRefresh();
          } on Object catch (e) {
            if (context.mounted) {
              MuToast.show(context, message: ApiException.messageFor(e), type: MuToastType.error);
            }
          }
        },
        child: child,
      );
}
