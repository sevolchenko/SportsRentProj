class ReceiptItemResponse {
  final int receiptId;
  final int userId;
  final int employeeId;
  final String payLink;
  final String createdAt;
  final List<ReceiptItemResponse> items;
  final double sum;
  final String status;

  ReceiptItemResponse({
    required this.receiptId,
    required this.userId,
    required this.employeeId,
    required this.payLink,
    required this.createdAt,
    required this.items,
    required this.sum,
    required this.status,
  });

  factory ReceiptItemResponse.fromJson(Map<String, dynamic> json) {
    return ReceiptItemResponse(
      receiptId: json['product_id'],
      userId: json['user_id'],
      employeeId: json['employee_id'],
      payLink: json['pay_link'],
      createdAt: json['created_at'],
      items: json['items'],
      sum: json['sum'],
      status: json['status'],
    );
  }
}
