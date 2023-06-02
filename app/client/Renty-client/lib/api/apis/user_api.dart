import 'package:client/api/dto/response/user/user.dart';
import 'package:client/common/utils/http_util.dart';

class UserApi {
  Future<UserResponse> getMe() async {
    // try {
    var response = await HttpUtil().get(
      'users/me',
    );
    // if (response.statusCode == 200) {
    var jsonData = response.data;
    var res = UserResponse.fromJson(jsonData);
    return res;
    // }
    // } on DioError catch (e) {
    // print(e.message);
    // }
  }
}
