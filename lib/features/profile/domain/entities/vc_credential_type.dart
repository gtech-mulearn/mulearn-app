/// The kind of Verifiable Credential issued for an achievement — pure-Dart
/// domain entity (rules.md §2).
enum VcCredentialType { badge, certificate, recognition }

/// The exact wire value the QSeverse integration expects — Dart enum names
/// are lowercase, the API uses PascalCase.
extension VcCredentialTypeApiValue on VcCredentialType {
  String get apiValue => switch (this) {
        VcCredentialType.badge => 'Badge',
        VcCredentialType.certificate => 'Certificate',
        VcCredentialType.recognition => 'Recognition',
      };

  static VcCredentialType fromApiValue(String value) => switch (value) {
        'Badge' => VcCredentialType.badge,
        'Certificate' => VcCredentialType.certificate,
        'Recognition' => VcCredentialType.recognition,
        _ => throw ArgumentError('Unknown VcCredentialType: $value'),
      };
}
