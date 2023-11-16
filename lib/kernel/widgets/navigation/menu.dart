import 'package:donaciones/config/navigation/home_stack.dart';
import 'package:donaciones/config/navigation/settings_stack.dart';
import 'package:donaciones/kernel/widgets/navigation/botton-navigation-tab.dart';
import 'package:donaciones/modules/profile/screens/profile.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          HomeStack(),
          SettingsStack(),
        ],
      ),
      bottomNavigationBar: BottomNavigationTab(
          selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
    );
  }
}
