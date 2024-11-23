import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'auth_interceptor.dart';

// import 'auth_interceptor.dart';

final Provider<Dio> dioServiceProvider = Provider<Dio>(
  (Ref ref) {
    // 개발 환경
    if (kDebugMode) {
      return DioClient.dio
        ..interceptors.addAll(<Interceptor>[
          // Dio logging interceptor
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseHeader: true,
          ),
          // 토큰 확인 인터셉터
          ref.watch(authInterceptorProvider),
        ]);
    }
    // 배포 환경
    return DioClient.dio
      ..interceptors.addAll(<Interceptor>[
        ref.watch(authInterceptorProvider),
      ]);
  },
);

class DioClient {
  static String baseUrl = dotenv.env['API_URL']!;

  factory DioClient() => DioClient._();
  DioClient._();

  static final Dio _dio = Dio();

  static Dio get dio => _dio
    ..options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(milliseconds: 10000),
      receiveTimeout: const Duration(milliseconds: 10000),
      sendTimeout: const Duration(milliseconds: 30 * 1000),
      // contentType을 명시적으로 지정해줘야 합니다.
      // https://github.com/cfug/dio/issues/1653
      contentType: Headers.jsonContentType,
    );
}
