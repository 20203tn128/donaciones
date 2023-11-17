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
      'title': 'Recoleccion en Chedraui',
      'date': '12 de Diciembre del 2023',
      'hours': '09:00 AM',
      'status': 'Pendiente'
    };
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de puntos de recogida'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              HomeContainer(
                  tittle: item['title'],
                  date: item['date'],
                  hours: item['hours'],
                  status: item['status'])
            ],
          ),
        ),
      ),
    );
  }
}
