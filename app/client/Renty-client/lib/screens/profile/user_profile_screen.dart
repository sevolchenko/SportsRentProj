import 'package:flutter/material.dart';
import 'package:client/bottom_menu.dart';


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Личный кабинет'),
      ),
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
      bottomNavigationBar: const BottomMenu(),
    );
  }
}