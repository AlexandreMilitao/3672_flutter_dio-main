import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class DioInterceptor extends Interceptor {
  final Logger _logger =
      Logger(printer: PrettyPrinter(methodCount: 0, printEmojis: false));

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String log = "";
    log += "Requisição\n";
    log += "Timestamp: ${DateTime.now()}\n";
    log += "Metodo: ${options.method}\n";
    log += "URL: ${options.uri}\n";
    log +=
        "Cabeçalho: ${JsonEncoder.withIndent("  ").convert(options.headers)} \n";

    if (options.data != null) {
      log += "Corpo: ${JsonEncoder.withIndent("  ").convert(options.headers)}";
    }
    _logger.w(log);
    Dio().post(
        "https://flutter-dio-dcf94-default-rtdb.firebaseio.com/logs.json",
        data: {
          "request": log,
        });

    super.onRequest(options, handler);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }
}
