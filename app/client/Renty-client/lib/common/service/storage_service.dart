import 'package:client/api/dto/response/user/login.dart';
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

}
