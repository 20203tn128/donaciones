import 'package:donaciones/kernel/models/pickup.dart';
import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/modules/pickups/services/pickup_service.dart';
import 'package:flutter/material.dart';

class PickupCard extends StatelessWidget {
  final PickupService _pickupService = PickupService();
  final Pickup pickup;

  PickupCard({
    super.key,
    required this.pickup
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                                width: 180,
                                child: Text(pickup.chain.address,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.black45))),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Enlaces: ',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
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
                                  fontSize: 12, fontWeight: FontWeight.bold),
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
                        Navigator.pushNamed(context ,'/detail', arguments: {'pickup': pickup});
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(30, 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22)),
                          backgroundColor: ColorsApp.successColor),
                      child: const Text('Productos'),
                    ),
                    const Spacer(),
                    pickup.status == 'Pendiente'
                        ? ElevatedButton(
                            onPressed: () async {
                              if (await _pickupService.start(pickup.id)) {
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
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(30, 30),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22)),
                                backgroundColor: ColorsApp.successColor),
                            child: const Text('Iniciar '),
                          )
                        : const SizedBox(),
                    const Spacer(),
                    pickup.status == 'Pendiente' || pickup.status == 'En proceso'
                        ? ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/home/start-delivery');
                            },
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(30, 30),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22)),
                                backgroundColor: ColorsApp.successColor),
                            child: const Text('Finalizar'),
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
