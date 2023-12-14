import 'package:donaciones/kernel/models/pickup.dart';
import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/modules/pickups/widgets/pickup_general_annexes_form.dart';
import 'package:donaciones/modules/pickups/widgets/product_card.dart';
import 'package:flutter/material.dart';

class PickupDetail extends StatelessWidget {
  final Pickup pickup;
  const PickupDetail({super.key, required this.pickup});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la recolección'),
        backgroundColor: ColorsApp.prmaryColor,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Lista de productos',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ColorsApp.secondaryColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: pickup.status == 'En proceso' ||
                    pickup.status == 'Finalizado' ||
                    pickup.status == 'Cancelada'
                ? Column(
                    children: pickup.products
                        .map((product) => ProductCard(
                              pickup: pickup,
                              product: product, reload: (){},
                            ))
                        .toList())
                : const SizedBox.shrink(),
          ),
          pickup.status == 'En proceso' ||
                  pickup.status == 'Finalizado' ||
                  pickup.status == 'Cancelada'
              ? Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        'Total:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      pickup.products.length.toString(),
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black45),
                    ),
                    const SizedBox(
                      width: 180,
                    ),
                    pickup.status == 'En proceso'
                        ? Align(
                            alignment: Alignment.bottomLeft,
                            child: ElevatedButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const SizedBox(
                                      height: 400,
                                      child: Center(
                                        child: PickupGeneralAnnexesForm(),
                                      ),
                                    );
                                  },
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: ColorsApp.successColor,
                                  side: const BorderSide(
                                      color: ColorsApp.successColor),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16))),
                              child: const Text('Guardar'),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                )
              : const Card(
                  elevation: 5,
                  color: Color.fromARGB(255, 245, 219, 126),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.warning_amber_outlined),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: SizedBox(
                            width: 300,
                            child: Text(
                              'Para observar los productos de esta recolección primero debes de iniciarla',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(115, 43, 42, 42)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
