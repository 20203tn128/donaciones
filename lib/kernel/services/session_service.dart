import 'package:donaciones/kernel/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  const SessionService();

  Future<void> setSession(String token, User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('session_loggedIn', true);
    await prefs.setString('session_token', token);
    await prefs.setString('session_user_id', user.id);
    await prefs.setString('session_user_name', user.name);
    await prefs.setString('session_user_lastname', user.lastname);
    if (user.secondSurname != null) await prefs.setString('session_user_secondSurname', user.secondSurname!);
    await prefs.setString('session_user_email', user.email);
    await prefs.setString('session_user_role', user.role);
    await prefs.setString('session_user_phone', user.phone);
    await prefs.setBool('session_user_status', user.status);
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('session_loggedIn');
    await prefs.remove('session_token');
    await prefs.remove('session_user_id');
    await prefs.remove('session_user_name');
    await prefs.remove('session_user_lastname');
    await prefs.remove('session_user_secondSurname');
    await prefs.remove('session_user_email');
    await prefs.remove('session_user_role');
    await prefs.remove('session_user_phone');
    await prefs.remove('session_user_status');
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('session_loggedIn') ?? false;
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('session_token')!;
  }

  Future<String> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('session_user_id')!;
  }

  Future<User> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return User(
      id: prefs.getString('session_user_id')!,
      name: prefs.getString('session_user_name')!,
      lastname: prefs.getString('session_user_lastname')!,
      secondSurname: prefs.getString('session_user_secondSurname'),
      email: prefs.getString('session_user_email')!,
      role: prefs.getString('session_user_role')!,
      phone: prefs.getString('session_user_phone')!,
      status: prefs.getBool('session_user_status')!,
    );
  }
}