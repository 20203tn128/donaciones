import 'package:donaciones/kernel/models/delivery.dart';
import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/modules/deliveries/widgets/route_card.dart';
import 'package:flutter/material.dart';

class DeliveryDetail extends StatelessWidget {
  final Delivery delivery;
  const DeliveryDetail({
    super.key,
    required this.delivery,
  });

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
              .map((route) => RouteCard(
                    route: route,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
