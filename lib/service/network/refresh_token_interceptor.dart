// 리프레쉬 토큰을 이용해 엑세스 토큰을 재발급 받는 interceptor

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/app_service.dart';
import '../storage/storage_key.dart';
import '../storage/storage_service.dart';

final Provider<RefreshTokenInterceptor> refreshTokenInterceptorProvider =
    Provider<RefreshTokenInterceptor>(
  (ProviderRef<RefreshTokenInterceptor> ref) => RefreshTokenInterceptor(
    storageService: ref.watch(storageServiceProvider),
    signOut: ref.read(appServiceProvider.notifier).signOut,
  ),
);

class RefreshTokenInterceptor extends QueuedInterceptor {
  static const String _refreshTokenPath = '/renew';

  RefreshTokenInterceptor({
    required StorageService storageService,
    required Future<void> Function() signOut,
  })  : _storageService = storageService,
        _signOut = signOut;

  final StorageService _storageService;
  final Future<void> Function() _signOut;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_getIsRefreshRequest(options)) {
      final String? oldRefreshToken =
          await _storageService.getString(key: 'refreshToken');

      if (oldRefreshToken != null) {
        options.headers['Authorization'] = 'Bearer $oldRefreshToken';
      }
    } else {
      final String? accessToken =
          await _storageService.getString(key: StorageKey.accessToken);

      if (accessToken != null) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    }

    super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    if (_getIsRefreshRequest(response.requestOptions)) {
      final String? accessToken = response.data?['access_token'] as String?;
      final String? refreshToken = response.data?['refresh_token'] as String?;

      if (response.statusCode == 201 &&
          accessToken != null &&
          refreshToken != null) {
        await _storageService.setString(
          key: StorageKey.accessToken,
          value: accessToken,
        );
        await _storageService.setString(
          key: StorageKey.refreshToken,
          value: refreshToken,
        );
      }
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      _signOut();
    }
    super.onError(err, handler);
  }

  bool _getIsRefreshRequest(RequestOptions requestOptions) =>
      requestOptions.path == requestOptions.baseUrl + _refreshTokenPath;
}
