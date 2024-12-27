import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../utils/color_print.dart';
import 'api_constants.dart';
import 'request_constants.dart';
import 'network_exception.dart';

// final dio = Dio();

class ApiManager {
  ApiManager._();
  static final _logger = Logger(
    printer: PrettyPrinter(
      colors: true,
      printTime: true,
      printEmojis: false,
    ),
    filter: DevelopmentFilter(),
  );

  static final Dio _dio = Dio(BaseOptions(
      baseUrl: ApiConstant.baseUrl,
      connectTimeout: const Duration(
        seconds: RequestConstant.connectionTimeout,
      ),
      contentType: 'application/json; charset=utf-8',
      responseType: ResponseType.json));

  static Future<dynamic> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    TColorPrint.yellow("Calling API: $url");
    _logger.t(
      "Calling API: $url",
      stackTrace: StackTrace.empty,
    );

    try {
      final Response<dynamic> response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      _logger.w(
        'Calling API: $url,\nStatusCode: ${response.statusCode},\nStatus Message: ${response.statusMessage}',
        stackTrace: StackTrace.empty,
      );
      _logger.i("Response: $response", stackTrace: StackTrace.empty);

      return response.data;
    } catch (e) {
      if (e is DioException) {
        _logger.e("DioException: ${e.message}", error: e);

        throw DioExceptions.fromDioError(e);
      }
      rethrow;
    }
  }

  static Future<dynamic> post(
    String uri, {
    required dynamic body,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    _logger.t("""
    Calling API: $uri
    Calling parameters: $body""", stackTrace: StackTrace.empty);

    try {
      final Response<dynamic> response = await _dio.post(
        uri,
        data: body,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      _logger.w(
          'Calling API: $uri,\nCalling parameters: $body",\nStatusCode: ${response.statusCode},\nStatus Message: ${response.statusMessage}',
          stackTrace: StackTrace.empty);
      _logger.i("Response: ${response.data}",
          stackTrace: StackTrace.empty);

      return response.data;
    } catch (e) {
      if (e is DioException) {
        _logger.e("DioException: ${e.message}", error: e);
        throw DioExceptions.fromDioError(e);
      }
      rethrow;
    }
  }

  static Future<Response<dynamic>> put(
    String uri, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    _logger.t("Calling API: $uri", stackTrace: StackTrace.empty);
    try {
      final Response<dynamic> response = await _dio.put(
        uri,
        data: body,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      _logger.w(
          'Calling API: $uri,\nCalling parameters: $body",\nStatusCode: ${response.statusCode},\nStatus Message: ${response.statusMessage}',
          stackTrace: StackTrace.empty);
      _logger.i("Response: $response", stackTrace: StackTrace.empty);
      return response;
    } catch (e) {
      if (e is DioException) {
        _logger.e("DioException: ${e.message}", error: e);
        throw DioExceptions.fromDioError(e);
      }
      rethrow;
    }
  }

  static Future<dynamic> delete(
    String uri, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    _logger.t("Calling API: $uri");
    try {
      final Response<dynamic> response = await _dio.delete(
        uri,
        data: body,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      _logger.w(
          'Calling API: $uri,\nCalling parameters: $body",\nStatusCode: ${response.statusCode},\nStatus Message: ${response.statusMessage}',
          stackTrace: StackTrace.empty);
      _logger.i("Response: $response", stackTrace: StackTrace.empty);
      return response.data;
    } catch (e) {
      if (e is DioException) {
        _logger.e("DioException: ${e.message}", error: e);
        throw DioExceptions.fromDioError(e);
      }
      rethrow;
    }
  }

  static Future<void> downloadFile(
    String url,
    String savePath, {
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    _logger.t("Downloading file from: $url");
    try {
      await _dio.download(
        url,
        savePath,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      _logger.w("File downloaded successfully to: $savePath",
          stackTrace: StackTrace.current);
    } catch (e) {
      if (e is DioException) {
        _logger.e("DioError during file download: ${e.message}", error: e);
        throw DioExceptions.fromDioError(e);
      }
      rethrow;
    }
  }
}
