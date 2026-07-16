import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:mulearn_app/core/config/flavor_config.dart';
import 'package:mulearn_app/core/network/auth_interceptor.dart';
import 'package:mulearn_app/core/network/cache_config.dart';
import 'package:mulearn_app/core/network/session_event_bus.dart';
import 'package:mulearn_app/core/storage/cache_store_provider.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

BaseOptions _baseOptions() => BaseOptions(
      baseUrl: FlavorConfig.instance.apiBaseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      contentType: Headers.jsonContentType,
      // Envelope handling / error mapping is done in ApiEnvelope + ApiException,
      // so let Dio surface non-2xx as DioException as usual.
    );

Interceptor _logInterceptor() => LogInterceptor(
      requestHeader: false,
      responseHeader: false,
      logPrint: appLogger.d,
    );

/// Bare Dio used only for the token-refresh call and for retrying a request
/// after refresh — deliberately WITHOUT the auth interceptor, so refreshing
/// can't recurse (architecture §6b).
@Riverpod(keepAlive: true)
Dio refreshDio(Ref ref) {
  final dio = Dio(_baseOptions());
  if (FlavorConfig.instance.isDev) dio.interceptors.add(_logInterceptor());
  return dio;
}

/// The app's main Dio client.
///
/// Interceptor order matters (rules.md §3): cache is added **before** auth, so a
/// cache hit short-circuits before any token attach/refresh runs.
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio(_baseOptions());
  final store = ref.watch(cacheStoreProvider);

  dio.interceptors.add(
    DioCacheInterceptor(options: CacheConfig.base(store)),
  );
  dio.interceptors.add(
    AuthInterceptor(
      refreshDio: ref.watch(refreshDioProvider),
      tokenStorage: ref.watch(tokenStorageProvider),
      sessionEventBus: ref.watch(sessionEventBusProvider),
    ),
  );
  if (FlavorConfig.instance.isDev) dio.interceptors.add(_logInterceptor());

  return dio;
}
