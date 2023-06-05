import 'package:client/common/service/cart.dart';
import 'package:client/common/service/storage_service.dart';
import 'package:client/common/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class Global {
  static late FirebaseRemoteConfig remoteConfig;
  static late StorageService storageService;
  static late Cart cart;
  static late Color appColor;
  static Future init() async {
    remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(
          seconds: 10), // a fetch will wait up to 10 seconds before timing out
      minimumFetchInterval: const Duration(
          seconds:
              0), // fetch parameters will be cached for a maximum of 1 hour
    ));

    await remoteConfig.fetchAndActivate();

    WidgetsFlutterBinding.ensureInitialized();

    storageService = await StorageService().init();
    cart = Cart();
    cart = storageService.loadCart(cart);

    appColor = remoteConfig.getBool("SplashScreenColor") == true? kPrimaryColor : kSecondaryColor;
  }
}
