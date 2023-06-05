import 'package:client/api/apis/rent_api.dart';
import 'package:client/api/dto/response/receipt.dart';
import 'package:client/api/dto/response/rent/rent.dart';
import 'package:client/api/dto/response/user/user.dart';

class RentRepository {
  final RentApi _rentApi = RentApi();

  Future<List<RentResponse>> getMyOngRents(Map<String, dynamic> query) async {
    return await _rentApi.getMyRents(query);
  }

  Future<List<RentResponse>> getUserOngRents(int userId, Map<String, dynamic> query) async {
    return await _rentApi.getRentsByUserId(userId, query);
  }

  Future<void> finishUserRentById(int userId, int rentId) async {
    await _rentApi.finishRentByUserIdRentId(userId, rentId, {});
  }

  Future<List<RentResponse>?> finishUserRents(int userId, Map<String, dynamic> body) async {
    return await _rentApi.finishRentsByUserId(userId, body);
  }

  Future<ReceiptResponse?> getMyReceipt(int receiptId) async {
    return await _rentApi.getMyReceipt(receiptId);
  }

  Future<void> prolongRent(int rentId, Map<String, dynamic> body) async {
    await _rentApi.prolongRentByRentId(rentId, body);
  }

  Future<void> startRent(Map<String, dynamic> body) async {
    await _rentApi.startRent(body);
  }

  Future<void> startRents(Map<String, dynamic> body) async {
    await _rentApi.startBatchRents(body);
  }

  Future<UserResponse?> getUserData(Map<String, dynamic> query) async {
    return await _rentApi.userData(query);
  }
}
