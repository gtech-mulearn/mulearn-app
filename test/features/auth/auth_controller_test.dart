import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mulearn_app/core/auth/app_auth_controller.dart';
import 'package:mulearn_app/core/session/session_actions.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/features/auth/data/datasources/apple_native_signin_datasource.dart';
import 'package:mulearn_app/features/auth/data/datasources/google_native_signin_datasource.dart';
import 'package:mulearn_app/features/auth/domain/entities/auth_session.dart';
import 'package:mulearn_app/features/auth/domain/entities/social_sign_in_outcome.dart';
import 'package:mulearn_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:mulearn_app/features/auth/presentation/providers/auth_controller.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockTokenStorage extends Mock implements TokenStorage {}

class MockGoogleNativeSignInDataSource extends Mock
    implements GoogleNativeSignInDataSource {}

class MockAppleNativeSignInDataSource extends Mock
    implements AppleNativeSignInDataSource {}

void main() {
  late MockAuthRepository repository;
  late MockTokenStorage tokenStorage;
  late MockGoogleNativeSignInDataSource googleSignIn;
  late MockAppleNativeSignInDataSource appleSignIn;

  setUp(() {
    repository = MockAuthRepository();
    tokenStorage = MockTokenStorage();
    googleSignIn = MockGoogleNativeSignInDataSource();
    appleSignIn = MockAppleNativeSignInDataSource();
    when(() => tokenStorage.hasSession()).thenAnswer((_) async => false);
  });

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(repository),
        tokenStorageProvider.overrideWithValue(tokenStorage),
        googleNativeSignInDataSourceProvider.overrideWithValue(googleSignIn),
        appleNativeSignInDataSourceProvider.overrideWithValue(appleSignIn),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('successful password sign-in flips app auth state to signed-in',
      () async {
    when(
      () => repository.signInWithPassword(
        emailOrMuid: any(named: 'emailOrMuid'),
        password: any(named: 'password'),
      ),
    ).thenAnswer(
      (_) async => const AuthSession(accessToken: 'a', refreshToken: 'r'),
    );

    final container = makeContainer();
    // Resolve initial (signed-out) state.
    expect(await container.read(appAuthControllerProvider.future), isFalse);

    await container
        .read(authControllerProvider.notifier)
        .signInWithPassword(emailOrMuid: 'ada@mulearn.org', password: 'secret');

    expect(container.read(authControllerProvider).hasError, isFalse);
    expect(container.read(appAuthControllerProvider).value, isTrue);
  });

  test('failed password sign-in surfaces error and stays signed-out',
      () async {
    when(
      () => repository.signInWithPassword(
        emailOrMuid: any(named: 'emailOrMuid'),
        password: any(named: 'password'),
      ),
    ).thenThrow(Exception('bad creds'));

    final container = makeContainer();
    expect(await container.read(appAuthControllerProvider.future), isFalse);

    await expectLater(
      container
          .read(authControllerProvider.notifier)
          .signInWithPassword(emailOrMuid: 'ada@mulearn.org', password: 'wrong'),
      throwsException,
    );

    expect(container.read(authControllerProvider).hasError, isTrue);
    expect(container.read(appAuthControllerProvider).value, isFalse);
  });

  test('successful OTP sign-in flips app auth state to signed-in', () async {
    when(
      () => repository.signInWithOtp(
        emailOrMuid: any(named: 'emailOrMuid'),
        otp: any(named: 'otp'),
      ),
    ).thenAnswer(
      (_) async => const AuthSession(accessToken: 'a', refreshToken: 'r'),
    );

    final container = makeContainer();
    expect(await container.read(appAuthControllerProvider.future), isFalse);

    await container
        .read(authControllerProvider.notifier)
        .signInWithOtp(emailOrMuid: 'ada@mulearn.org', otp: '1234');

    expect(container.read(authControllerProvider).hasError, isFalse);
    expect(container.read(appAuthControllerProvider).value, isTrue);
  });

  test('requestOtp propagates errors without touching app auth state',
      () async {
    when(
      () => repository.requestOtp(emailOrMuid: any(named: 'emailOrMuid')),
    ).thenThrow(Exception('rate limited'));

    final container = makeContainer();
    expect(await container.read(appAuthControllerProvider.future), isFalse);

    await expectLater(
      container
          .read(authControllerProvider.notifier)
          .requestOtp(emailOrMuid: 'ada@mulearn.org'),
      throwsException,
    );

    expect(container.read(authControllerProvider).hasError, isTrue);
    expect(container.read(appAuthControllerProvider).value, isFalse);
  });

  test('requestPasswordReset succeeds without touching app auth state',
      () async {
    when(
      () =>
          repository.requestPasswordReset(emailOrMuid: any(named: 'emailOrMuid')),
    ).thenAnswer((_) async {});

    final container = makeContainer();
    expect(await container.read(appAuthControllerProvider.future), isFalse);

    await container
        .read(authControllerProvider.notifier)
        .requestPasswordReset(emailOrMuid: 'ada@mulearn.org');

    expect(container.read(authControllerProvider).hasError, isFalse);
    expect(container.read(appAuthControllerProvider).value, isFalse);
  });

  test('sign-out delegates to the core session and flips app auth state', () async {
    final session = FakeSessionActions();
    final container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(repository),
        tokenStorageProvider.overrideWithValue(tokenStorage),
        sessionActionsProvider.overrideWith(() => session),
      ],
    );
    addTearDown(container.dispose);
    await container.read(appAuthControllerProvider.future);
    container.read(appAuthControllerProvider.notifier).setSignedIn();

    await container.read(authControllerProvider.notifier).signOut();

    expect(session.signOutCalls, 1);
    expect(container.read(appAuthControllerProvider).value, isFalse);
  });

  test('verifyResetToken succeeds without touching app auth state', () async {
    when(() => repository.verifyResetToken(any())).thenAnswer((_) async {});

    final container = makeContainer();
    await container.read(appAuthControllerProvider.future);

    await container
        .read(authControllerProvider.notifier)
        .verifyResetToken('some-token');

    expect(container.read(authControllerProvider).hasError, isFalse);
    expect(container.read(appAuthControllerProvider).value, isFalse);
  });

  test('resetPassword succeeds without touching app auth state', () async {
    when(
      () => repository.resetPassword(
        token: any(named: 'token'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async {});

    final container = makeContainer();
    await container.read(appAuthControllerProvider.future);

    await container.read(authControllerProvider.notifier).resetPassword(
          token: 'some-token',
          password: 'new-password',
        );

    expect(container.read(authControllerProvider).hasError, isFalse);
    expect(container.read(appAuthControllerProvider).value, isFalse);
  });

  test(
      'signInWithGoogle obtains a native ID token then exchanges it, '
      'flipping app auth state to signed-in', () async {
    when(() => googleSignIn.signIn()).thenAnswer((_) async => 'google-id-token');
    when(() => repository.signInWithGoogle(idToken: any(named: 'idToken')))
        .thenAnswer((_) async => const SocialSignedIn());

    final container = makeContainer();
    await container.read(appAuthControllerProvider.future);

    final outcome =
        await container.read(authControllerProvider.notifier).signInWithGoogle();

    expect(outcome, isA<SocialSignedIn>());
    verify(() => repository.signInWithGoogle(idToken: 'google-id-token'))
        .called(1);
    expect(container.read(authControllerProvider).hasError, isFalse);
    expect(container.read(appAuthControllerProvider).value, isTrue);
  });

  test('signInWithGoogle for an unknown email returns NeedsRegistration and stays signed out',
      () async {
    when(() => googleSignIn.signIn()).thenAnswer((_) async => 'google-id-token');
    when(() => repository.signInWithGoogle(idToken: any(named: 'idToken'))).thenAnswer(
      (_) async => const SocialNeedsRegistration(tempToken: 't', email: 'e@x.org', fullName: 'N'),
    );

    final container = makeContainer();
    await container.read(appAuthControllerProvider.future);

    final outcome =
        await container.read(authControllerProvider.notifier).signInWithGoogle();

    expect(outcome, isA<SocialNeedsRegistration>());
    expect(container.read(appAuthControllerProvider).value, isFalse);
  });

  test('signInWithGoogle propagates a cancelled native sign-in as an error',
      () async {
    when(() => googleSignIn.signIn())
        .thenThrow(Exception('Sign-in cancelled.'));

    final container = makeContainer();
    await container.read(appAuthControllerProvider.future);

    await expectLater(
      container.read(authControllerProvider.notifier).signInWithGoogle(),
      throwsException,
    );

    verifyNever(
      () => repository.signInWithGoogle(idToken: any(named: 'idToken')),
    );
    expect(container.read(appAuthControllerProvider).value, isFalse);
  });

  test(
      'signInWithApple obtains a native identity token then exchanges it, '
      'flipping app auth state to signed-in', () async {
    when(() => appleSignIn.signIn()).thenAnswer(
      (_) async => (identityToken: 'apple-identity-token', email: 'ada@icloud.com'),
    );
    when(
      () => repository.signInWithApple(
        identityToken: any(named: 'identityToken'),
      ),
    ).thenAnswer(
      (_) async => const AuthSession(accessToken: 'a', refreshToken: 'r'),
    );

    final container = makeContainer();
    await container.read(appAuthControllerProvider.future);

    await container.read(authControllerProvider.notifier).signInWithApple();

    verify(
      () => repository.signInWithApple(identityToken: 'apple-identity-token'),
    ).called(1);
    expect(container.read(appAuthControllerProvider).value, isTrue);
  });
}

/// Records sign-out calls; flips the router state like the real one.
class FakeSessionActions extends SessionActions {
  int signOutCalls = 0;

  @override
  Future<void> signOut() async {
    signOutCalls++;
    ref.read(appAuthControllerProvider.notifier).setSignedOut();
  }
}
