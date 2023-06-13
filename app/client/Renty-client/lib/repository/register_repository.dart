import 'package:client/api/apis/register_api.dart';

class RegisterRepository {
  final RegisterApi _registerApi = RegisterApi();


  Future<int?> registerUser(Map<String, dynamic> body) async {
    return await _registerApi.register(body);
  }
}