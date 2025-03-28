import 'dart:convert';

TableReservationDetails tableReservationDetailsFromJson(String str) =>
    TableReservationDetails.fromJson(json.decode(str));

String tableReservationDetailsToJson(TableReservationDetails data) =>
    json.encode(data.toJson());

class TableReservationDetails {
  TableReservationDetails({
    this.advanceAmount,
    this.formattedId,

    this.shopMessage,
    this.advancePayment,
    this.chairs,
    this.id,
    this.email,
    this.bookingTime,
    this.message,

    this.phone,
    this.name,
    this.addedTime,
    this.shopID,
    this.status,
    this.amountStatus,
    this.paymentMethod, 
  });

  final String? id;
  final String? formattedId;
  final String? shopID;
  final String? name;
  final String? phone;
  final String? email;
  final String? chairs;
  final String? message;
  final String? status;
  final String? shopMessage;
  final DateTime? bookingTime;
  final DateTime? addedTime;
  final String? advancePayment;
  final String? advanceAmount;
  final String? amountStatus;
final String? paymentMethod;


  factory TableReservationDetails.fromJson(Map<dynamic, dynamic> json) =>
      TableReservationDetails(
        paymentMethod: json["paymentMethod"],
        advanceAmount: json["advanceAmount"],
        formattedId: json["formattedID"],
     
        shopMessage: json["shopMessage"],
        advancePayment: json["advancePayment"],
        chairs: json["chairs"],
        id: json["id"],
        email: json["email"],
        bookingTime: DateTime.parse(json["bookingTime"]),
        message: json["message"],
     
        phone: json["phone"],
        name: json["name"],
        addedTime: DateTime.parse(json["addedTime"]),
        shopID: json["shopID"],
        status: json["status"],
        amountStatus: json["amountStatus"],
      );

  Map<dynamic, dynamic> toJson() => {
    "paymentMethod": paymentMethod,
        "advanceAmount": advanceAmount,
        "formattedID": formattedId,
      
        "shopMessage": shopMessage,
        "advancePayment": advancePayment,
        "chairs": chairs,
        "id": id,
        "email": email,
        "bookingTime": bookingTime?.toIso8601String(),
        "message": message,
        
        "phone": phone,
        "name": name,
        "addedTime": addedTime?.toIso8601String(),
        "status": status,
        "amountStatus": amountStatus,
      };
}
