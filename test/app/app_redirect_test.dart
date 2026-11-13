import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/app/app_redirect.dart';

/// The router's auth guard. Deep links (the Discord App Link) keep their
/// target through the splash screen and sign-in.
void main() {
  const signedIn = AsyncData(true);
  const signedOut = AsyncData(false);
  const loading = AsyncLoading<bool>();
  Uri u(String s) => Uri.parse(s);
  String fromOf(String target) => Uri.encodeQueryComponent(target);

  test('Settings screens are reachable signed in (Task 3 regression)', () {
    expect(appRedirect(auth: signedIn, uri: u('/settings')), isNull);
    expect(appRedirect(auth: signedIn, uri: u('/settings/password')), isNull);
  });

  test('the Discord link is reachable signed in', () {
    expect(appRedirect(auth: signedIn, uri: u('/dashboard/connect-discord?code=abc')), isNull);
  });

  test('a signed-out link resumes after sign-in', () {
    final toSignIn = appRedirect(auth: signedOut, uri: u('/dashboard/connect-discord?code=abc'));
    expect(toSignIn, '/sign-in?from=${fromOf('/dashboard/connect-discord?code=abc')}');

    final back = appRedirect(auth: signedIn, uri: u(toSignIn!));
    expect(back, '/dashboard/connect-discord?code=abc');
  });

  test('a link that arrives while the session loads keeps its target', () {
    final toSplash = appRedirect(auth: loading, uri: u('/dashboard/connect-discord?code=abc'));
    expect(toSplash, '/splash?from=${fromOf('/dashboard/connect-discord?code=abc')}');
    expect(appRedirect(auth: loading, uri: u(toSplash!)), isNull, reason: 'stays on splash while loading');

    expect(appRedirect(auth: signedIn, uri: u(toSplash)), '/dashboard/connect-discord?code=abc');
    expect(appRedirect(auth: signedOut, uri: u(toSplash)),
        '/sign-in?from=${fromOf('/dashboard/connect-discord?code=abc')}');
  });

  test('without a target, sign-in and splash still lead home', () {
    expect(appRedirect(auth: signedIn, uri: u('/sign-in')), '/home');
    expect(appRedirect(auth: signedIn, uri: u('/splash')), '/home');
    expect(appRedirect(auth: loading, uri: u('/splash')), isNull);
    expect(appRedirect(auth: signedOut, uri: u('/home')), '/sign-in?from=${fromOf('/home')}');
  });

  test("a 'from' that leaves the app or isn't a signed-in screen is ignored", () {
    expect(appRedirect(auth: signedIn, uri: u('/sign-in?from=${fromOf('//evil.example/x')}')), '/home');
    expect(appRedirect(auth: signedIn, uri: u('/sign-in?from=${fromOf('https://evil.example')}')), '/home');
    expect(appRedirect(auth: signedIn, uri: u('/sign-in?from=${fromOf('/sign-in')}')), '/home');
  });

  test('existing rules are unchanged', () {
    expect(appRedirect(auth: signedIn, uri: u('/events/e1')), isNull);
    expect(appRedirect(auth: signedIn, uri: u('/register')), '/home');
    expect(appRedirect(auth: signedOut, uri: u('/register')), isNull);
  });
}
