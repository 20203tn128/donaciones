import 'package:donaciones/modules/deliveries/adapters/screens/deliveries.dart';
import 'package:donaciones/modules/deliveries/adapters/screens/delivery_detail.dart';
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
        '/detail': (context) {
          final dynamic args = ModalRoute.of(context)!.settings.arguments;
          return DeliveryDetail(
            delivery: args!['delivery'],
            reloadParent: args!['reloadFunction'],
          );
        },
        
      },
    );
  }
}
