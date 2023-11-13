import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/kernel/widgets/navigation/botton-navigation-tab.dart';
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
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              Container(
                height: 50,
                child: const Center(child: Text('Ricardo Cardenas')),
              ),
              Container(
                height: 50,
                child: const Center(child: Text('Luba Almazan')),
              ),
              Container(
                height: 50,
                child: const Center(child: Text('Miriam Guadalupe')),
              ),
              Container(
                height: 50,
                child: const Center(child: Text('Roy Salgado')),
              ),
              Container(
                height: 50,
                child: const Center(child: Text('Liz Espinosa')),
              ),
              Container(
                height: 50,
                child: const Center(child: Text('Rodrigo Ivan')),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () =>
                      {Navigator.of(context).pushNamed('/home/userRegister')},
                  child: const Text('Aagregar usuario'),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(300, 50),
                      backgroundColor: ColorsApp.successColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
