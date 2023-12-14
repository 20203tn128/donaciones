import 'package:dio/dio.dart';
import 'package:donaciones/kernel/models/delivery.dart';
import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/modules/deliveries/services/delivery_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeliveryCard extends StatelessWidget {
  final DeliveryService _deliveryService = DeliveryService();
  final Delivery delivery;
  final Function() reload;
  DeliveryCard({super.key, required this.delivery, required this.reload});

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
                child: Text(delivery.acronym),
              ),
              title: Row(
                children: [
                  Text(
                    delivery.name,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: ColorsApp.secondaryColor),
                  ),
                  Spacer(),
                  Text(
                    delivery.status,
                    style: TextStyle(fontSize: 12, color: Colors.black45),
                  )
                ],
              ),
              subtitle: Text(
                '${delivery.date.day}/${delivery.date.month}/${delivery.date.year}',
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
<<<<<<< Updated upstream:lib/modules/deliveries/widgets/delivery_card.dart
                          Navigator.pushNamed(context, '/detail',
                              arguments: {'delivery': delivery});
=======
                          final dio = Dio();
                          Response response;
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          var token = await prefs.getString('token')!;
                          response = await dio.get(
                              'http://192.168.43.79:3000/api/deliveries/$idDelivery',
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
>>>>>>> Stashed changes:lib/modules/delivery/adapters/widgets/delivery_container.dart
                        },
                        child: const Text('Ver ruta'),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(30, 30),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22)),
                            backgroundColor: ColorsApp.successColor),
                      ),
                      Spacer(),
                      delivery.status == 'Pendiente'
                          ? ElevatedButton(
                              onPressed: () async {
<<<<<<< Updated upstream:lib/modules/deliveries/widgets/delivery_card.dart
                                if (await _deliveryService.start(delivery.id)) {
                                  reload();
                                  // ignore: use_build_context_synchronously
=======
                                final dio = Dio();
                                Response response;
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                var token = await prefs.getString('token')!;
                                response = await dio.patch(
                                    'http://192.168.43.79:3000/api/deliveries/start/$idDelivery',
                                    options: Options(headers: {
                                      'Authorization': 'Bearer $token'
                                    }));
                                print('Esto es lo que imprime del patch');
                                print(response.data);
                                if (response.data['statusCode'] == 200) {
>>>>>>> Stashed changes:lib/modules/delivery/adapters/widgets/delivery_container.dart
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Exito'),
                                          content: const Text(
                                              'Se ha iniciado el reparto'),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('OK'))
                                          ],
                                        );
                                      });
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
                      delivery.status == 'En proceso'
                          ? ElevatedButton(
                              onPressed: () async {
                                delivery.status = 'Finalizada';
                                await _deliveryService.setOffline(delivery);
                                reload();
                                // ignore: use_build_context_synchronously
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Exito'),
                                        content: const Text(
                                            'Se ha finalizado el reparto'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('OK'))
                                        ],
                                      );
                                    });
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
                      delivery.status == 'En proceso'
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
