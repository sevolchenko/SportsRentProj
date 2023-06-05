class ReceiptItemResponse {
  final int productId;
  final double number;
  final int price;
  final bool isRent;

  ReceiptItemResponse(
      {required this.productId,
      required this.number,
      required this.price,
      required this.isRent});

  factory ReceiptItemResponse.fromJson(Map<String, dynamic> json) {
    return ReceiptItemResponse(
        productId: json['product_id'],
        number: json['number'],
        price: json['integer'],
        isRent: json['isRent']);
  }
}