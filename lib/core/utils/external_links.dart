import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'external_links.g.dart';

/// Opens a link outside the app (browser, mail app).
typedef OpenExternal = Future<bool> Function(Uri uri);

/// The app's way to open external links; tests override it.
@Riverpod(keepAlive: true)
OpenExternal openExternal(Ref ref) => (uri) => launchUrl(uri, mode: LaunchMode.externalApplication);
