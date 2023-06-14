import 'package:client/api/dto/response/user/user.dart';
import 'package:client/common/utils/http_util.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:dio/dio.dart';

class UserApi {
  Future<UserResponse?> getMe() async {
    try {
      var response = await HttpUtil().get(
        'users/me',
      );
      if (response.statusCode == 200) {
        var jsonData = response.data;
        var res = UserResponse.fromJson(jsonData);
        return res;
      } else {
        toastInfo(msg: "Данные пользователя не были получены");
      }
    } on DioError catch (e) {
      // toastInfo(msg: "Ошибка при получении данных пользователя");
    }
    return null;
  }
}
