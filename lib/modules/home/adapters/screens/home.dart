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
      'title': 'iPhone 10',
      'description': 'Nuevo iPhone 10 con pantalla tactil de retina',
      'initialRating': 4.5,
      'imageUri': 'assets/images/logo-gob-zapata.jpg'
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
            children: const <Widget>[
              HomeContainer(
                tittle: 'Liz',
                description: 'description',
                imageUri: 'assets/images/logo-gob-zapata.jpg',
              ),
              HomeContainer(
                tittle: 'Liz',
                description: 'description',
                imageUri: 'assets/images/logo-gob-zapata.jpg',
              ),
              HomeContainer(
                tittle: 'Liz',
                description: 'description',
                imageUri: 'assets/images/logo-gob-zapata.jpg',
              )
            ],
          ),
        ),
      ),
    );
  }
}
