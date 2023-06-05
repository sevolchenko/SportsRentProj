class ReceiptResponse {
  final int receiptId;
  final int user;
  final int employee;
  final String payLink;
  final String createdAt;
  final double sum;
  final String status;

  ReceiptResponse({
    required this.receiptId,
    required this.user,
    required this.employee,
    required this.payLink,
    required this.createdAt,
    required this.sum,
    required this.status,
  });

  factory ReceiptResponse.fromJson(Map<String, dynamic> json) {
    return ReceiptResponse(
      receiptId: json['receipt_id'],
      user: json['user'],
      employee: json['employee'],
      payLink: json['pay_link'],
      createdAt: json['created_at'],
      sum: json['sum'],
      status: json['status'],
    );
  }
}
