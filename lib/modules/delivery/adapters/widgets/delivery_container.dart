import 'package:dio/dio.dart';
import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeliveryContainer extends StatelessWidget {
  final String tittle;
  final String acronimous;
  final DateTime date;
  final String idDelivery;
  final String status;
  const DeliveryContainer(
      {super.key,
      required this.tittle,
      required this.acronimous,
      required this.date,
      required this.idDelivery,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            ExpansionTile(
              leading: CircleAvatar(
                backgroundColor: ColorsApp.prmaryColor,
                foregroundColor: Colors.white,
                child: Text(acronimous),
              ),
              title: Row(
                children: [
                  Text(
                    tittle,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: ColorsApp.secondaryColor),
                  ),
                  Spacer(),
                  Text(
                    status,
                    style: TextStyle(fontSize: 12, color: Colors.black45),
                  )
                ],
              ),
              subtitle: Text(
                '${date.day}/${date.month}/${date.year}',
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 12,
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final dio = Dio();
                          Response response;
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          var token = await prefs.getString('token')!;
                          response = await dio.get(
                              'http://192.168.1.69:3000/api/deliveries/$idDelivery',
                              options: Options(
                                  headers: {'Authorization': 'Bearer $token'}));
                          print('Esti pmrime lo del home container');
                          print(response.data);
                          print('impresion del id delivery');
                          print(idDelivery);
                          Navigator.of(context)
                              .pushNamed('/home/delivery-route', arguments: {
                            'idDelivery': idDelivery,
                          });
                        },
                        child: const Text('Ver ruta'),
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
                                    'http://192.168.1.69:3000/api/deliveries/start/$idDelivery',
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
                                          content:
                                              Text('Se ha iniciado el reparto'),
                                        );
                                      });
                                  Future.delayed(
                                      const Duration(seconds: 2),
                                      () => Navigator.pushReplacementNamed(
                                              context, '/home/delivery',
                                              arguments: {
                                                'idDelivery': idDelivery
                                              }));
                                }
                              },
                              child: const Text('Iniciar'),
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(30, 30),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22)),
                                  backgroundColor: ColorsApp.successColor),
                            )
                          : Spacer(),
                      SizedBox.shrink(),
                      Spacer(),
                      status == 'En proceso'
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
                          : Spacer(),
                      SizedBox.shrink(),
                      Spacer(),
                      status == 'En proceso'
                          ? ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/home/start-delivery');
                              },
                              child: const Text('Cancelar'),
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(30, 30),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22)),
                                  backgroundColor: ColorsApp.successColor),
                            )
                          : Spacer(),
                      SizedBox.shrink(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
