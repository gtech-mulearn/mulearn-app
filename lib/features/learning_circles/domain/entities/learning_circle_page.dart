import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/learning_circle.dart';

part 'learning_circle_page.freezed.dart';

@freezed
abstract class LearningCirclePage with _$LearningCirclePage {
  const factory LearningCirclePage({
    required List<LearningCircle> circles,
    required bool hasNext,
  }) = _LearningCirclePage;
}
