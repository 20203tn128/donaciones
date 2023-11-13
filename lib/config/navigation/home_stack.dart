import 'package:donaciones/kernel/widgets/navigation/menu.dart';
import 'package:donaciones/modules/home/adapters/screens/home.dart';
import 'package:donaciones/modules/home/widgets/user-register.dart';
import 'package:flutter/material.dart';

class HomeStack extends StatelessWidget {
  const HomeStack({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/home',
        routes: {
          '/home': (context) => const Home(),
          '/home/userRegister': (context) => const UserRegister(),
        });
  }
}
