import 'package:client/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/bottom_nav_bar/bottom_menu.dart';
import 'package:client/constants.dart';
import 'package:client/widgets/components/primary_button.dart';
import 'package:client/widgets/components/secondary_button.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "Личный кабинет "),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(children: [
                const Text(
                  'Имя',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(color: Colors.black)
              ]),
            ),
            Expanded(
              child: Column(children: [
                const Text(
                  'Электронная почта',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(color: Colors.black)
              ]),
            ),
            ElevatedButton(
                onPressed: () {
                  // TODO: Выход из аккаунта
                },
                style: secondaryButtonStyle,
                child: const Text('Выйти',
                    style: TextStyle(fontSize: 20, color: kTextColor))),
          ],
        ),
      ),
      bottomNavigationBar: BottomMenu(
        selectedIndex: 3,
      ),
    );
  }
}
