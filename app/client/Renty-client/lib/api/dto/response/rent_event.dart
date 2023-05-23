
class RentEventResponse {
  final int id;
  final int userId;
  // final ProductPreviewResponse productPreview;
  final int count;
  final int price;
  final String createdAt;
  final String startTime;
  final String endTine;
  final String status;

  RentEventResponse({
    required this.id,
    required this.userId,
    // required this.productPreview,
    required this.count,
    required this.price,
    required this.createdAt,
    required this.startTime,
    required this.endTine,
    required this.status,
  });

  factory RentEventResponse.fromJson(Map<String, dynamic> json) {
    return RentEventResponse(
      id: json['rent_id'],
      userId: json['user_id'],
      // productPreview: json['product_preview'],
      count: json['count'],
      price: json['price'],
      createdAt: json['created_at'],
      startTime: json['start_time'],
      endTine: json['end_time'],
      status: json['status'],
    );
  }
}

class ListRentEventsResponse {
  final List<RentEventResponse> rents;
  final int size;

  ListRentEventsResponse({
    required this.rents,
    required this.size,
  });

  factory ListRentEventsResponse.fromJson(Map<String, dynamic> json) {
    return ListRentEventsResponse(
      rents: json['rents'],
      size: json['size'],
    );
  }
}
