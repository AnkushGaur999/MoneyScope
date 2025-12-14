import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NetworkClient {
  late Dio _dio;

  static final NetworkClient _instance = NetworkClient._private();

  NetworkClient._private() {
    _dio = Dio()
      ..options.baseUrl = dotenv.get("BASE_URL")
      ..options.connectTimeout = Duration(seconds: 15)
      ..options.receiveTimeout = Duration(seconds: 15)
      ..options.sendTimeout = Duration(seconds: 15)
      ..options.headers = {
        "authorization": "Bearer weionjdiorenjw8wbuhewh289hhuieinadn",
      };
  }

  factory NetworkClient() {
    return _instance;
  }

  Future<Response> get({
    required String path,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = _dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (_) {
      rethrow;
    }
  }

  Future<Response> post({
    required String path,
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (_) {
      rethrow;
    }
  }
}
