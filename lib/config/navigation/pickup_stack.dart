import 'package:donaciones/modules/pickups/adapters/screens/pickup_detail.dart';
import 'package:donaciones/modules/pickups/adapters/screens/pickups.dart';
import 'package:flutter/material.dart';

class PickupStack extends StatelessWidget {
  const PickupStack({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Pickups(),
        '/detail': (context) {
          final dynamic args = ModalRoute.of(context)!.settings.arguments;
          return PickupDetail(pickup: args!['pickup'],);
        },
      },
    );
  }
}