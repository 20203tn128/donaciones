import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:donaciones/kernel/models/pickup.dart';
import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/modules/pickups/services/pickup_service.dart';
import 'package:donaciones/modules/pickups/widgets/pickup_card.dart';
import 'package:flutter/material.dart';

class Pickups extends StatelessWidget {
  const Pickups({super.key});
  Future<List<Pickup>> _init() async {
    final PickupService pickupService = PickupService();
    final List<Pickup> pickups = [];

    if ((await Connectivity().checkConnectivity()) != ConnectivityResult.none) {
      pickups.addAll(await pickupService.get());
      final offlinePickup = await pickupService.getOffline();
      if (offlinePickup != null) {
        final int index = pickups.indexWhere((delivery) => delivery.id == offlinePickup.id);
        if (index != -1) pickups[index] = offlinePickup;
      }
    } else {
      final pickup = await pickupService.getOffline();
      if (pickup != null) pickups.add(pickup);
    }

    return pickups;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: _init(), builder: (BuildContext context, AsyncSnapshot<List<Pickup>> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Recolecciones'),
            backgroundColor: ColorsApp.primaryColor,
            foregroundColor: Colors.white,
          ),
          body: const Center(child: CircularProgressIndicator()),
        );
      }
      final pickups = snapshot.data!;
      Connectivity().onConnectivityChanged.listen((event) {
        Navigator.pushReplacementNamed(context, '/');
      });
      return Scaffold(
        appBar: AppBar(
          title: const Text('Recolecciones'),
          backgroundColor: ColorsApp.primaryColor,
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: <Widget>[
                      const Text("Buscar"),
                      const Expanded(child: TextField()),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search),
                      )
                    ],
                  ),
                ),
                Column(
                  children: pickups.map((pickup) => PickupCard(
                    pickup: pickup,
                    reload: () async {
                    },
                  )).toList()
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
