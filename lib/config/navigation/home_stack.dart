import 'package:donaciones/kernel/widgets/navigation/menu.dart';
import 'package:donaciones/modules/deliveries/adapters/screens/deliveries.dart';
import 'package:donaciones/modules/home/adapters/screens/dashboard.dart';
import 'package:donaciones/modules/home/adapters/screens/recolection.dart';
import 'package:donaciones/modules/home/adapters/screens/recolection_detail.dart';
import 'package:donaciones/modules/home/widgets/all-coments-form.dart';
import 'package:donaciones/modules/home/widgets/coments-form.dart';
import 'package:donaciones/modules/home/widgets/products_detail.dart';
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
          '/home': (context) => const Dashboard(),
          '/home/recolections': (context) => const Recolection(),
          '/home/recolections_detail': (context) {
            final dynamic rawArgumrnts =
                ModalRoute.of(context)!.settings.arguments;
            final Map<String, dynamic> arguments =
                (rawArgumrnts as Map<String, dynamic>?) ?? {};
            final idPickup = arguments['idPickup'] ?? '';
            return RecolectionDetail(
              idPickup: idPickup,
            );
          },
          '/home/coments-form': (context) => const ComentsForm(),
          '/home/all-coments-form': (context) => const AllComentsForm(),
          '/home/delivery': (context) => const Deliveries(),
          '/home/profile': (context) => const Profile(),
        });
  }
}
