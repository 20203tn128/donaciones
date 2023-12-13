import 'package:donaciones/kernel/models/response.dart';
import 'package:donaciones/kernel/services/api_service.dart';
import 'package:donaciones/kernel/services/session_service.dart';

class ProfileService {
  final ApiService _apiService = ApiService();
  final SessionService _sessionService = const SessionService();

  Future<bool> changePhone(String phone) async {
    var user = await _sessionService.getUser();
    user.phone = phone;

    final response = await _apiService.put(
      '/users/${user.id}',
      data: {
        'name': user.name,
        'lastname': user.lastname,
        'secondSurname': user.secondSurname,
        'role': user.role,
        'phone': user.phone,
      },
    );

    final res = Response.fromMap(response.data);

    if (res.statusCode != 200) return false;

    final token = await _sessionService.getToken();
    await _sessionService.setSession(token, user);

    return true;
  }

  Future<bool> changePassword(String password, String passwordConfirmation) async {
    var response = await _apiService.post(
      '/changePassword',
      data: {
        'password': password,
        'newPassword': passwordConfirmation,
      }
    );

    var res = Response.fromMap(response.data);

    if (res.statusCode != 200) return false;

    await _sessionService.clearSession();
    return true;
  }
}