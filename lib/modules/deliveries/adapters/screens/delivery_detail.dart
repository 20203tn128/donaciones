import 'package:dio/dio.dart';
import 'package:donaciones/kernel/models/delivery.dart';
import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/modules/deliveries/widgets/delivery_card.dart';
import 'package:donaciones/modules/deliveries/widgets/route_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        title: Text('Ruta de entrega'),
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
