import 'package:donaciones/config/navigation/home_stack.dart';
import 'package:donaciones/kernel/widgets/navigation/menu.dart';
import 'package:donaciones/modules/auth/adapters/screens/login.dart';
import 'package:donaciones/modules/home/widgets/user-register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Login(),
        '/menu': (context) => const Menu(),
      },
    );
  }
}
