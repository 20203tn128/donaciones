import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:donaciones/kernel/services/session_service.dart';
import 'package:donaciones/kernel/widgets/navigation/menu.dart';
import 'package:donaciones/modules/auth/adapters/screens/login.dart';
import 'package:donaciones/modules/pickups/services/pickup_service.dart';
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

      if (loggedIn) {
        Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
        if (result != ConnectivityResult.none) {
          await PickupService().sync();
        }
      });
      }

      return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: loggedIn ? '/menu' : '/login',
        routes: {
          '/login': (context) => const Login(),
          '/menu': (context) => const Menu(),
        },
      );
    });
  }

  
}
