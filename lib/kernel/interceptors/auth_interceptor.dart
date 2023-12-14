import 'package:dio/dio.dart';
import 'package:donaciones/kernel/services/session_service.dart';

class AuthInterceptor extends Interceptor {
  final SessionService sessionService = const SessionService();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    print(41);
    if (await sessionService.isLoggedIn()) {
      print(42);
      final token = await sessionService.getToken();
      options.headers.addAll({'authorization': 'Bearer $token'});
    }
    options.contentType = 'application/json';
    print(43);
    handler.next(options);
    print(44);
  }
}