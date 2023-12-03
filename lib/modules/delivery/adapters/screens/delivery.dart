import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/modules/delivery/adapters/widgets/delivery_container.dart';
import 'package:flutter/material.dart';

class Delivery extends StatelessWidget {
  const Delivery({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> item = {
      'title': 'Chedraui',
      'acronimous': 'CH',
      'date': '12 de Noviembre del 2023',
    };
    final Map<String, dynamic> item2 = {
      'title': 'Walmart',
      'acronimous': 'WL',
      'date': '15 de Diciembre del 2023',
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('Repartos'),
        backgroundColor: ColorsApp.prmaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(children: [
            Row(
              children: [
                Text("Buscar"),
                Expanded(child: TextField()),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                )
              ],
            ),
            DeliveryContainer(
              tittle: item['title'],
              acronimous: item['acronimous'],
              date: item['date'],
            ),
            DeliveryContainer(
              tittle: item2['title'],
              acronimous: item2['acronimous'],
              date: item2['date'],
            ),
          ]),
        ),
      ),
    );
  }
}
