import 'package:client/widgets/bar/app_bar.dart';
import 'package:client/widgets/bar/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "Корзина"),
      // body: Body(),
      // We are not able to BottomNavigationBar because the icon parameter dont except SVG
      // We also use Provied to manage the state of our Nav
      bottomNavigationBar: MyBottomNavBar(
        selectedIndex: 2,
      ),
    );
  }

  // AppBar buildAppBar() {
  //   return AppBar(
  //     leading: IconButton(
  //       icon: SvgPicture.asset("assets/icons/menu.svg"),
  //       onPressed: () {},
  //     ),
  //     // On Android by default its false
  //     centerTitle: true,
  //     title: Image.asset("assets/images/logo.png"),
  //     actions: <Widget>[
  //       IconButton(
  //         icon: SvgPicture.asset("assets/icons/search.svg"),
  //         onPressed: () {},
  //       ),
  //       SizedBox(
  //         // It means 5 because by out defaultSize = 10
  //         width: SizeConfig.defaultSize * 0.5,
  //       )
  //     ],
  //   );
  // }
}
