import 'package:client/api/apis/product_preview_api.dart';
import 'package:client/api/apis/user_api.dart';
import 'package:client/api/dto/response/product_preview.dart';
import 'package:client/api/dto/response/user/user.dart';

class UserRepository {
  final UserApi _userApi = UserApi();

  Future<UserResponse?> getMe() {
    return _userApi.getMe();
  }
}
