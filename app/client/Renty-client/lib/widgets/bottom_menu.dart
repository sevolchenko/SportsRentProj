import 'package:flutter/material.dart';
import 'package:client/screens/profile/user_profile_screen.dart';

class BottomMenu extends StatefulWidget {
  const BottomMenu({Key? key}) : super(key: key);

  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  int _selectedIndex = 0;

  final List<IconData> _icons = [
    Icons.home,
    Icons.pedal_bike,
    Icons.shopping_cart,
    Icons.person,
  ];
  

  final List<Widget> _widgetOptions = <Widget>[
    // Экраны приложения
    const Text('Главная'),
    const Text('Аренды'),
    const Text('Корзина'),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(_icons[0]),
            onPressed: () {
              setState(() {
                _selectedIndex = 0;
                Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => _widgetOptions.elementAt(_selectedIndex),
                      ),
                    ); 
              });
            },
            color: _selectedIndex == 0 ? Colors.blue : Colors.grey,
          ),
          IconButton(
            icon: Icon(_icons[1]),
            onPressed: () {
              setState(() {
                _selectedIndex = 1;
                Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => _widgetOptions.elementAt(_selectedIndex),
                      ),
                    ); 
              });
            },
            color: _selectedIndex == 1 ? Colors.blue : Colors.grey,
          ),
          IconButton(
            icon: Icon(_icons[2]),
            onPressed: () {
              setState(() {
                _selectedIndex = 2;
                Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => _widgetOptions.elementAt(_selectedIndex),
                      ),
                    ); 
              });
            },
            color: _selectedIndex == 2 ? Colors.blue : Colors.grey,
          ),
          IconButton(
            icon: Icon(_icons[3]),
            onPressed: () {
              setState(() {
                _selectedIndex = 3;
                Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => _widgetOptions.elementAt(_selectedIndex),
                      ),
                    ); 
              });
            },
            color: _selectedIndex == 3 ? Colors.blue : Colors.grey,
          ),
        ],
      ),
    );
  }
}


