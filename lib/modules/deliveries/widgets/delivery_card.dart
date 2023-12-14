import 'package:donaciones/kernel/models/delivery.dart';
import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/modules/deliveries/services/delivery_service.dart';
import 'package:donaciones/modules/deliveries/widgets/delivery_general_annexes_form.dart';
import 'package:flutter/material.dart';

class DeliveryCard extends StatefulWidget {
  final Delivery delivery;
  final Function() reload;
  const DeliveryCard({super.key, required this.delivery, required this.reload});

  @override
  State<DeliveryCard> createState() => _DeliveryCardState(delivery: delivery);
}

class _DeliveryCardState extends State<DeliveryCard> {
  Delivery delivery;
  final DeliveryService _deliveryService = DeliveryService();

  _DeliveryCardState({required this.delivery});


  Future<void> reloadIfOffline() async {
    final offlineDelivery = await _deliveryService.getOffline();
    if(offlineDelivery == null) return;
    if (delivery.id == offlineDelivery.id) {
      setState(() {
      delivery = offlineDelivery;
    });
    }
  }

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
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: ColorsApp.secondaryColor),
                  ),
                  const Spacer(),
                  Text(
                    delivery.status,
                    style: const TextStyle(fontSize: 12, color: Colors.black45),
                  )
                ],
              ),
              subtitle: Text(
                '${delivery.date.day}/${delivery.date.month}/${delivery.date.year}',
                style: const TextStyle(
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
                          Navigator.pushNamed(context, '/detail',
                              arguments: {'delivery': delivery, 'reloadFunction': reloadIfOffline});
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(30, 30),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22)),
                            backgroundColor: ColorsApp.successColor),
                        child: const Text('Ver ruta', style: TextStyle(color: Colors.white),),
                      ),
                      const Spacer(),
                      delivery.status == 'Pendiente'
                          ? ElevatedButton(
                              onPressed: () async {
                                if (await _deliveryService
                                    .start(delivery.id)) {
                                  reloadIfOffline();
                                  // ignore: use_build_context_synchronously
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
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(30, 30),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22)),
                                  backgroundColor: ColorsApp.successColor),
                              child: const Text('Iniciar', style: TextStyle(color: Colors.white),),
                            )
                          : const Spacer(),
                      const SizedBox.shrink(),
                      const Spacer(),
                      delivery.status == 'En proceso'
                          ? ElevatedButton(
                              onPressed: () async {
                                delivery.status = 'Finalizada';
                                delivery.dateEnd = DateTime.now();
                                await _deliveryService
                                    .setOffline(delivery);
                                widget.reload();
                                // ignore: use_build_context_synchronously
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        // ok
                                        title: const Text('Exito'),
                                        content: const Text(
                                            'Se ha finalizado el reparto'), // no tenia internet  nell
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
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(30, 30),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22)),
                                  backgroundColor: ColorsApp.successColor),
                              child: const Text('Finalizar', style: TextStyle(color: Colors.white),),
                            )
                          : const Spacer(),
                      const SizedBox.shrink(),
                      const Spacer(),
                      delivery.status == 'En proceso'
                          ? ElevatedButton(
                              onPressed: () async {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      height: 400,
                                      child: Center(
                                          child: DeliveryGeneralAnnexesForm(reloadParent: reloadIfOffline),),
                                    );
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(30, 30),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22)),
                                  backgroundColor: ColorsApp.successColor),
                              child: const Text('Cancelar', style: TextStyle(color: Colors.white),),
                            )
                          : const Spacer(),
                      const SizedBox.shrink(),
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
