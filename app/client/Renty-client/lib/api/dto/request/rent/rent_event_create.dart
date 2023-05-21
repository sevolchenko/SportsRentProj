class RentEventCreateRequest {
  final int productId;
  final String sizeName;
  final int count;
  final String startTime;
  final String endTime;

  RentEventCreateRequest(
      {required this.productId,
      required this.sizeName,
      required this.count,
      required this.startTime,
      required this.endTime});

  Map<String, dynamic> toJson() => {
        'product_id': productId,
        'size_name': sizeName,
        'count': count,
        'start_time': startTime,
        'end_time': endTime,
      };
}

class ListRentEventCreateRequest {
  final List<RentEventCreateRequest> rents;
  final int size;

  ListRentEventCreateRequest({
    required this.rents,
    required this.size,
  });

  Map<String, dynamic> toJson() => {
        'rents': rents,
        'size': size,
      };
}
