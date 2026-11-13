/// Features that exist in the app but stay off until the backend can
/// support them safely.
abstract final class FeatureFlags {
  const FeatureFlags._();

  /// Issuing a verifiable credential needs the unauthenticated QSeverse proxy
  /// with client-chosen content today (SEC-04); hidden until the backend
  /// offers a server-side issue endpoint (spec §10). Viewing an issued one
  /// still works.
  static const bool vcIssuance = false;
}
