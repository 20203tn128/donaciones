import 'package:dio/dio.dart';
import 'package:donaciones/kernel/services/session_service.dart';

class AuthInterceptor extends Interceptor {
  final SessionService sessionService = const SessionService();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (await sessionService.isLoggedIn()) {
      final token = await sessionService.getToken();
      options.headers.addAll({'authorization': 'Bearer $token'});
    }
    options.contentType = 'application/json';
    handler.next(options);
  }
}