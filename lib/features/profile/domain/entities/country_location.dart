import 'package:freezed_annotation/freezed_annotation.dart';

part 'country_location.freezed.dart';

/// A `{id, name}` country reference nested inside [StateLocation] — pure-Dart
/// domain entity (rules.md §2).
@freezed
abstract class CountryLocation with _$CountryLocation {
  const factory CountryLocation({
    required String id,
    required String name,
  }) = _CountryLocation;
}
