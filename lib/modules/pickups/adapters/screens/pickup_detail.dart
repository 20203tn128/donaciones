import 'package:donaciones/kernel/models/pickup.dart';
import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/modules/pickups/services/pickup_service.dart';
import 'package:donaciones/modules/pickups/widgets/pickup_general_annexes_form.dart';
import 'package:donaciones/modules/pickups/widgets/product_card.dart';
import 'package:flutter/material.dart';

class PickupDetail extends StatefulWidget {
  final Pickup pickup;
  final Function reloadParent;
  const PickupDetail(
      {super.key, required this.pickup, required this.reloadParent});

  @override
  State<PickupDetail> createState() => _PickupDetailState(pickup: pickup);
}

class _PickupDetailState extends State<PickupDetail> {
  Pickup pickup;
  _PickupDetailState({required this.pickup});
  final PickupService _pickupService = PickupService();
  reloadIfOffline() async {
    widget.reloadParent();

    final offlinePickup = await _pickupService.getOffline();
    if (offlinePickup == null) return;
    if (pickup.id == offlinePickup.id) {
      setState(() {
        print('SET STATE PICKUP DETALL');
        pickup = offlinePickup;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalles de la recolección',
          style: TextStyle(color: Colors.white),
        ),
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
            child: widget.pickup.status !='Pendiente'
                ? Column(
                    children: pickup.products
                        .asMap()
                        .entries
                        .map((entry) {
                          print('MAP PICKUP DETAIL');
                          print(entry.value.toMap());
                          return ProductCard(
                              pickup: widget.pickup,
                              product: entry.value,
                              reloadParent: reloadIfOffline,
                              index: entry.key,
                            );
                        })
                        .toList())
                : const SizedBox.shrink(),
          ),
          widget.pickup.status !='Pendiente'
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
                      widget.pickup.products.length.toString(),
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black45),
                    ),
                    const SizedBox(
                      width: 180,
                    ),
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
