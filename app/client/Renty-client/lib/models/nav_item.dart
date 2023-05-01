// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class NavItem {
//   final int? id;
//   final FaIcon? icon;
//   final Widget? destination;

//   NavItem({this.id, this.icon, this.destination});

// // If there is no destination then it help us
//   bool destinationChecker() {
//     if (destination != null) {
//       return true;
//     }
//     return false;
//   }
// }

// class NavItems extends ChangeNotifier {
//   // By default first one is selected
//   int selectedIndex = 0;

//   void chnageNavIndex({int index}) {
//     selectedIndex = index;
//     // if any changes made it notify widgets that use the value
//     notifyListeners();
//   }

//   List<NavItem> items = [
//     NavItem(
//       id: 1,
//       icon: const FaIcon(
//               FontAwesomeIcons.house,
//               color: Colors.black,
//               size: 24,
//           ),
//       destination: MainScreen(),
//     ),
//     NavItem(
//       id: 2,
//       icon: const FaIcon(
//               FontAwesomeIcons.bicycle,
//               color: Colors.black,
//               size: 24,
//           ),
//     ),
//     NavItem(
//       id: 3,
//       icon: const FaIcon(
//               FontAwesomeIcons.cartShopping,
//               color: Colors.black,
//               size: 24,
//           ),
//     ),
//     NavItem(
//       id: 4,
//       icon: const FaIcon(
//               FontAwesomeIcons.user,
//               color: Colors.black,
//               size: 24,
//           ),
//     ),
//   ];
// }
