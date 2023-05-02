import 'package:client/widgets/app_bar.dart';
import 'package:client/widgets/bottom_nav_bar/bottom_menu.dart';
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
      bottomNavigationBar: BottomMenu(selectedIndex: 1,),
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

