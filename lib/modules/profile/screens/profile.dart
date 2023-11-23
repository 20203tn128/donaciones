import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/kernel/validations/validations-app.dart';
import 'package:donaciones/modules/profile/widgets/password-form.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({
    super.key,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  bool _isButtonDesabled = true;
  final TextEditingController _password = TextEditingController(text: '');
  final TextEditingController _passwordConfirm =
      TextEditingController(text: '');
  final TextEditingController _phone = TextEditingController(text: '');
  final _phoneFormKey = GlobalKey<FormState>();
  bool _isphoneDesabled = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Perfil'),
          backgroundColor: ColorsApp.prmaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Container(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: ColorsApp.secondaryColor,
                      foregroundColor: Colors.white,
                      child: Text(
                        'LC',
                        style: TextStyle(fontSize: 60),
                      ),
                      maxRadius: 60,
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Liz Claudia Espinosa',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.email),
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const Text('liz25@gob.co'),
                                  ],
                                ),
                                const Text(
                                  'Correo electrónico',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black45),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.phone),
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const Text('+ 777-123-456'),
                                  ],
                                ),
                                const Text(
                                  'Telefóno celular',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black45),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 150,
                            ),
                            IconButton(
                                onPressed: () => {
                                      showModalBottomSheet<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SizedBox(
                                            height: 250,
                                            child: Center(
                                              child: SingleChildScrollView(
                                                  child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'Modificar Teléfono',
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: ColorsApp
                                                              .prmaryColor),
                                                    ),
                                                  ),
                                                  Form(
                                                    key: _phoneFormKey,
                                                    onChanged: () => {
                                                      setState(() {
                                                        _isphoneDesabled =
                                                            !_phoneFormKey
                                                                .currentState!
                                                                .validate();
                                                      })
                                                    },
                                                    child: Column(
                                                      children: <Container>[
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(16),
                                                          child: TextFormField(
                                                            decoration:
                                                                const InputDecoration(
                                                                    icon: Icon(
                                                                      Icons
                                                                          .phone,
                                                                      color: ColorsApp
                                                                          .secondaryColor,
                                                                    ),
                                                                    labelText:
                                                                        'Teléfono: *'),
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black45),
                                                            validator: (value) {
                                                              RegExp regex = RegExp(
                                                                  ValidationsApp
                                                                      .phone);
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return 'Campo obligatorio';
                                                              } else if (!regex
                                                                  .hasMatch(
                                                                      value)) {
                                                                return 'Introduce un número telefonico valido';
                                                              }
                                                              return null;
                                                            },
                                                            controller: _phone,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                          ),
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16),
                                                          child: ElevatedButton(
                                                            onPressed:
                                                                _isphoneDesabled
                                                                    ? null
                                                                    : () async {
                                                                        print(
                                                                            '$_phone');
                                                                        //var response = await dio.post<Response>('/api/v1/login', data: {'email': _email, 'password': _password});
                                                                        Navigator.of(context)
                                                                            .pushNamed('/settings');
                                                                      },
                                                            child: const Text(
                                                                'Guardar teléfono'),
                                                            style: ElevatedButton.styleFrom(
                                                                minimumSize:
                                                                    Size(300,
                                                                        50),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            22)),
                                                                backgroundColor:
                                                                    ColorsApp
                                                                        .successColor),
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
                                icon: Icon(
                                  Icons.edit,
                                  color: ColorsApp.secondaryColor,
                                )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () => {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                    height: 350,
                                    child: Center(
                                      child: SingleChildScrollView(
                                          child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Modificar contraseña',
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: ColorsApp.prmaryColor),
                                            ),
                                          ),
                                          Form(
                                            key: _formKey,
                                            onChanged: () => {
                                              setState(() {
                                                _isButtonDesabled = !_formKey
                                                    .currentState!
                                                    .validate();
                                              })
                                            },
                                            child: Column(
                                              children: <Container>[
                                                Container(
                                                  margin: EdgeInsets.all(16),
                                                  child: TextFormField(
                                                    decoration:
                                                        const InputDecoration(
                                                            icon: Icon(
                                                              Icons.key,
                                                              color: ColorsApp
                                                                  .secondaryColor,
                                                            ),
                                                            labelText:
                                                                'Contraseña: *'),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black45),
                                                    validator: (value) {
                                                      RegExp regex = RegExp(
                                                          ValidationsApp
                                                              .password);
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Campo obligatorio';
                                                      } else if (!regex
                                                          .hasMatch(value)) {
                                                        return 'Introduce una contraseña valida';
                                                      }
                                                      return null;
                                                    },
                                                    controller: _password,
                                                    keyboardType: TextInputType
                                                        .visiblePassword,
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.all(16),
                                                  child: TextFormField(
                                                    decoration:
                                                        const InputDecoration(
                                                            icon: Icon(
                                                              Icons.key,
                                                              color: ColorsApp
                                                                  .secondaryColor,
                                                            ),
                                                            labelText:
                                                                ' Confirmar contraseña: *'),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black45),
                                                    validator: (value) {
                                                      RegExp regex = RegExp(
                                                          ValidationsApp
                                                              .password);
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Campo obligatorio';
                                                      } else if (!regex
                                                          .hasMatch(value)) {
                                                        return 'Tus contraseñas no conciden verifica los datos ingresados';
                                                      }
                                                      return null;
                                                    },
                                                    controller:
                                                        _passwordConfirm,
                                                    keyboardType: TextInputType
                                                        .visiblePassword,
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  child: ElevatedButton(
                                                    onPressed: _isButtonDesabled
                                                        ? null
                                                        : () async {
                                                            print(
                                                                '$_password $_passwordConfirm');
                                                            //var response = await dio.post<Response>('/api/v1/login', data: {'email': _email, 'password': _password});

                                                            Navigator.of(
                                                                    context)
                                                                .pushNamed(
                                                                    '/settings');
                                                          },
                                                    child: const Text(
                                                        'Modificar contraseña'),
                                                    style: OutlinedButton.styleFrom(
                                                        minimumSize:
                                                            Size(300, 50),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        22)),
                                                        backgroundColor:
                                                            ColorsApp
                                                                .successColor),
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
                            child: const Text('Modificar contraseña'),
                            style: OutlinedButton.styleFrom(
                                minimumSize: Size(300, 50),
                                backgroundColor: Colors.white,
                                foregroundColor: ColorsApp.successColor,
                                side: const BorderSide(
                                    color: ColorsApp.successColor),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
