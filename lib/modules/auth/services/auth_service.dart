import 'package:donaciones/kernel/models/response.dart';
import 'package:donaciones/kernel/models/user.dart';
import 'package:donaciones/kernel/services/api_service.dart';
import 'package:donaciones/kernel/services/session_service.dart';

class AuthService {
  final ApiService apiService = ApiService();
  final SessionService sessionService = const SessionService();

  Future<bool> login(String email, String password) async {
    final response = await apiService.post('/login', data: {
      'email': email,
      'password': password,
    });

    final res = Response.fromMap(response.data);

    if (res.statusCode != 200) return false;

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
