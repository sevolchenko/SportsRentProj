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
}
