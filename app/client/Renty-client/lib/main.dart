import 'package:client/bloc/user/user_bloc.dart';
import 'package:client/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';

import 'package:client/screens/registration/registration_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => UserBloc())],
        child: ScreenUtilInit(
          builder: (context, child) => MaterialApp(
            // debugShowCheckedModeBanner: false,
            theme: ThemeData(
                appBarTheme: const AppBarTheme(
                    elevation: 0, backgroundColor: Colors.white)),
            title: 'My App',
            home: const SIgnInScreen(),
          ),
        ));
  }
}
