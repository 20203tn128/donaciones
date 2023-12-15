// ignore_for_file: use_build_context_synchronously

import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/kernel/validations/validations_app.dart';
import 'package:donaciones/modules/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormextendsState();
}

class _LoginFormextendsState extends State<LoginForm> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool _isButtonDesabled = true;
  final TextEditingController _email = TextEditingController(text: '');
  final TextEditingController _password = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsApp.primaryColor,
        border: Border.all(
          color: ColorsApp.primaryColor,
          width: 10,
        ),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Card(
          shape: const RoundedRectangleBorder(
            side: BorderSide(
              color: ColorsApp.primaryColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(22)),
          ),
          elevation: 5,
          child: SingleChildScrollView(
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
                            decoration: const InputDecoration(icon: Icon(Icons.email), labelText: 'Correo electrónico: *'),
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
                            decoration: const InputDecoration(icon: Icon(Icons.lock), labelText: 'Contraseña: *'),
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
                                    try {
                                      if (await _authService.login(_email.text, _password.text)) {
                                        Navigator.pushReplacementNamed(context, '/menu');
                                      }
                                    } catch (e) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Error'),
                                            content: const Text('Usuario y/o contraseña incorrectos'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('OK')
                                              )
                                            ],
                                          );
                                        }
                                      );
                                    }
                                  },
                            style: ElevatedButton.styleFrom(minimumSize: const Size(100, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)), backgroundColor: ColorsApp.successColor, foregroundColor: Colors.white),
                            child: const Text('Iniciar sesion'),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
