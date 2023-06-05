import 'dart:convert';

import 'package:client/api/dto/request/rent/start_rent_event.dart';
import 'package:client/api/dto/response/product/product_preview.dart';
import 'package:client/api/dto/response/rent/rent.dart';
import 'package:client/api/dto/response/user/login.dart';
import 'package:client/common/service/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  late final SharedPreferences _prefs;

  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    // _prefs.clear();
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
    final rentList = cart.setRents.map((rent) => rent.toJson()).toList();
    final productList =
        cart.setProducts.map((product) => product.toJson()).toList();
    _prefs.setString('cart_rents', jsonEncode(rentList));
    _prefs.setString('cart_products', jsonEncode(productList));
  }

  loadCart(Cart cart) {
    final cartRentsJson = _prefs.getString('cart_rents');
    final cartProductsJson = _prefs.getString('cart_products');

    if (cartRentsJson != null) {
      final rentsList = jsonDecode(cartRentsJson) as List<dynamic>;
      final rents = rentsList
          .map((rent) => StartRentEventRequest.fromJson(rent))
          .toList();
      cart.setRents = rents;
    }
    if (cartProductsJson != null) {
      final productsJson = jsonDecode(cartProductsJson) as List<dynamic>;
      final products = productsJson
          .map((product) => ProductPreviewResponse.fromJson(product))
          .toList();
      cart.setProducts = products;
    }
    return cart;

    deleteCartData() {
      _prefs.remove("cart_rents");
      _prefs.remove("cart_products");
    }
  }
}
