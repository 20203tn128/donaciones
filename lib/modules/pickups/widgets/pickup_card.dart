import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:donaciones/kernel/models/pickup.dart';
import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/modules/pickups/services/pickup_service.dart';
import 'package:donaciones/modules/pickups/widgets/pick_up_info.dart';
import 'package:donaciones/modules/pickups/widgets/pickup_general_annexes_form.dart';
import 'package:donaciones/modules/pickups/widgets/product_annexes_form.dart';
import 'package:flutter/material.dart';

class PickupCard extends StatefulWidget {
  final Function() reload;
  final Pickup pickup;

  PickupCard({
    super.key,
    required this.pickup,
    required this.reload,
  });

  @override
  State<PickupCard> createState() => _PickupCardState(pickup: pickup);
}

class _PickupCardState extends State<PickupCard> {
  Pickup pickup;
  final PickupService _pickupService = PickupService();
  _PickupCardState({required this.pickup});

  Future<void> reloadIfOffline() async {
    final offlinePickup = await _pickupService.getOffline();
    if (offlinePickup == null) return;
    if (pickup.id == offlinePickup.id) {
      setState(() {
        print('SET STATE PICKUP CARD');
        pickup = offlinePickup;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        child: ExpansionTile(
            leading: CircleAvatar(
              backgroundColor: ColorsApp.prmaryColor,
              foregroundColor: Colors.white,
              child: Text(pickup.acronym),
            ),
            title: Row(
              children: [
                SizedBox(
                  width: 120,
                  child: Text(
                    pickup.name,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorsApp.secondaryColor),
                  ),
                ),
                const Spacer(),
                Text(
                  pickup.status,
                  style: const TextStyle(fontSize: 12, color: Colors.black45),
                )
              ],
            ),
            subtitle: Text(
              '${pickup.products.length} unidades',
              style: const TextStyle(
                color: Colors.black45,
                fontSize: 12,
              ),
            ),
            children: [
              const Divider(
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
                                'Detalles de la cadena ${pickup.chain.name}',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: ColorsApp.secondaryColor),
                              ),
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Direccion: ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                    width: 180,
                                    child: Text(pickup.chain.address,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black45))),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Enlaces: ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(pickup.chain.nameLinkPerson,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.black45))
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Teléfonos: ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: pickup.chain.phones
                                      .map((e) => SizedBox(
                                            width: 80,
                                            child: Text(e,
                                                style: const TextStyle(
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
                            Navigator.pushNamed(context, '/detail', arguments: {
                              'pickup': pickup,
                              'reloadFunction': reloadIfOffline
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(30, 30),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              backgroundColor: ColorsApp.prmaryColor),
                          child: const Text('Productos'),
                        ),
                        const Spacer(),
                        pickup.status == 'Cancelada'
                            ? ElevatedButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SizedBox(
                                        height: 400,
                                        child: Center(
                                          child:
                                              PickupInfo(pickup: widget.pickup),
                                        ),
                                      );
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(30, 30),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6)),
                                    backgroundColor: ColorsApp.successColor),
                                child: const Text('Ver Comentarios'),
                              )
                            : const SizedBox.shrink(),
                        const Spacer(),
                        pickup.status == 'Pendiente'
                            ? ElevatedButton(
                                onPressed: () async {
                                  if (await _pickupService.start(pickup.id)) {
                                    reloadIfOffline();
                                    // ignore: use_build_context_synchronously
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Exito'),
                                            content: const Text(
                                                'Se ha iniciado la recolección'),
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
                                        borderRadius: BorderRadius.circular(6)),
                                    backgroundColor: ColorsApp.successColor),
                                child: const Text('Iniciar '),
                              )
                            : const SizedBox(),
                        const Spacer(),
                        pickup.status == 'En proceso'
                            ? ElevatedButton(
                                onPressed: () async {
                                  pickup.status = 'Finalizada';
                                  await _pickupService.setOffline(pickup);
                                  reloadIfOffline();
                                  if (await Connectivity()
                                          .checkConnectivity() !=
                                      ConnectivityResult.none) {
                                    _pickupService.sync();
                                  }
                                  // ignore: use_build_context_synchronously
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Exito'),
                                          content: const Text(
                                              'Se ha finalizado la recolección'),
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
                                        borderRadius: BorderRadius.circular(6)),
                                    backgroundColor: ColorsApp.successColor),
                                child: const Text('Finalizar'),
                              )
                            : const SizedBox.shrink(),
                        const Spacer(),
                        pickup.status == 'En proceso'
                            ? ElevatedButton(
                                onPressed: () async {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SizedBox(
                                        height: 400,
                                        child: Center(
                                          child: PickupGeneralAnnexesForm(
                                            reloadParent: reloadIfOffline,
                                            closeFunction: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(30, 30),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6)),
                                    backgroundColor: ColorsApp.dangerColor),
                                child: const Text('Cancelar'),
                              )
                            : const SizedBox.shrink(),
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
