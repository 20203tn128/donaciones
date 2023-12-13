import 'package:dio/dio.dart';
import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/kernel/validations/validations-app.dart';
import 'package:donaciones/modules/profile/widgets/password-form.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String name = '';
  String fullName = '';
  String lastname = '';
  String secondSurname = '';
  String acronimus = '';
  String phone = '';
  String email = '';
  String role = '';
  final dio = Dio();

  Future<void> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = await prefs.getString('id')!;
    var token = await prefs.getString('token')!;
    Response response = await dio.get('http://192.168.1.69:3000/api/users/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    setState(() {
      name = response.data['data']['user']['name'];
      lastname = response.data['data']['user']['lastname'];
      secondSurname = response.data['data']['user']['secondSurname'] ?? '';
      fullName = '$name $lastname $secondSurname';

      acronimus = response.data['data']['user']['name'][0].toUpperCase() +
          response.data['data']['user']['lastname'][0].toUpperCase();
      role = response.data['data']['user']['role'];
      phone = response.data['data']['user']['phone'];
      email = response.data['data']['user']['email'];
    });
    print(response.data);
  }

  initState() {
    init();
  }

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: ColorsApp.secondaryColor,
                      foregroundColor: Colors.white,
                      child: Text(
                        acronimus,
                        style: TextStyle(fontSize: 60),
                      ),
                      maxRadius: 60,
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    fullName,
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
                                    Text(email),
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
                                    Text(phone),
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
                                            height: 450,
                                            child: SingleChildScrollView(
                                                child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
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
                                                        margin: const EdgeInsets
                                                            .all(16),
                                                        child: TextFormField(
                                                          decoration:
                                                              InputDecoration(
                                                                  icon: Icon(
                                                                    Icons.phone,
                                                                    color: ColorsApp
                                                                        .secondaryColor,
                                                                  ),
                                                                  labelText:
                                                                      'Teléfono: *'),
                                                          controller: _phone,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .black45),
                                                          validator: (value) {
                                                            RegExp regex = RegExp(
                                                                ValidationsApp
                                                                    .phone);
                                                            if (value == null ||
                                                                value.isEmpty) {
                                                              return 'Campo obligatorio';
                                                            } else if (!regex
                                                                .hasMatch(
                                                                    value)) {
                                                              return 'Introduce un número telefonico valido';
                                                            }
                                                            return null;
                                                          },
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
                                                                      final SharedPreferences
                                                                          prefs =
                                                                          await SharedPreferences
                                                                              .getInstance();
                                                                      var id = await prefs
                                                                          .getString(
                                                                              'id')!;
                                                                      var token =
                                                                          await prefs
                                                                              .getString('token')!;
                                                                      print(
                                                                          '$_phone');
                                                                      var response = await dio.put(
                                                                          'http://192.168.1.69:3000/api/users/$id',
                                                                          options:
                                                                              Options(headers: {
                                                                            'Authorization':
                                                                                'Bearer $token'
                                                                          }),
                                                                          data: {
                                                                            "name":
                                                                                name,
                                                                            "lastname":
                                                                                lastname,
                                                                            "secondSurname":
                                                                                secondSurname,
                                                                            "role":
                                                                                role,
                                                                            "phone":
                                                                                _phone.text,
                                                                          });
                                                                      if (response
                                                                              .data['statusCode'] ==
                                                                          200) {
                                                                        showDialog<
                                                                            String>(
                                                                          context:
                                                                              context,
                                                                          builder: (BuildContext context) =>
                                                                              AlertDialog(
                                                                            title:
                                                                                const Text(
                                                                              'Modificación exitosa',
                                                                              style: TextStyle(color: ColorsApp.successColor),
                                                                            ),
                                                                            content:
                                                                                const Text('¡Tu telefono se ha modificado de manera exitosa!'),
                                                                            actions: <Widget>[
                                                                              TextButton(
                                                                                onPressed: () => Navigator.pushNamed(context, '/profile'),
                                                                                child: const Text('Ok'),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      }
                                                                    },
                                                          child: const Text(
                                                              'Guardar teléfono'),
                                                          style: ElevatedButton.styleFrom(
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
                                    height: 550,
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
                                                              'Contraseña Actual: *'),
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
                                                              'Nueva contraseña: *'),
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
                                                  controller: _passwordConfirm,
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
                                                              '$_password,$_passwordConfirm');
                                                          final SharedPreferences
                                                              prefs =
                                                              await SharedPreferences
                                                                  .getInstance();

                                                          var token =
                                                              await prefs
                                                                  .getString(
                                                                      'token')!;
                                                          print('$_phone');
                                                          var response =
                                                              await dio.post(
                                                                  'http://192.168.1.69:3000/api/changePassword',
                                                                  options: Options(
                                                                      headers: {
                                                                        'Authorization':
                                                                            'Bearer $token'
                                                                      }),
                                                                  data: {
                                                                "password":
                                                                    _password
                                                                        .text,
                                                                "newPassword":
                                                                    _passwordConfirm
                                                                        .text,
                                                              });
                                                          print(response.data[
                                                              'statusCode']);
                                                          if (response.data[
                                                                  'statusCode'] ==
                                                              200) {
                                                            showDialog<String>(
                                                              context: context,
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  AlertDialog(
                                                                title:
                                                                    const Text(
                                                                  'Modificación exitosa',
                                                                  style: TextStyle(
                                                                      color: ColorsApp
                                                                          .successColor),
                                                                ),
                                                                content: const Text(
                                                                    '¡Tu contraseña se ha modificado de manera exitosa!'),
                                                                actions: <Widget>[
                                                                  TextButton(
                                                                    onPressed: () => Navigator.of(
                                                                            context)
                                                                        .pushNamed(
                                                                            '/'),
                                                                    child:
                                                                        const Text(
                                                                            'Ok'),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          }
                                                        },
                                                  child: const Text(
                                                      'Confirmar contraseña'),
                                                  style: ElevatedButton.styleFrom(
                                                      minimumSize:
                                                          Size(300, 50),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          22)),
                                                      backgroundColor: ColorsApp
                                                          .successColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () =>
                                {Navigator.pushReplacementNamed(context, '/')},
                            child: const Text('Cerra Sesion'),
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
