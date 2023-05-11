import 'package:flutter/material.dart';
import 'package:client/screens/profile/profile_screen.dart';
import 'package:client/screens/home/home_screen.dart';
import 'package:client/screens/rent/rent_screen.dart';
import 'package:client/screens/cart/cart_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyBottomNavBar extends StatefulWidget {
  int selectedIndex;

  MyBottomNavBar({super.key, required this.selectedIndex});

  @override
  _MyBottomNavBarState createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
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
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      currentIndex: widget.selectedIndex,
      onTap: _onItemTapped,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home,
              size: 30.w,
              color: widget.selectedIndex == 0 ? Colors.black : Colors.grey),
          label: _labels[0],
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pedal_bike,
              size: 30.w,
              color: widget.selectedIndex == 1 ? Colors.black : Colors.grey),
          label: _labels[1],
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart,
              size: 30.w,
              color: widget.selectedIndex == 2 ? Colors.black : Colors.grey),
          label: _labels[2],
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person,
              size: 30.w,
              color: widget.selectedIndex == 3 ? Colors.black : Colors.grey),
          label: _labels[3],
        ),
      ],
    );
  }
}
