import 'package:client/api/dto/request/user/user_login.dart';
import 'package:client/common/utils/http_util.dart';

class UserApi {
  static login({UserLoginRequest? params}) async {
    var response = await HttpUtil().post('', queryParameters: params?.toJson());

    print(response.toString());
    // return UserLogigResponse 
    
  }
}
