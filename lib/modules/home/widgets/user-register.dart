import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/kernel/validations/validations-app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const List<String> list = <String>['Administrador', 'Enlace de ayuntamiento'];

class UserRegister extends StatefulWidget {
  const UserRegister({super.key, thi});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController(text: '');
  final TextEditingController _name = TextEditingController(text: '');
  final TextEditingController _phone = TextEditingController(text: '');
  String dropdawnValue = list.first;
  bool _isDesabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de usuarios'),
        backgroundColor: ColorsApp.prmaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              onChanged: () => {
                setState(() {
                  _isDesabled = !_formKey.currentState!.validate();
                })
              },
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(16),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Nombre Completo*',
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Campo obligatorio';
                        }
                        return null;
                      },
                      controller: _name,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(16),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Correo Electronico *',
                      ),
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
                  Container(
                    margin: EdgeInsets.all(16),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Teléfono *',
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Campo obligatorio';
                        }
                        return null;
                      },
                      controller: _phone,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  DropdownMenu<String>(
                    initialSelection: list.first,
                    onSelected: (String? value) {
                      setState(() {
                        dropdawnValue = value!;
                      });
                    },
                    dropdownMenuEntries:
                        list.map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: ElevatedButton(
                      onPressed: _isDesabled
                          ? null
                          : () => {
                                print('$_email $_phone'),
                              },
                      child: const Text('Iniciar sesion'),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(300, 50),
                          backgroundColor: ColorsApp.successColor),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
