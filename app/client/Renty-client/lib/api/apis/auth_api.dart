import 'package:client/api/dto/request/user/login.dart';
import 'package:client/api/dto/response/user/login.dart';
import 'package:client/common/utils/http_util.dart';

class AuthApi {
  Future<LoginResponse> login(LoginRequest request) async {
    // try {
    var response = await HttpUtil().postWithResponse(
        'auth/login',
        data: request
    );
    // if (response.statusCode == 200) {
    var jsonData = response.data;
    var res = LoginResponse.fromJson(jsonData);
    return res;
    // }
    // } on DioError catch (e) {
    // print(e.message);
    // }
  }

  void logout() async {
    // try {
    await HttpUtil().post(
        'auth/logout'
    );

  }
}
