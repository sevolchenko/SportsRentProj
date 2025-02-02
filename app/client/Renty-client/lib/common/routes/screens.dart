import 'package:client/bloc/auth/auth_bloc.dart';
import 'package:client/bloc/cart/cart_bloc.dart';
import 'package:client/bloc/category/category_bloc.dart';
import 'package:client/bloc/product/product_bloc.dart';
import 'package:client/bloc/register/register_bloc.dart';
import 'package:client/bloc/rent/rent_bloc.dart';
import 'package:client/bloc/size/size_bloc.dart';
import 'package:client/bloc/user/user_bloc.dart';
import 'package:client/common/routes/names.dart';
import 'package:client/global.dart';
import 'package:client/screens/cart/cart_screen.dart';
import 'package:client/screens/home/home_screen.dart';
import 'package:client/screens/home/product/product_screen.dart';
import 'package:client/screens/profile/employee/product_catalog/category/category_screen.dart';
import 'package:client/screens/profile/employee/product_catalog/inventory/product_size/new_size.dart';
import 'package:client/screens/profile/login/login_screen.dart';
import 'package:client/screens/profile/profile_screen.dart';
import 'package:client/screens/profile/register/register_screen.dart';
import 'package:client/screens/rental/rent_screen.dart';
import 'package:client/screens/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenEntity {
  String route;
  Widget screen;
  dynamic bloc;

  ScreenEntity({required this.route, required this.screen, this.bloc});
}

class AppScreens {
  static List<ScreenEntity> routes() {
    return [
      ScreenEntity(
          route: AppRoutes.PRODUCT,
          screen: const ProductScreen(),
          bloc: BlocProvider(
            create: (_) => ProductBloc(),
          )),
      ScreenEntity(
          route: AppRoutes.LOGIN,
          screen: const LoginScreen(),
          bloc: BlocProvider(
            create: (_) => AuthBloc(),
          )),
      ScreenEntity(
          route: AppRoutes.REGISTER,
          screen: const RegisterScreen(),
          bloc: BlocProvider(
            create: (_) => RegisterBloc(),
          )),
      ScreenEntity(
          route: AppRoutes.CATEGORIES,
          screen: const CategoryScreen(),
          bloc: BlocProvider(
            create: (_) => CategoryBloc(),
          )),
      ScreenEntity(
          route: AppRoutes.PRODUCT_NEW_SIZE,
          screen: const ProductSizeScreen(),
          bloc: BlocProvider(
            create: (_) => SizeBloc(),
          )),
      ScreenEntity(
          route: AppRoutes.PROFILE,
          screen: const ProfileScreen(),
          bloc: BlocProvider(
            create: (_) => UserBloc(),
          )),
      ScreenEntity(
          route: AppRoutes.RENT_EVENT,
          screen: const RentScreen(),
          bloc: BlocProvider(
            create: (_) => RentBloc(),
          )),
    ScreenEntity(
          route: AppRoutes.CART,
          screen: const CartScreen(),
          bloc: BlocProvider(
            create: (_) => CartBloc(),
          ))];
  }

  static List<dynamic> allProviders(BuildContext context) {
    List<dynamic> blocProviders = <dynamic>[];
    for (var bloc in routes()) {
      blocProviders.add(bloc.bloc);
    }
    return blocProviders;
  }

  static MaterialPageRoute GenerateRouteSettings(RouteSettings settings) {

    StatefulWidget screen = const HomeScreen();

    if (Global.storageService.isFirstOpen()) {
      screen = const WelcomeScreen();
      Global.storageService.setFirstOpen(false);
    }

    return MaterialPageRoute(
        builder: (_) => screen, settings: settings);
  }
}
