import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:donaciones/kernel/models/pickup.dart';
import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/modules/pickups/services/pickup_service.dart';
import 'package:donaciones/modules/pickups/widgets/pickup_card.dart';
import 'package:flutter/material.dart';

class Pickups extends StatefulWidget {
  const Pickups({super.key});

  @override
  State<Pickups> createState() => _PickupsState();
}

class _PickupsState extends State<Pickups> {
  final PickupService _pickupService = PickupService();
  List<Pickup> _pickups = [];
  late StreamSubscription _subscription;

  Future<void> _init(ConnectivityResult result) async {
    final List<Pickup> pickups = [];

    if (result != ConnectivityResult.none) {
      pickups.addAll(await _pickupService.get());
      final offlinePickup = await _pickupService.getOffline();
      if (offlinePickup != null) {
        final int index = pickups.indexWhere((delivery) => delivery.id == offlinePickup.id);
        if (index != -1) pickups[index] = offlinePickup;
      }
    } else {
      final pickup = await _pickupService.getOffline();
      if (pickup != null) pickups.add(pickup);
    }

    setState(() {
      _pickups = pickups;
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
          title: const Text('Recolecciones', style: TextStyle(color: Colors.white),),
          backgroundColor: ColorsApp.prmaryColor,
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
                Column(children: _pickups.map((pickup) => PickupCard(pickup: pickup, reload: () async {
                  _init(await (Connectivity().checkConnectivity()));
                },)).toList()),
              ],
            ),
          ),
        ),
      );
  }
}
