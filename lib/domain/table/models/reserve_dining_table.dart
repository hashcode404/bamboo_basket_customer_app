import 'dart:convert';

ReserveDiningTable reserveDiningTableFromJson(String str) =>
    ReserveDiningTable.fromJson(json.decode(str));

String reserveDiningTableToJson(ReserveDiningTable data) =>
    json.encode(data.toJson());

class ReserveDiningTable {
  ReserveDiningTable({
    required this.userID,
    required this.advanceAmount,
    required this.totalChair,
    required this.reservationDateTime,
    required this.source,
    required this.message,
    required this.transactionId,
    required this.baseUrl,
    required this.phone,
    required this.advancePayment,
    required this.name,
    required this.paymentMethod,
    required this.shopId,
    required this.email,
  });

  final String advanceAmount;
  final String userID;
  final int totalChair;
  final DateTime reservationDateTime;
  final String source;
  final String message;
  final String transactionId;
  final String baseUrl;
  final String phone;
  final String advancePayment;
  final String name;
  final String paymentMethod;
  final String shopId;
  final String email;

  factory ReserveDiningTable.fromJson(Map<dynamic, dynamic> json) =>
      ReserveDiningTable(
        userID: json["userID"],
        advanceAmount: json["advanceAmount"],
        totalChair: json["totalChair"],
        reservationDateTime: DateTime.parse(json["reservationDateTime"]),
        source: json["source"],
        message: json["message"],
        transactionId: json["transactionID"],
        baseUrl: json["baseUrl"],
        phone: json["phone"],
        advancePayment: json["advancePayment"],
        name: json["name"],
        paymentMethod: json["paymentMethod"],
        shopId: json["shopID"],
        email: json["email"],
      );

  Map<dynamic, dynamic> toJson() => {
        "userID": userID,
        "advanceAmount": advanceAmount,
        "totalChair": totalChair,
        "reservationDateTime": reservationDateTime.toIso8601String(),
        "source": source,
        "message": message,
        "transactionID": transactionId,
        "baseUrl": baseUrl,
        "phone": phone,
        "advancePayment": advancePayment,
        "name": name,
        "paymentMethod": paymentMethod,
        "shopID": shopId,
        "email": email,
      };
}
