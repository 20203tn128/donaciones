import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/kernel/validations/validations-app.dart';
import 'package:flutter/material.dart';

class PhoneForm extends StatefulWidget {
  const PhoneForm({super.key});

  @override
  State<PhoneForm> createState() => _PhoneFormState();
}

class _PhoneFormState extends State<PhoneForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isButtonDesabled = true;
  final TextEditingController _phone = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modificar Teléfono'),
        backgroundColor: ColorsApp.secondaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 16),
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
                  margin: const EdgeInsets.all(16),
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Teléfono: *'),
                    validator: (value) {
                      RegExp regex = RegExp(ValidationsApp.phone);
                      if (value == null || value.isEmpty) {
                        return 'Campo obligatorio';
                      } else if (!regex.hasMatch(value)) {
                        return 'Introduce un número telefonico valido';
                      }
                      return null;
                    },
                    controller: _phone,
                    keyboardType: TextInputType.number,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: _isButtonDesabled
                        ? null
                        : () async {
                            print('$_phone');
                            //var response = await dio.post<Response>('/api/v1/login', data: {'email': _email, 'password': _password});
                            Navigator.of(context).pushNamed('/settings');
                          },
                    child: const Text('Guardar teléfono'),
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
