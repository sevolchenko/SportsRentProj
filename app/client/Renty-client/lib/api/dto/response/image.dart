class ImageResponse {
  final int productId;
  final int position;
  final String image;

  ImageResponse({required this.productId, required this.position, required this.image});

  factory  ImageResponse.fromJson(Map<String, dynamic> json) {
    return ImageResponse(
        productId: json['product_id'], position: json['position'], image: json['image']);
  }
}
