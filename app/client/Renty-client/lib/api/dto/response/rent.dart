import 'package:client/api/dto/response/product_preview.dart';
import 'package:client/api/dto/response/size.dart';
import 'package:client/api/dto/response/user/user.dart';

class RentResponse {
  final int rentId;
  final String startTime;
  final String endTime;
  final String? finishedAt;
  final UserResponse user;
  final String exceptedDuration;
  final String prettyDuration;
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
      required this.exceptedDuration,
      required this.prettyDuration,
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
      exceptedDuration: json['exceptedDuration'],
      prettyDuration: json['prettyDuration'],
      product: json['product'] =
          ProductPreviewResponse.fromJson(json['product']),
      size: json['size'] = SizeResponse.fromJson(json['size']),
      count: json['count'],
      price: json['price'],
      status: json['status'],
    );
  }
}

class ExceptedDuration {
  final int seconds;
  final int nano;
  final bool negative;
  final bool zero;
  final List<Units> units;
  ExceptedDuration(
      {required this.seconds,
      required this.nano,
      required this.negative,
      required this.zero,
      required this.units});
  factory ExceptedDuration.fromJson(Map<String, dynamic> json) {
    return ExceptedDuration(
        seconds: json['seconds'],
        nano: json['nano'],
        negative: json['negative'],
        zero: json['zero'],
        units: json['units'] =
            List<Units>.from(json['units'].map((x) => Units.fromJson(x))));
  }
}

class Units {
  final bool dateBased;
  final bool timeBased;
  final bool durationEstimated;
  Units(
      {required this.dateBased,
      required this.timeBased,
      required this.durationEstimated});
  factory Units.fromJson(Map<String, dynamic> json) {
    return Units(
        dateBased: json['dataBased'],
        timeBased: json['timeBased'],
        durationEstimated: json['durationEstimated']);
  }
}
