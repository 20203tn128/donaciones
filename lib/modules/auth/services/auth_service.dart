import 'package:donaciones/kernel/models/response.dart';
import 'package:donaciones/kernel/models/user.dart';
import 'package:donaciones/kernel/services/api_service.dart';
import 'package:donaciones/kernel/services/session_service.dart';

class AuthService {
  final ApiService apiService = ApiService();
  final SessionService sessionService = const SessionService();

  Future<bool> login(String email, String password) async {
    print(2);
    final response = await apiService.post(
      '/login',
      data: {
        'email': email,
        'password': password,
      }
    );

    print(3);

    final res = Response.fromMap(response.data);

    print(4);
    print(res);

    if (res.statusCode != 200) return false;

    print(5);
    
    await sessionService.setSession(
      res.data['token'],
      User.fromMap(res.data['user']),
    );

    return true;
  }

  Future<void> logout() async {
    await sessionService.clearSession();
  }
}