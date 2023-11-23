import 'dart:io';

import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/kernel/validations/validations-app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dio/dio.dart';

final dio = Dio(BaseOptions(baseUrl: ''));

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormextendsState();
}

class _LoginFormextendsState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isButtonDesabled = true;
  final TextEditingController _email = TextEditingController(text: '');
  final TextEditingController _password = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: Image.asset(
              'assets/images/logo-gob-zapata.jpg',
              width: 300,
              height: 300,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              onChanged: () => {
                setState(() {
                  _isButtonDesabled = !_formKey.currentState!.validate();
                })
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Correo electrónico: *'),
                      validator: (value) {
                        RegExp regex = RegExp(ValidationsApp.email);
                        if (value == null || value.isEmpty) {
                          return 'Campo obligatorio';
                        } else if (!regex.hasMatch(value)) {
                          return 'Introduce un correo válido';
                        }
                        return null;
                      },
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Contraseña: *'),
                      validator: (value) {
                        RegExp regex = RegExp(ValidationsApp.password);
                        if (value == null || value.isEmpty) {
                          return 'Campo obligatorio';
                        } else if (!regex.hasMatch(value)) {
                          return 'Introduce una contraseña valida';
                        }
                        return null;
                      },
                      controller: _password,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: ElevatedButton(
                      onPressed: _isButtonDesabled
                          ? null
                          : () async {
                              print('$_email $_password');
                              //var response = await dio.post<Response>('/api/v1/login', data: {'email': _email, 'password': _password});
                              print('$_email $_password');
                              Navigator.of(context).pushNamed('/menu');
                            },
                      child: const Text('Iniciar sesion'),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(100, 50),
                          backgroundColor: ColorsApp.successColor),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
