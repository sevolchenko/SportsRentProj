class StartRentEventRequest {
  final int productId;
  final String sizeName;
  final int count;
  final String startTime;
  final String endTime;

  StartRentEventRequest(
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

  factory StartRentEventRequest.fromJson(Map<String, dynamic> json) {
    return StartRentEventRequest(
        productId: json['product_id'],
        sizeName: json['size_name'],
        count: json['count'],
        startTime: json['start_time'],
        endTime: json['end_time']);
  }
}
