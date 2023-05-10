import 'package:client/screens/home/home_screen.dart';
import 'package:client/screens/profile/user_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildScreen(int index) {
  List<Widget> _widget = [
    const HomeScreen(),
    Center(child: Text("Rent")),
    Center(child: Text("Cart")),
    const ProfileScreen()
  ];
  print("build screen: ${index}");

  return _widget[index];
}

final List<String> _labels = ["Главная", "Аренды", "Корзина", "Профиль"];

var bottomTabs = [
  BottomNavigationBarItem(
    icon: Icon(
      Icons.home,
      size: 30.w,
    ),
    label: _labels[0],
  ),
  BottomNavigationBarItem(
    icon: Icon(
      Icons.pedal_bike,
      size: 30.w,
    ),
    label: _labels[1],
  ),
  BottomNavigationBarItem(
    icon: Icon(
      Icons.shopping_cart,
      size: 30.w,
    ),
    label: _labels[2],
  ),
  BottomNavigationBarItem(
    icon: Icon(
      Icons.person,
      size: 30.w,
    ),
    label: _labels[3],
  ),
];
