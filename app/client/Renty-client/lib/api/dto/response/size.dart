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

class ListSizesResponse {
  final List<SizeResponse> sizes;
  final int size;

  ListSizesResponse({
    required this.sizes,
    required this.size,
  });

  factory ListSizesResponse.fromJson(Map<String, dynamic> json) {
    return ListSizesResponse(
      sizes: json['sizes'],
      size: json['size'],
    );
  }
}
