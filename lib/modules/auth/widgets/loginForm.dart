import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/kernel/validations/validations-app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    return Container(
      decoration: BoxDecoration(
        color: ColorsApp.prmaryColor,
        border: Border.all(
          color: ColorsApp.prmaryColor,
          width: 10,
        ),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: ColorsApp.prmaryColor,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(22)),
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
                            decoration: const InputDecoration(
                                icon: Icon(Icons.email),
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
                            decoration: const InputDecoration(
                                icon: Icon(Icons.lock),
                                labelText: 'Contraseña: *'),
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
                                      var response = await dio.post(
                                          'http://192.168.1.69:3000/api/login',
                                          data: {
                                            'email': _email.text,
                                            'password': _password.text
                                          });
                                      print(response.data['data']['token']);
                                      final SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      await prefs.setString('token',
                                          response.data['data']['token']);
                                      await prefs.setString('id',
                                          response.data['data']['user']['id']);
                                      print('Esto debio de imprimir algo :v');
                                      Navigator.pushReplacementNamed(
                                          context, '/menu');
                                    } catch (e) {
                                      print('Error: $e');
                                    }
                                  },
                            child: const Text('Iniciar sesion'),
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(100, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22)),
                                backgroundColor: ColorsApp.successColor),
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
