import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/modules/delivery/adapters/widgets/delivery_route_container.dart';
import 'package:flutter/material.dart';

class DeliveryRoute extends StatelessWidget {
  const DeliveryRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> item = {
      'number': '1',
      'title': 'Otilio Montaño',
      'acronimous': 'OM',
      'address': 'Calle Otilio Motaño # 234',
      'references': 'Parque'
    };
    final Map<String, dynamic> item2 = {
      'number': '2',
      'title': '3 De Mayo',
      'acronimous': '3M',
      'address': 'Calle Otilio Motaño # 234',
      'references': 'Parque'
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('Ruta de entrega'),
        backgroundColor: ColorsApp.prmaryColor,
      ),
      body: Column(
        children: [
          DeliveruRouteContainer(
            acronimous: item['acronimous'],
            tittle: item['title'],
            adress: item['address'],
            references: item['references'],
            number: item['number'],
          ),
          DeliveruRouteContainer(
            acronimous: item2['acronimous'],
            tittle: item2['title'],
            adress: item2['address'],
            references: item2['references'],
            number: item2['number'],
          ),
        ],
      ),
    );
  }
}
