import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:mulearn_app/features/profile/presentation/providers/cover_photo_controller.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_image_controller.dart';

import '../../support/fake_http_adapter.dart';

const _profilePath = '/api/v1/dashboard/user/profile/update/';
const _coverPath = '/api/v1/dashboard/profile/cover-pic/';

/// Profile and cover photo uploads. The backend (`UserProfilePictureView`,
/// `UserProfileCoverView`) refuses a file whose content type isn't
/// `image/*`, which is what `MultipartFile.fromBytes` sends by default, so
/// every upload used to fail.
void main() {
  final jpeg = [0xFF, 0xD8, 0xFF, 0xE0, 1, 2, 3];
  final png = [0x89, 0x50, 0x4E, 0x47, 1, 2, 3];
  Map<String, dynamic> ok(Object? response) => {
    'hasError': false,
    'statusCode': 200,
    'message': {'general': <String>[]},
    'response': response,
  };

  MultipartFile sentFile(RequestOptions r) =>
      (r.data as FormData).files.single.value;

  test('the profile photo goes up as an image, with the user id', () async {
    final adapter = FakeHttpAdapter({
      'POST $_profilePath': (_) =>
          FakeResponse(200, ok({'user_id': 'u1', 'profile_pic': 'x'})),
    });
    await ProfileRemoteDataSource(
      fakeDio(adapter),
    ).updateProfileImage(bytes: jpeg, filename: 'profile.jpg', userId: 'u1');

    final r = adapter.requests.single;
    expect((r.data as FormData).files.single.key, 'profile');
    expect(sentFile(r).contentType.toString(), 'image/jpeg');
    expect(
      (r.data as FormData).fields,
      contains(
        predicate<MapEntry<String, String>>(
          (e) => e.key == 'user_id' && e.value == 'u1',
        ),
      ),
    );
  });

  test('the cover goes up as an image too; a PNG is sent as one', () async {
    final adapter = FakeHttpAdapter({
      'POST $_coverPath': (_) => FakeResponse(200, ok({'cover_pic': 'x'})),
    });
    await ProfileRemoteDataSource(
      fakeDio(adapter),
    ).uploadCoverPic(png, 'cover.png');

    expect(
      (adapter.requests.single.data as FormData).files.single.key,
      'cover',
    );
    expect(
      sentFile(adapter.requests.single).contentType.toString(),
      'image/png',
    );
  });

  test("the proxy's 413 becomes a message a person can act on", () async {
    final adapter = FakeHttpAdapter({
      'POST $_coverPath': (_) =>
          const FakeResponse(413, '<html>Request Entity Too Large</html>'),
    });
    expect(
      () => ProfileRemoteDataSource(
        fakeDio(adapter),
      ).uploadCoverPic(jpeg, 'cover.jpg'),
      throwsA(
        isA<ApiException>().having(
          (e) => e.message,
          'message',
          contains('under 5 MB'),
        ),
      ),
    );
  });

  test(
    'a photo over 5 MB is refused before any upload, for both photos',
    () async {
      final adapter = FakeHttpAdapter({});
      final container = ProviderContainer(
        retry: (_, _) => null,
        overrides: [dioProvider.overrideWithValue(fakeDio(adapter))],
      );
      addTearDown(container.dispose);
      // The profile header watches both; without a listener an auto-disposed
      // controller would reset between reads.
      container
        ..listen(profileImageControllerProvider, (_, _) {})
        ..listen(coverPhotoControllerProvider, (_, _) {});
      await container.read(profileImageControllerProvider.future);
      await container.read(coverPhotoControllerProvider.future);
      final big = List<int>.filled(5 * 1024 * 1024 + 1, 0);

      await container
          .read(profileImageControllerProvider.notifier)
          .upload(big, 'profile.jpg');
      expect(
        ApiException.messageFor(
          container.read(profileImageControllerProvider).error!,
        ),
        'Profile photo must be under 5 MB.',
      );
      await container
          .read(coverPhotoControllerProvider.notifier)
          .upload(big, 'cover.jpg');
      expect(
        ApiException.messageFor(
          container.read(coverPhotoControllerProvider).error!,
        ),
        'Cover photo must be under 5 MB.',
      );
      expect(adapter.requests, isEmpty);
    },
  );
}
