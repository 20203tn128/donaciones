import 'package:donaciones/modules/profile/screens/profile.dart';
import 'package:donaciones/modules/profile/widgets/password-form.dart';
import 'package:donaciones/modules/profile/widgets/phone-form.dart';
import 'package:flutter/material.dart';

class SettingsStack extends StatelessWidget {
  const SettingsStack({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/settings',
      routes: {
        '/settings': (context) => const Profile(),
        '/settings/password-form': (context) => const PasswordForm(),
        '/settings/phone-form': (context) => const PhoneForm(),
      },
    );
  }
}
