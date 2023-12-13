import 'package:donaciones/modules/deliveries/adapters/screens/deliveries.dart';
import 'package:flutter/material.dart';

class DeliveryStack extends StatelessWidget {
  const DeliveryStack({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Deliveries(),
        '/delivery': (context) => const Text('Deliveries'),
      },
    );
  }
}