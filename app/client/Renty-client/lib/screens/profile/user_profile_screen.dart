import 'package:client/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/bottom_nav_bar/bottom_menu.dart';


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "Личный кабинет"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Имя пользователя'),
            Text('Почта пользователя'),
            ElevatedButton(
              onPressed: () {
                // TODO: Выход из аккаунта
              },
              child: Text('Выйти'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomMenu(selectedIndex: 3,),
    );
  }
}