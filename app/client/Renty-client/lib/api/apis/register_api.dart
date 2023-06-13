import 'package:client/common/utils/http_util.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:dio/dio.dart';

class RegisterApi {
  Future<int?> register(Map<String, dynamic> body) async {
    try {
      var code = await HttpUtil().post('/users/register', data: body);
      return code;
    } on DioError catch (e) {
      toastInfo(msg: "Ошибка при регистрации");
    }
    return null;
  }
}
