import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: '',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    _dio.interceptors.addAll([
      ApiKeyInterceptor(),
      AppLogInterceptor(),
      ErrorInterceptor(),
    ]);
  }

  Dio get dio => _dio;
}

class ApiKeyInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final key = dotenv.env['GEMINI_API_KEY'] ?? '';
    options.queryParameters['key'] = key;
    print('>>> Full URL: ${options.baseUrl}${options.path}');
    print('>>> API Key starts with: ${key.substring(0, 10)}...');
    handler.next(options);
  }
}

class AppLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('>>> ${options.method} ${options.path}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('<<< ${response.statusCode}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('ERR ${err.message}');
    handler.next(err);
  }
}

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final message = switch (err.type) {
      DioExceptionType.connectionTimeout  => 'Connection timeout',
      DioExceptionType.receiveTimeout     => 'Receive timeout',
      DioExceptionType.badResponse        =>
          'Server error: ${err.response?.statusCode}',
      DioExceptionType.connectionError    => 'No internet connection',
      _                                   => 'Unexpected error',
    };

    handler.next(DioException(
      requestOptions: err.requestOptions,
      message: message,
      type: err.type,
    ));
  }
}