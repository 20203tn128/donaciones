import 'package:donaciones/modules/auth/widgets/login_form.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: LoginForm());
  }
}
