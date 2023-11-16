import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:flutter/material.dart';

class Settigns extends StatelessWidget {
  const Settigns({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
        backgroundColor: ColorsApp.secondaryColor,
      ),
    );
  }
}
