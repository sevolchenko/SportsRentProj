import 'package:client/api/dto/response/user/user.dart';

class ReceiptResponse {
  final String receiptId;
  final UserResponse user;
  final UserResponse employee;
  final String payLink;
  final String createdAt;
  final int sum;
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
      user: json['user'] = UserResponse.fromJson(json['user']),
      employee: json['employee'] = UserResponse.fromJson(json['employee']),       
      payLink: json['pay_link'],     
      createdAt: json['created_at'],
      sum: json['sum'],
      status: json['status'],  
    );
  }
}
