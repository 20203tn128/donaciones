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
        BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard', backgroundColor: ColorsApp.prmaryColor),
        BottomNavigationBarItem(icon: Icon(Icons.local_shipping), label: 'Recolecciones', backgroundColor: ColorsApp.prmaryColor),
        BottomNavigationBarItem(icon: Icon(Icons.local_shipping), label: 'Repartos', backgroundColor: ColorsApp.prmaryColor),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil', backgroundColor: ColorsApp.prmaryColor),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      onTap: onItemTapped,
    );
  }
}
