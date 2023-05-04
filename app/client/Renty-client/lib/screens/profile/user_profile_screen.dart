import 'package:client/widgets/bar/app_bar.dart';
import 'package:client/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/bar/bottom_menu.dart';
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
            buildButton("Выйти", "secondary", () {
              Navigator.of(context).pushNamed("signIn");
            }),
          ],
        ),
      ),
      bottomNavigationBar: BottomMenu(
        selectedIndex: 3,
      ),
    );
  }
}
