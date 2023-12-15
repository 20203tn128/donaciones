import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:donaciones/kernel/models/delivery.dart';
import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/modules/deliveries/widgets/delivery_card.dart';
import 'package:donaciones/modules/deliveries/services/delivery_service.dart';
import 'package:flutter/material.dart';

class Deliveries extends StatelessWidget {
  const Deliveries({super.key});

  Future<List<Delivery>> _init() async {
    final DeliveryService deliveryService = DeliveryService();
    final List<Delivery> deliveries = [];

    if ((await Connectivity().checkConnectivity()) != ConnectivityResult.none) {
      deliveries.addAll(await deliveryService.get());
      final offlineDelivery = await deliveryService.getOffline();
      if (offlineDelivery != null) {
        final int index = deliveries.indexWhere((delivery) => delivery.id == offlineDelivery.id);
        if (index != -1) deliveries[index] = offlineDelivery;
      }
    } else {
      final delivery = await deliveryService.getOffline();
      if (delivery != null) deliveries.add(delivery);
    }

    return deliveries;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: _init(), builder: (BuildContext context, AsyncSnapshot<List<Delivery>> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Repartos'),
            backgroundColor: ColorsApp.primaryColor,
            foregroundColor: Colors.white,
          ),
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      final deliveries = snapshot.data!;
      Connectivity().onConnectivityChanged.listen((event) {
        Navigator.pushReplacementNamed(context, '/');
      });
      return Scaffold(
        appBar: AppBar(
          title: const Text('Repartos'),
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
                  children: deliveries.map((delivery) => DeliveryCard(
                    delivery: delivery,
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
