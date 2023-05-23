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


class ImageListResponse {
  final List<ImageResponse> images;
  final int size;

  ImageListResponse({
    required this.images,
    required this.size,
  });

  factory ImageListResponse.fromJson(Map<String, dynamic> json) {
    return ImageListResponse(
        images: json['images'] = List<ImageResponse>.from(
            json['images'].map((x) => ImageResponse.fromJson(x))),
        size: json['size']);
  }
}