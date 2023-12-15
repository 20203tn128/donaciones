import 'package:donaciones/kernel/models/delivery.dart';
import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/modules/deliveries/services/delivery_service.dart';
import 'package:donaciones/modules/deliveries/widgets/route_card.dart';
import 'package:flutter/material.dart';

class DeliveryDetail extends StatefulWidget {
  final Function reloadParent;
  final Delivery delivery;
  const DeliveryDetail({
    super.key,
    required this.delivery,
    required this.reloadParent,
  });

  @override
  State<DeliveryDetail> createState() => _DeliveryDetailState(delivery: delivery);
}

class _DeliveryDetailState extends State<DeliveryDetail> {
  Delivery delivery;
  final DeliveryService _deliveryService = DeliveryService();

  _DeliveryDetailState({required this.delivery});


  reloadIfOffline() async {
    widget.reloadParent();

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Ruta de entrega', style: TextStyle(color: Colors.white),),
        backgroundColor: ColorsApp.prmaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: delivery.routes
              .asMap().entries.map((entry) => RouteCard(
                    route: entry.value,
                    index: entry.key,
                    reloadParent: reloadIfOffline, 
                    delivery: delivery,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
