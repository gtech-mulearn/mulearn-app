import 'package:freezed_annotation/freezed_annotation.dart';

part 'ig_impact_project.freezed.dart';

/// A project an interest group built (ImpactProjectSerializer).
@freezed
abstract class IgImpactProject with _$IgImpactProject {
  const factory IgImpactProject({
    required String id,
    required String title,
    String? description,
    String? image,
    @Default([]) List<IgProjectLink> links,
  }) = _IgImpactProject;
}

@freezed
abstract class IgProjectLink with _$IgProjectLink {
  const factory IgProjectLink({required String label, required String url}) = _IgProjectLink;
}
