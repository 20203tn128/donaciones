import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:flutter/material.dart';

class BottomNavigationTab extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  const BottomNavigationTab({super.key, required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
        BottomNavigationBarItem(icon: Icon(Icons.local_shipping), label: 'Recolecciones'),
        BottomNavigationBarItem(icon: Icon(Icons.local_shipping), label: 'Repartos'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: ColorsApp.successColor,
      unselectedItemColor: ColorsApp.prmaryColor,
      onTap: onItemTapped,
    );
  }
}
