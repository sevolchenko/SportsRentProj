import 'package:client/api/dto/request/user/login.dart';
import 'package:client/api/dto/response/user/login.dart';
import 'package:client/common/utils/http_util.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:dio/dio.dart';

class AuthApi {
  Future<LoginResponse?> login(LoginRequest request) async {
    try {
      var response =
          await HttpUtil().postWithResponse('auth/login', data: request);
      if (response.statusCode == 200) {
        var jsonData = response.data;
        var res = LoginResponse.fromJson(jsonData);
        return res;
      }
    } on DioError catch (e) {
      toastInfo(msg: "Не удалось войти. Проверьте данные");
    }
    return null;
  }

  void logout() async {
    await HttpUtil().post('auth/logout');
  }
}
