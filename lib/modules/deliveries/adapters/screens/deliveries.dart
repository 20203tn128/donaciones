import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:donaciones/kernel/models/delivery.dart';
import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/modules/deliveries/widgets/delivery_card.dart';
import 'package:donaciones/modules/deliveries/services/delivery_service.dart';
import 'package:flutter/material.dart';

class Deliveries extends StatefulWidget {
  const Deliveries({super.key});

  @override
  State<Deliveries> createState() => _DeliveriesState();
}

class _DeliveriesState extends State<Deliveries> {
  final DeliveryService _deliveryService = DeliveryService();
  List<Delivery> _deliveries = [];
  late StreamSubscription _subscription;

  Future<void> _init(ConnectivityResult result) async {
    final List<Delivery> deliveries = [];

    if (result != ConnectivityResult.none) {
      deliveries.addAll(await _deliveryService.get());
      final offlineDelivery = await _deliveryService.getOffline();
      if (offlineDelivery != null) {
        final int index = deliveries.indexWhere((delivery) => delivery.id == offlineDelivery.id);
        if (index != -1) deliveries[index] = offlineDelivery;
      }
    } else {
      final delivery = await _deliveryService.getOffline();
      if (delivery != null) deliveries.add(delivery);
    }

    setState(() {
      _deliveries = deliveries;
    });
  }

  @override
  void initState() {
    _subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _init(result);
    });
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                children: _deliveries.map((delivery) => DeliveryCard(
                  delivery: delivery,
                  reload: () async {
                    _init(await Connectivity().checkConnectivity());
                  },
                )).toList()
              ),
            ],
          ),
        ),
      ),
    );
  }
}
