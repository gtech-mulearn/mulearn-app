/// A Riverpod retry policy that never retries.
///
/// Riverpod 3 retries a failing provider by default (up to 10 times, with
/// backoff), and while it retries the provider stays `AsyncLoading`, so the
/// screen shows a spinner for over half a minute instead of its error state.
/// Providers that read shared server state use this so a failure surfaces at
/// once; the screen's Retry/pull-to-refresh refetches the source.
Duration? noRetry(int retryCount, Object error) => null;
