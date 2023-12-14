import 'package:donaciones/kernel/widgets/navigation/menu.dart';
import 'package:donaciones/modules/deliveries/adapters/screens/deliveries.dart';
import 'package:donaciones/modules/profile/screens/profile.dart';
import 'package:flutter/material.dart';

class HomeStack extends StatelessWidget {
  const HomeStack({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/home',
        routes: {
          '/home/delivery': (context) => const Deliveries(),
          '/home/profile': (context) => const Profile(),
        });
  }
}
