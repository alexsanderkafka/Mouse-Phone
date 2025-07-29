import 'package:flutter/material.dart';
import 'package:mouse_phone/view/help.dart';
import 'package:mouse_phone/view/home.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = <Widget>[Home(), Help()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mouse Phone",
          style: TextStyle(color: Color(0xFFFFFFFFF)),
        ),
        backgroundColor: Color(0xFF0000000),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.help), label: "Ajuda"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFFFFFFF),
        unselectedItemColor: Color.fromARGB(109, 255, 255, 255),
        onTap: _onItemTapped,
        backgroundColor: Color(0xFF0000000),
      ),
      backgroundColor: Color(0xFF0000000),
    );
  }
}
