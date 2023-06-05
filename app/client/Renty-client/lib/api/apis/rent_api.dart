import 'package:client/api/dto/response/receipt.dart';
import 'package:client/api/dto/response/rent/rent.dart';
import 'package:client/api/dto/response/user/user.dart';
import 'package:client/common/utils/http_util.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:dio/dio.dart';

class RentApi {
  Future<List<RentResponse>> getMyRents(Map<String, dynamic> query) async {
    var path = 'rents/my';
    try {
      var response = await HttpUtil().get(path, queryParameters: query);
      var jsonData = response.data;
      var res = List<RentResponse>.from(
          jsonData.map((x) => RentResponse.fromJson(x)));
      return res;
    } on DioError catch (e) {
      toastInfo(msg: "Ошибка при получении аренд");
    }
    return [];
  }

  Future<List<RentResponse>> getRentsByUserId(
      int userId, Map<String, dynamic> query) async {
    var path = 'rents/${userId}';
    try {
      var response = await HttpUtil().get(path, queryParameters: query);
      var jsonData = response.data;
      var res = List<RentResponse>.from(
          jsonData.map((x) => RentResponse.fromJson(x)));
      return res;
    } on DioError catch (e) {
      toastInfo(msg: "Ошибка при получении аренд");
    }
    return [];
  }

  Future<int?> finishRentByUserIdRentId(
      int userId, int rentId, Map<String, dynamic> body) async {
    var path = 'rents/${userId}/${rentId}/finish';
    var statusCode = await HttpUtil().patch(path, body);
    try {
      if (statusCode == 200) {
        toastInfo(msg: "Аренда успешно завершена");
        return statusCode;
      } else {
        toastInfo(msg: "Ошибка при завершении аренды");
      }
    } on DioError catch (e) {}
    return null;
  }

  Future<List<RentResponse>?> finishRentsByUserId(
      int userId, Map<String, dynamic> body) async {
    var path = 'rents/${userId}/finish/batch';
    var response = await HttpUtil().patchWithResponse(path, body);
    try {
      if (response.statusCode == 200) {
        toastInfo(msg: "Аренды успешно завершены");
        return response;
      } else {
        toastInfo(msg: "Ошибка при завершении аренд");
      }
    } on DioError catch (e) {}
    return null;
  }

  Future<ReceiptResponse?> getMyReceipt(int receiptId) async {
    var path = 'receipts/my/${receiptId}';
    var response = await HttpUtil().get(path);
    try {
      if (response.statusCode == 200) {
        toastInfo(msg: "Чек получен");
        return response;
      } else {
        toastInfo(msg: "Ошибка при получении чека");
      }
    } on DioError catch (e) {}
    return null;
  }

  Future<int?> prolongRentByRentId(
      int rentId, Map<String, dynamic> body) async {
    var path = 'rents/my/${rentId}/prolong';
    var statusCode = await HttpUtil().patch(path, body);
    try {
      if (statusCode == 200) {
        toastInfo(msg: "Аренда продлена");
        return statusCode;
      } else {
        toastInfo(msg: "Ошибка при продлении аренды");
      }
    } on DioError catch (e) {}
    return null;
  }

  Future<int?> startRent(Map<String, dynamic> body) async {
    var path = 'rents/my/start';
    try {
      var statusCode = await HttpUtil().post(path, data: body);
      if (statusCode == 200) {
        toastInfo(msg: "Аренда успешно началась");
        return statusCode;
      }
      // else else {
      //   toastInfo(msg: "Ошибка при старте аренды");
      // }{
      //   toastInfo(msg: "Ошибка при старте аренды");
      // }
    } on DioError catch (e) {
      toastInfo(msg: "Ошибка при старте аренды");
    }
    return null;
  }

  Future<int?> startBatchRents(Map<String, dynamic> body) async {
    var path = 'rents/my/start/batch';
    var statusCode = await HttpUtil().post(path, data: body);
    try {
      if (statusCode == 200) {
        return statusCode;
      }
      //  else {
      //   toastInfo(msg: "Ошибка при старте нескольких аренд");
      // }
    } on DioError catch (e) {
      toastInfo(msg: "Ошибка при старте нескольких аренд");
    }
    return null;
  }

  Future<UserResponse?> userData(Map<String, dynamic> query) async {
    try {
      var path = 'users/search';
      var response = await HttpUtil().get(path, queryParameters: query);
      var jsonData = response.data;
      var res = UserResponse.fromJson(jsonData);
      return res;
    } on DioError catch (e) {
      toastInfo(msg: "Ошибка получении данных пользователя");
    }
    return null;
  }
}
