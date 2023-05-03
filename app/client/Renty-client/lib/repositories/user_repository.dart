import 'dart:convert';
import 'package:client/models/user_model.dart';
import 'package:http/http.dart';

class UserRepository {
  String endpoint = '';
  Future<List<UserModel>> getusers() async {
    Response response = await get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      final List users = jsonDecode(response.body)['data'];
      return users.map(((e) => UserModel.fromJson(e))).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
