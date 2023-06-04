import 'dart:convert';

import 'package:client/api/dto/request/rent/start_rent_event.dart';
import 'package:client/api/dto/response/product_preview.dart';
import 'package:client/api/dto/response/rent.dart';
import 'package:client/api/dto/response/user/login.dart';
import 'package:client/common/service/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  late final SharedPreferences _prefs;

  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  bool isUserAuthenticated() {
    return _prefs.getBool("isAuthenticated") ?? false;
  }

  logout() {
    _prefs.setBool("isAuthenticated", false);
    _prefs.remove("userId");
    _prefs.remove("role");
    _prefs.remove("token");
  }

  LoginResponse? getUser() {
    if (isUserAuthenticated()) {
      int userId = _prefs.getInt("userId")!;
      String role = _prefs.getString("role")!;
      String token = _prefs.getString("token")!;
      return LoginResponse(userId: userId, role: role, token: token);
    } else {
      return null;
    }
  }

  setUser(LoginResponse loginResponse) {
    _prefs.setBool("isAuthenticated", true);
    _prefs.setInt("userId", loginResponse.userId);
    _prefs.setString("role", loginResponse.role);
    _prefs.setString("token", loginResponse.token);
  }

  saveCart(Cart cart) {
    _prefs.setString('cart', Cart().rents.map((e) => e.toJson()).toString());
  }

  // List<StartRentEventRequest>? getCart() {
  //    int productId = _prefs.getInt("product_id")!;
  //    String sizeName = _prefs.getString("size_name")!;
  //    int count = _prefs.getInt("count")!;
  //    String startTime =_prefs.getString("start_time")!;
  //    String endTime =_prefs.getString("end_time")!;

  // }

  loadCart(Cart cart) {
    final cartJson = _prefs.getString('cart');
    if (cartJson != null) {
      final rentsJson = jsonDecode(cartJson);
      final rents = List<StartRentEventRequest>.from(
          rentsJson.map((x) => StartRentEventRequest.fromJson(x)));
      Cart().rents = rents;
      final products = List<ProductPreviewResponse>.from(
          rentsJson.map((x) => ProductPreviewResponse.fromJson(x)));
      Cart().products = products;
    }
  }
}
