import 'package:dio/dio.dart';
import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeContainer extends StatelessWidget {
  final String tittle;
  final String acronimous;
  final String quantity;
  final String status;
  final String address;
  final String personName;
  final String chainsName;
  final List<String> phones;
  final String idPickup;

  const HomeContainer(
      {super.key,
      required this.tittle,
      required this.acronimous,
      required this.quantity,
      required this.status,
      required this.address,
      required this.personName,
      required this.phones,
      required this.chainsName,
      required this.idPickup});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ExpansionTile(
            leading: CircleAvatar(
              backgroundColor: ColorsApp.prmaryColor,
              foregroundColor: Colors.white,
              child: Text(acronimous),
            ),
            title: Row(
              children: [
                SizedBox(
                  width: 120,
                  child: Text(
                    tittle,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorsApp.secondaryColor),
                  ),
                ),
                Spacer(),
                Text(
                  status,
                  style: TextStyle(fontSize: 12, color: Colors.black45),
                )
              ],
            ),
            subtitle: Text(
              '$quantity unidades',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 12,
              ),
            ),
            children: [
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Detalles de la cadena $chainsName',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: ColorsApp.secondaryColor),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Direccion: ',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                                width: 180,
                                child: Text(address,
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black45))),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Enlaces: ',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Text(personName,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black45))
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Teléfonos: ',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: phones
                                  .map((e) => SizedBox(
                                        width: 80,
                                        child: Text(e,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black45)),
                                      ))
                                  .toList(),
                            )
                          ],
                        ),
                      ]),
                    ),
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final dio = Dio();
                        Response response;
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        var token = await prefs.getString('token')!;
                        response = await dio.get(
                            'http://192.168.43.79:3000/api/pickups/$idPickup',
                            options: Options(
                                headers: {'Authorization': 'Bearer $token'}));
                        print('Esti pmrime lo del home container');
                        print(response.data);

                        Navigator.of(context)
                            .pushNamed('/home/recolections_detail', arguments: {
                          'idPickup': idPickup,
                        });
                      },
                      child: const Text('Productos'),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(30, 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22)),
                          backgroundColor: ColorsApp.successColor),
                    ),
                    Spacer(),
                    status == 'Pendiente'
                        ? ElevatedButton(
                            onPressed: () async {
                              final dio = Dio();
                              Response response;
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              var token = await prefs.getString('token')!;
                              response = await dio.patch(
                                  'http://192.168.43.79:3000/api/api/pickups/start/$idPickup',
                                  options: Options(headers: {
                                    'Authorization': 'Bearer $token'
                                  }));
                              print('Esto es lo que imprime del patch');
                              print(response.data);
                              if (response.data['statusCode'] == 200) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Exito'),
                                        content: Text(
                                            'Se ha iniciado la recoleccion'),
                                      );
                                    });
                                Future.delayed(
                                    const Duration(seconds: 2),
                                    () => Navigator.pushReplacementNamed(
                                        context, '/home/recolections'));
                              }
                            },
                            child: const Text('Iniciar '),
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(30, 30),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22)),
                                backgroundColor: ColorsApp.successColor),
                          )
                        : SizedBox(),
                    Spacer(),
                    status == 'Pendiente' || status == 'En proceso'
                        ? ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/home/start-delivery');
                            },
                            child: const Text('Finalizar'),
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(30, 30),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22)),
                                backgroundColor: ColorsApp.successColor),
                          )
                        : SizedBox.shrink(),
                  ],
                )
              ],
            ),
          )

          /* Row(
        children: [
          Column(
            children: [
              /* Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                      onPressed: () =>
                          {Navigator.of(context).pushNamed('/home/recolections')},
                      icon: const Icon(Icons.search))), */
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: ColorsApp.prmaryColor,
                      foregroundColor: Colors.white,
                      child: Text(acronimous),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Text(
                    tittle,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: ColorsApp.secondaryColor),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  
                ],
              ),
              Row(
                children: [
                  Text(
                    quantity,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Productos',
                    style: TextStyle(
                        fontSize: 12, color: ColorsApp.secondaryColor),
                  ),
                  SizedBox(width: 40),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/home/recolections_detail');
                    },
                    child: const Text('validar Productos'),
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: ColorsApp.warningColor,
                        side: const BorderSide(color: ColorsApp.warningColor),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))),
                  ),
                ],
              ),
            ],
          ),
        ],
      ), */
        ]));
  }
}
