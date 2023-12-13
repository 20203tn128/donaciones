import 'package:donaciones/kernel/models/response.dart';
import 'package:donaciones/kernel/services/api_service.dart';
import 'package:donaciones/kernel/services/session_service.dart';

class ProfileService {
  final ApiService apiService = ApiService();
  final SessionService sessionService = const SessionService();

  Future<bool> changePhone(String phone) async {
    var user = await sessionService.getUser();
    user.phone = phone;

    final response = await apiService.put(
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

    final token = await sessionService.getToken();
    await sessionService.setSession(token, user);

    return true;
  }

  Future<bool> changePassword(String password, String passwordConfirmation) async {
    var response = await apiService.post(
      '/changePassword',
      data: {
        'password': password,
        'newPassword': passwordConfirmation,
      }
    );

    var res = Response.fromMap(response.data);

    if (res.statusCode != 200) return false;

    await sessionService.clearSession();
    return true;
  }
}