import 'package:client/screens/bloc_providers.dart';
import 'package:client/screens/home/home_screen.dart';
import 'package:client/screens/register/register_screen.dart';
import 'package:client/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: AppBlocProviders.allBlocProviders,
        child: ScreenUtilInit(
          builder: (context, child) => MaterialApp(
            // debugShowCheckedModeBanner: false,
            theme: ThemeData(
                appBarTheme: const AppBarTheme(
                    iconTheme: IconThemeData(
                      color: Colors.black,
                    ),
                    elevation: 0, backgroundColor: Colors.white)),
            title: 'My App',
            home: const HomeScreen(),
            routes: {
              "signIn": (context) => const SignInScreen(),
              "register": (context) => const RegisterScreen(),
            },
          ),
        ));
  }
}
