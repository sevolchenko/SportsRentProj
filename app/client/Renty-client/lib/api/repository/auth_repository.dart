import 'package:client/api/apis/auth_api.dart';
import 'package:client/api/dto/request/user/login.dart';
import 'package:client/api/dto/response/user/login.dart';

class AuthRepository {
  final AuthApi _authApi = AuthApi();

  Future<LoginResponse> login(LoginRequest request) {
    return _authApi.login(request);
  }

  void logout() {
    _authApi.logout();
  }
}