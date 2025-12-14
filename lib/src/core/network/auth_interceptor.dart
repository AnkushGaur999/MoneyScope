import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers["Authorization"] = "Bearer 12345";

    debugPrint("Request-> Path: ${options.uri.path}, data: ${options.data}");

    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    debugPrint(
      "Request-> Path: ${response.realUri.path}, data: ${response.data}",
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(
      "Error-> Message: ${err.message}, Response: ${err.response}, Type: ${err.error} ",
    );

    super.onError(err, handler);
  }
}
