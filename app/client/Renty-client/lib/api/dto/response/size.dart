class SizeResponse {
  final int productId;
  final String sizeName;
  final int total;
  final int countAvailableNow;

  SizeResponse(
      {required this.productId,
      required this.sizeName,
      required this.total,
      required this.countAvailableNow});

  factory SizeResponse.fromJson(Map<String, dynamic> json) {
    return SizeResponse(
        productId: json['product_id'],
        sizeName: json['size_name'],
        total: json['total'],
        countAvailableNow: json['count_available_now']);
  }
}

class SizeListResponse {
  final List<SizeResponse> sizes;
  final int size;

  SizeListResponse({
    required this.sizes,
    required this.size,
  });

  factory SizeListResponse.fromJson(Map<String, dynamic> json) {
    return SizeListResponse(
      sizes: json['sizes'] = List<SizeResponse>.from(
          json['sizes'].map((x) => SizeResponse.fromJson(x))),
      size: json['size'],
    );
  }
}
