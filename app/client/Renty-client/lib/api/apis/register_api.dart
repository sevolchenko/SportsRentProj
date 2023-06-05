import 'package:client/common/utils/http_util.dart';

class RegisterApi {
  Future<int> register(Map<String, dynamic> body) async {
    var code = await HttpUtil().post('/users/register', data: body);
    return code;
  }
}
