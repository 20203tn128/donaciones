import 'package:donaciones/modules/settigns/screens/settigns.dart';
import 'package:donaciones/modules/settigns/widgets/form-settings.dart';
import 'package:flutter/material.dart';

class SettingsStack extends StatelessWidget {
  const SettingsStack({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/settings',
      routes: {
        '/settings': (context) => Settigns(),
        '/settings/form-settings': (context) => const FormSettings(),
      },
    );
  }
}
