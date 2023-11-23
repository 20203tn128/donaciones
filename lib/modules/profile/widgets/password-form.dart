import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/kernel/validations/validations-app.dart';
import 'package:flutter/material.dart';

class PasswordForm extends StatefulWidget {
  const PasswordForm({super.key});

  @override
  State<PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isButtonDesabled = true;
  final TextEditingController _password = TextEditingController(text: '');
  final TextEditingController _passwordConfirm =
      TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modificar contraseña'),
        backgroundColor: ColorsApp.secondaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 16),
          ),
          Form(
            key: _formKey,
            onChanged: () => {
              setState(() {
                _isButtonDesabled = !_formKey.currentState!.validate();
              })
            },
            child: Column(
              children: <Container>[
                Container(
                  margin: EdgeInsets.all(16),
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
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: ' Confirmar contraseña: *'),
                    validator: (value) {
                      RegExp regex = RegExp(ValidationsApp.password);
                      if (value == null || value.isEmpty) {
                        return 'Campo obligatorio';
                      } else if (!regex.hasMatch(value)) {
                        return 'Tus contraseñas no conciden verifica los datos ingresados';
                      }
                      return null;
                    },
                    controller: _passwordConfirm,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: _isButtonDesabled
                        ? null
                        : () async {
                            print('$_password $_passwordConfirm');
                            //var response = await dio.post<Response>('/api/v1/login', data: {'email': _email, 'password': _password});
                            print('$_password $_passwordConfirm');
                            Navigator.of(context).pushNamed('/settings');
                          },
                    child: const Text('Modificar contraseña'),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(300, 50),
                        backgroundColor: ColorsApp.successColor),
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
