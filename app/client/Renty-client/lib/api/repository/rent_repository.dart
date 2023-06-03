import 'package:client/api/apis/rent_api.dart';
import 'package:client/api/dto/response/rent.dart';

class RentRepository {
  final RentApi _rentApi = RentApi();

  Future<List<RentResponse>> getMyOngRents() async {
    return await _rentApi.getMyOngoingRents();
  }

  Future<List<RentResponse>> getUserOngRents(int userId) async {
    return await _rentApi.getOngoingRentsByUserId(userId);
  }

  Future<void> finishUserRentById(int userId, int rentId) async {
    await _rentApi.finishRentByUserIdRentId(userId, rentId, {});
  }

  Future<void> finishUserRents(int userId) async {
    await _rentApi.finishRentsByUserId(userId, {});
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
}
