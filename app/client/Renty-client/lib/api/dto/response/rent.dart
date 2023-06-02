import 'package:client/api/dto/response/product_preview.dart';
import 'package:client/api/dto/response/size.dart';
import 'package:client/api/dto/response/user/user.dart';

class RentResponse {
  final int rentId;
  final String startTime;
  final String endTime;
  final String? finishedAt;
  final UserResponse user;
  final ProductPreviewResponse product;
  final SizeResponse size;
  final int count;
  final int price;
  final String status;

  RentResponse(
      {required this.rentId,
      required this.startTime,
      required this.endTime,
      required this.finishedAt,
      required this.user,
      required this.product,
      required this.size,
      required this.count,
      required this.price,
      required this.status});

  factory RentResponse.fromJson(Map<String, dynamic> json) {
    return RentResponse(
      rentId: json['rent_id'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      finishedAt: json['finished_at'],
      user: json['user'] = UserResponse.fromJson(json['user']),
      product: json['product'] = ProductPreviewResponse.fromJson(json['product']),
      size: json['size'] = SizeResponse.fromJson(json['size']),
      count: json['count'],
      price: json['price'],
      status: json['status'],
    );
  }
}
