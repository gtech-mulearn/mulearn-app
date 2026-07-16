import 'package:mulearn_app/features/profile/domain/entities/socials.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'socials_controller.g.dart';

@riverpod
class SocialsController extends _$SocialsController {
  @override
  Future<Socials> build() => ref.watch(profileRepositoryProvider).getSocials();

  Future<void> save(Socials socials) async {
    await ref.read(profileRepositoryProvider).updateSocials(socials);
    state = AsyncData(socials);
  }
}
