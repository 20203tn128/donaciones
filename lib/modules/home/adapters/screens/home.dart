import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/kernel/widgets/navigation/botton-navigation-tab.dart';
import 'package:donaciones/modules/home/widgets/home-container.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> item = {
      'title': 'Chedraui',
      'acronimous': 'CH',
      'quantity': '12',
      'status': 'Pendiente'
    };
    final Map<String, dynamic> item2 = {
      'title': 'Walmart',
      'acronimous': 'WL',
      'quantity': '12',
      'status': 'Pendiente'
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recolecciones'),
        backgroundColor: ColorsApp.prmaryColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Text("Buscar"),
                  Expanded(child: TextField()),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search),
                  )
                ],
              ),
            ),
            HomeContainer(
                tittle: item['title'],
                acronimous: item['acronimous'],
                quantity: item['quantity'],
                status: item['status']),
            HomeContainer(
                tittle: item2['title'],
                acronimous: item2['acronimous'],
                quantity: item2['quantity'],
                status: item2['status']),
            HomeContainer(
                tittle: item2['title'],
                acronimous: item2['acronimous'],
                quantity: item2['quantity'],
                status: item2['status']),
            HomeContainer(
                tittle: item2['title'],
                acronimous: item2['acronimous'],
                quantity: item2['quantity'],
                status: item2['status']),
            HomeContainer(
                tittle: item2['title'],
                acronimous: item2['acronimous'],
                quantity: item2['quantity'],
                status: item2['status']),
            HomeContainer(
                tittle: item2['title'],
                acronimous: item2['acronimous'],
                quantity: item2['quantity'],
                status: item2['status']),

            // ListView(
            //   padding: const EdgeInsets.all(16),
            //   children: [

            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
