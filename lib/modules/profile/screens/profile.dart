// ignore_for_file: use_build_context_synchronously

import 'package:donaciones/kernel/models/user.dart';
import 'package:donaciones/kernel/services/session_service.dart';
import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/kernel/validations/validations_app.dart';
import 'package:donaciones/modules/profile/services/profile_service.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({
    super.key,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final SessionService _sessionService = const SessionService();
  final ProfileService _profileService = ProfileService();
  final _formKey = GlobalKey<FormState>();
  bool _isButtonDisabled = true;
  final TextEditingController _password = TextEditingController(text: '');
  final TextEditingController _passwordConfirm = TextEditingController(text: '');
  final TextEditingController _phone = TextEditingController(text: '');
  final _phoneFormKey = GlobalKey<FormState>();
  bool _isphoneDisabled = true;
  User? _user;

  Future<void> init() async {
    final user = await _sessionService.getUser();
    setState(() {
      _user = user;
    });
  }

  @override
  initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Perfil'),
          backgroundColor: ColorsApp.primaryColor,
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Container(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: ColorsApp.secondaryColor,
                      foregroundColor: Colors.white,
                      maxRadius: 60,
                      child: Text(
                        _user?.acronym ?? 'U',
                        style: const TextStyle(fontSize: 60),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _user?.name ?? '',
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _user?.lastname ?? '',
                      style: const TextStyle(fontSize: 24),
                    ),
                    const Text(' '),
                    Text(
                      _user?.secondSurname ?? '',
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Column(
                              children: [
                                Icon(Icons.email),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(_user?.email ?? ''),
                                ],
                              ),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Correo electrónico',
                                    style: TextStyle(fontSize: 12, color: Colors.black),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(14.0),
                                    child: Icon(Icons.phone),
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(_user?.phone ?? ''),
                                        ],
                                      ),
                                      const Text(
                                        'Telefóno celular',
                                        style: TextStyle(fontSize: 12, color: Colors.black45),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                  onPressed: () => {
                                        showModalBottomSheet<void>(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Padding(
                                              padding: MediaQuery.of(context).viewInsets,
                                              child: SizedBox(
                                                height: 250,
                                                child: SingleChildScrollView(
                                                    child: Column(
                                                  children: [
                                                    const Padding(
                                                      padding: EdgeInsets.all(16.0),
                                                      child: Text(
                                                        'Modificar Teléfono',
                                                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: ColorsApp.primaryColor),
                                                      ),
                                                    ),
                                                    Form(
                                                      key: _phoneFormKey,
                                                      onChanged: () => {
                                                        setState(() {
                                                          _isphoneDisabled = !_phoneFormKey.currentState!.validate();
                                                        })
                                                      },
                                                      child: Column(
                                                        children: <Container>[
                                                          Container(
                                                            margin: const EdgeInsets.all(16),
                                                            child: TextFormField(
                                                              decoration: const InputDecoration(
                                                                  icon: Icon(
                                                                    Icons.phone,
                                                                    color: ColorsApp.secondaryColor,
                                                                  ),
                                                                  labelText: 'Teléfono: *'),
                                                              controller: _phone,
                                                              style: const TextStyle(fontSize: 12, color: Colors.black45),
                                                              validator: (value) {
                                                                RegExp regex = RegExp(ValidationsApp.phone);
                                                                if (value == null || value.isEmpty) {
                                                                  return 'Campo obligatorio';
                                                                } else if (!regex.hasMatch(value)) {
                                                                  return 'Introduce un número telefonico valido';
                                                                }
                                                                return null;
                                                              },
                                                              keyboardType: TextInputType.number,
                                                            ),
                                                          ),
                                                          Container(
                                                            padding: const EdgeInsets.all(16),
                                                            child: ElevatedButton(
                                                              onPressed: _isphoneDisabled
                                                                  ? null
                                                                  : () async {
                                                                      if (await _profileService.changePhone(_phone.text)) {
                                                                        showDialog(
                                                                          context: context,
                                                                          builder: (BuildContext context) => AlertDialog(
                                                                            title: const Text(
                                                                              'Modificación exitosa',
                                                                              style: TextStyle(color: ColorsApp.successColor),
                                                                            ),
                                                                            content: const Text('¡Tu telefono se ha modificado de manera exitosa!'),
                                                                            actions: <Widget>[
                                                                              TextButton(
                                                                                onPressed: () {
                                                                                  Navigator.pop(context);
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                child: const Text('Ok'),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                        init();
                                                                      }
                                                                    },
                                                              style: ElevatedButton.styleFrom(minimumSize: const Size(300, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), backgroundColor: ColorsApp.successColor, foregroundColor: Colors.white),
                                                              child: const Text('Guardar teléfono'),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )),
                                              ),
                                            );
                                          },
                                        )
                                      },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: ColorsApp.secondaryColor,
                                  )),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () => {
                            showModalBottomSheet<void>(
                              isScrollControlled: true,
                              context: context,
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: SizedBox(
                                    height: 350,
                                    child: SingleChildScrollView(
                                        child: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(top: 20.0),
                                          child: Text(
                                            'Modificar contraseña',
                                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: ColorsApp.primaryColor),
                                          ),
                                        ),
                                        Form(
                                          key: _formKey,
                                          onChanged: () => {
                                            setState(() {
                                              _isButtonDisabled = !_formKey.currentState!.validate();
                                            })
                                          },
                                          child: Column(
                                            children: <Container>[
                                              Container(
                                                margin: const EdgeInsets.all(16),
                                                child: TextFormField(
                                                  decoration: const InputDecoration(
                                                      icon: Icon(
                                                        Icons.key,
                                                        color: ColorsApp.secondaryColor,
                                                      ),
                                                      labelText: 'Contraseña Actual: *'),
                                                  style: const TextStyle(fontSize: 12, color: Colors.black45),
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
                                                margin: const EdgeInsets.all(16),
                                                child: TextFormField(
                                                  decoration: const InputDecoration(
                                                      icon: Icon(
                                                        Icons.key,
                                                        color: ColorsApp.secondaryColor,
                                                      ),
                                                      labelText: 'Nueva contraseña: *'),
                                                  style: const TextStyle(fontSize: 12, color: Colors.black45),
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
                                                  onPressed: _isButtonDisabled
                                                      ? null
                                                      : () async {
                                                          if (await _profileService.changePassword(_password.text, _passwordConfirm.text)) {
                                                            showDialog(
                                                              context: context,
                                                              builder: (BuildContext context) => AlertDialog(
                                                                title: const Text(
                                                                  'Modificación exitosa',
                                                                  style: TextStyle(color: ColorsApp.successColor),
                                                                ),
                                                                content: const Text('¡Tu contraseña se ha modificado de manera exitosa!'),
                                                                actions: <Widget>[
                                                                  TextButton(
                                                                    onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/login', (r) => false),
                                                                    child: const Text('Ok'),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          }
                                                        },
                                                  style: ElevatedButton.styleFrom(minimumSize: const Size(300, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), backgroundColor: ColorsApp.successColor, foregroundColor: Colors.white),
                                                  child: const Text('Confirmar contraseña'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )),
                                  ),
                                );
                              },
                            )
                          },
                          style: OutlinedButton.styleFrom(minimumSize: const Size(300, 50), backgroundColor: ColorsApp.successColor, foregroundColor: Colors.white, side: const BorderSide(color: ColorsApp.successColor), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                          child: const Text('Modificar contraseña'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () => {Navigator.pushNamedAndRemoveUntil(context, '/login', (r) => false)},
                          style: OutlinedButton.styleFrom(minimumSize: const Size(300, 50), backgroundColor: ColorsApp.successColor, foregroundColor: Colors.white, side: const BorderSide(color: ColorsApp.successColor), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                          child: const Text('Cerrar sesión'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
