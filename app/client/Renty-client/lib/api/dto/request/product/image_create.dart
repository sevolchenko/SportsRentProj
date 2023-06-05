class ImageCreateRequest {
  int position;
  String image;

  ImageCreateRequest({required this.position, required this.image});

  Map<String, dynamic> toJson() => {
        'position': position,
        'image': image,
      };
}
