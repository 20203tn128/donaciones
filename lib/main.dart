import 'package:donaciones/config/navigation/home_stack.dart';
import 'package:donaciones/kernel/services/session_service.dart';
import 'package:donaciones/kernel/widgets/navigation/menu.dart';
import 'package:donaciones/modules/auth/adapters/screens/login.dart';
import 'package:donaciones/modules/profile/screens/profile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  final SessionService _sessionService = const SessionService();
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: _sessionService.isLoggedIn(), builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) return const CircularProgressIndicator();
      var loggedIn = snapshot.data!;
      return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: loggedIn ? '/menu' : '/',
      routes: {
        '/': (context) => const Login(),
        '/menu': (context) => const Menu(),
        '/profile': (context) => const Profile(),
      },
    );
    });
  }
}
