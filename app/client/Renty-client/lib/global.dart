import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:client/common/service/cart.dart';
import 'package:client/common/service/storage_service.dart';
import 'package:client/common/values/colors.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';

class Global {
  static late FirebaseRemoteConfig remoteConfig;
  static late StorageService storageService;
  static late Cart cart;
  static late Color appColor;

  static Future init() async {
    remoteConfig = FirebaseRemoteConfig.instance;


    AppMetrica.activate(
        AppMetricaConfig("1da626d2-acf8-4bd0-9e74-4364134a7a42"));

    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(seconds: 0),
    ));

    await remoteConfig.fetchAndActivate();

    WidgetsFlutterBinding.ensureInitialized();

    storageService = await StorageService().init();
    cart = Cart();
    cart = storageService.loadCart(cart);

    appColor = remoteConfig.getBool("SplashScreenColor") == true
        ? kPrimaryColor
        : kSecondaryColor;
  }
}
