import 'package:flutter/material.dart';
import 'package:client/screens/profile/user_profile_screen.dart';
import 'package:client/screens/main/main_screen.dart';
import 'package:client/screens/rent/rent_screen.dart';
import 'package:client/screens/cart/cart_screen.dart';

class BottomMenu extends StatefulWidget {
  int selectedIndex;

  BottomMenu({super.key, required this.selectedIndex});

  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  final List<Widget> _widgetOptions = <Widget>[
    // Экраны приложения
    MainScreen(),
    RentScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  final List<String> _labels = ["Главная", "Аренды", "Корзина", "Профиль"];

  void _onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => _widgetOptions[widget.selectedIndex],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: widget.selectedIndex,
      onTap: _onItemTapped,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home,
              size: 40,
              color: widget.selectedIndex == 0 ? Colors.black : Colors.grey),
          label: _labels[0],
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pedal_bike,
              size: 40,
              color: widget.selectedIndex == 1 ? Colors.black : Colors.grey),
          label: _labels[1],
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart,
              size: 40,
              color: widget.selectedIndex == 2 ? Colors.black : Colors.grey),
          label: _labels[2],
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person,
              size: 40,
              color: widget.selectedIndex == 3 ? Colors.black : Colors.grey),
          label: _labels[3],
        ),
      ],
    );
  }
}
