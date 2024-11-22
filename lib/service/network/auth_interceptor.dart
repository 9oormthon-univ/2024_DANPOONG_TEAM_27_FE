// 토큰이 만료 되었는지 확인 하는 과정을 거치는 interceptor

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../app/app_service.dart';
import '../storage/storage_key.dart';
import '../storage/storage_service.dart';
import 'dio_service.dart';
import 'refresh_token_interceptor.dart';

final Provider<AuthInterceptor> authInterceptorProvider =
    Provider<AuthInterceptor>(
  (ProviderRef<AuthInterceptor> ref) => AuthInterceptor(
    storageService: ref.watch(storageServiceProvider),
    refreshTokenInterceptor: ref.watch(refreshTokenInterceptorProvider),
    appService: ref.read(appServiceProvider.notifier),
  ),
);

class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor({
    required StorageService storageService,
    required AppService appService,
    required RefreshTokenInterceptor refreshTokenInterceptor,
  })  : _storageService = storageService,
        _appService = appService,
        _refreshTokenInterceptor = refreshTokenInterceptor;

  final StorageService _storageService;
  final AppService _appService;
  final RefreshTokenInterceptor _refreshTokenInterceptor;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String? accessToken =
        await _storageService.getString(key: StorageKey.accessToken);

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // 토큰 만료
    if (err.response?.statusCode == 403) {
      await _appService.signOut();
    }
    if (err.response?.statusCode == 401) {
      final Dio dio = Dio()
        ..options = BaseOptions(
          baseUrl: DioClient.baseUrl,
          connectTimeout: const Duration(milliseconds: 5000),
          receiveTimeout: const Duration(milliseconds: 3000),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
        )
        ..interceptors.addAll(
          <Interceptor>[
            if (kDebugMode)
              PrettyDioLogger(
                requestHeader: true,
                requestBody: true,
              ),
            _refreshTokenInterceptor,
          ],
        );

      try {
        await dio.post(
          '${err.requestOptions.baseUrl}/renew',
        );

        handler.resolve(
          await dio.fetch(err.requestOptions),
        );

        dio.close();
      } on DioException catch (e) {
        super.onError(e, handler);
      }

      return;
    }

    super.onError(err, handler);
  }
}
