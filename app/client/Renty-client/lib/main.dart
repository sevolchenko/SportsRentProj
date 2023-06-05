import 'package:client/common/routes/routes.dart';
import 'package:client/common/values/colors.dart';
import 'package:client/global.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Global.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return MultiBlocProvider(
      providers: [...AppScreens.allProviders(context)],
      child: ScreenUtilInit(
        builder: (context, child) => MaterialApp(
          // debugShowCheckedModeBanner: false,
          builder: EasyLoading.init(),
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                elevation: 0,
                backgroundColor: Colors.white),
          ),
          title: 'My App',
          // home: const HomeScreen(),
          onGenerateRoute: AppScreens.GenerateRouteSettings,
        ),
      ),
    );
  }
}
