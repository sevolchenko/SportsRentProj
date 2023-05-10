import 'package:client/widgets/bar/app_bar.dart';
import 'package:client/widgets/bar/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class RentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset : false,
      appBar: const MyAppBar(title: "Ваши аренды"),
      // body: Body(),
      // We are not able to BottomNavigationBar because the icon parameter dont except SVG
      // We also use Provied to manage the state of our Nav
    );
  }
}
