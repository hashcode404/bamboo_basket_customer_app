// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CalculateTakeAwayDetails {
  CalculateTakeAwayDetails({
    this.cartGrossAmount,
    this.generalData,
    this.discountAmount,
    this.userType,
    this.message,
    this.cartNetAmount,
    this.status,
  });

  final double? cartGrossAmount;
  final GeneralData? generalData;
  final double? discountAmount;
  final String? userType;
  final String? message;
  final double? cartNetAmount;
  final String? status;

  CalculateTakeAwayDetails copyWith({
    double? cartGrossAmount,
    GeneralData? generalData,
    double? discountAmount,
    String? userType,
    String? message,
    double? cartNetAmount,
    String? status,
  }) {
    return CalculateTakeAwayDetails(
      cartGrossAmount: cartGrossAmount ?? this.cartGrossAmount,
      generalData: generalData ?? this.generalData,
      discountAmount: discountAmount ?? this.discountAmount,
      userType: userType ?? this.userType,
      message: message ?? this.message,
      cartNetAmount: cartNetAmount ?? this.cartNetAmount,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cartGrossAmount': cartGrossAmount,
      'generalData': generalData?.toMap(),
      'discountAmount': discountAmount,
      'userType': userType,
      'message': message,
      'cartNetAmount': cartNetAmount,
      'status': status,
    };
  }

  factory CalculateTakeAwayDetails.fromMap(Map<String, dynamic> map) {
    double? parseDouble(dynamic value) {
      if (value is double) return value;
      if (value is int) return value.toDouble();
      return null;
    }

    return CalculateTakeAwayDetails(
      cartGrossAmount: parseDouble(map['cartGrossAmount']),
      generalData: map['generalData'] != null
          ? GeneralData.fromMap(map['generalData'] as Map<String, dynamic>)
          : null,
      discountAmount: parseDouble(map['discountAmount']),
      userType: map['userType'] != null ? map['userType'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      cartNetAmount: parseDouble(map['cartNetAmount']),
      status: map['status'] != null ? map['status'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CalculateTakeAwayDetails.fromJson(String source) =>
      CalculateTakeAwayDetails.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CalculateTakeAwayDetails(cartGrossAmount: $cartGrossAmount, generalData: $generalData, discountAmount: $discountAmount, userType: $userType, message: $message, cartNetAmount: $cartNetAmount, status: $status)';
  }

  @override
  bool operator ==(covariant CalculateTakeAwayDetails other) {
    if (identical(this, other)) return true;

    return other.cartGrossAmount == cartGrossAmount &&
        other.generalData == generalData &&
        other.discountAmount == discountAmount &&
        other.userType == userType &&
        other.message == message &&
        other.cartNetAmount == cartNetAmount &&
        other.status == status;
  }

  @override
  int get hashCode {
    return cartGrossAmount.hashCode ^
        generalData.hashCode ^
        discountAmount.hashCode ^
        userType.hashCode ^
        message.hashCode ^
        cartNetAmount.hashCode ^
        status.hashCode;
  }
}

class GeneralData {
  GeneralData({
    required this.pickupTime,
    required this.takeAwayDiscountPercentage,
    required this.minimumAmtForTakeAwayDiscount,
    required this.shopName,
    required this.shopId,
    required this.takeAway,
    required this.takeAwayTempOff,
  });

  final PickupTime? pickupTime;
  final int? takeAwayDiscountPercentage;
  final int? minimumAmtForTakeAwayDiscount;
  final String? shopName;
  final String? shopId;
  final String? takeAway;
  final String? takeAwayTempOff;

  GeneralData copyWith({
    PickupTime? pickupTime,
    int? takeAwayDiscountPercentage,
    int? minimumAmtForTakeAwayDiscount,
    String? shopName,
    String? shopId,
    String? takeAway,
    String? takeAwayTempOff,
  }) {
    return GeneralData(
      pickupTime: pickupTime ?? this.pickupTime,
      takeAwayDiscountPercentage:
          takeAwayDiscountPercentage ?? this.takeAwayDiscountPercentage,
      minimumAmtForTakeAwayDiscount:
          minimumAmtForTakeAwayDiscount ?? this.minimumAmtForTakeAwayDiscount,
      shopName: shopName ?? this.shopName,
      shopId: shopId ?? this.shopId,
      takeAway: takeAway ?? this.takeAway,
      takeAwayTempOff: takeAwayTempOff ?? this.takeAwayTempOff,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pickupTime': pickupTime?.toMap(),
      'takeAwayDiscountPercentage': takeAwayDiscountPercentage,
      'minimumAmtForTakeAwayDiscount': minimumAmtForTakeAwayDiscount,
      'shopName': shopName,
      'shopId': shopId,
      'takeAway': takeAway,
      'takeAwayTempOff': takeAwayTempOff,
    };
  }

  factory GeneralData.fromMap(Map<String, dynamic> map) {
    return GeneralData(
      pickupTime: map['pickupTime'] != null
          ? PickupTime.fromMap(map['pickupTime'] as Map<String, dynamic>)
          : null,
      takeAwayDiscountPercentage: map['takeAwayDiscountPercentage'] != null
          ? map['takeAwayDiscountPercentage'] as int
          : null,
      minimumAmtForTakeAwayDiscount:
          map['minimumAmtForTakeAwayDiscount'] != null
              ? map['minimumAmtForTakeAwayDiscount'] as int
              : null,
      shopName: map['shopName'] != null ? map['shopName'] as String : null,
      shopId: map['shopId'] != null ? map['shopId'] as String : null,
      takeAway: map['takeAway'] != null ? map['takeAway'] as String : null,
      takeAwayTempOff: map['takeAwayTempOff'] != null
          ? map['takeAwayTempOff'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GeneralData.fromJson(String source) =>
      GeneralData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GeneralData(pickupTime: $pickupTime, takeAwayDiscountPercentage: $takeAwayDiscountPercentage, minimumAmtForTakeAwayDiscount: $minimumAmtForTakeAwayDiscount, shopName: $shopName, shopId: $shopId, takeAway: $takeAway, takeAwayTempOff: $takeAwayTempOff)';
  }

  @override
  bool operator ==(covariant GeneralData other) {
    if (identical(this, other)) return true;

    return other.pickupTime == pickupTime &&
        other.takeAwayDiscountPercentage == takeAwayDiscountPercentage &&
        other.minimumAmtForTakeAwayDiscount == minimumAmtForTakeAwayDiscount &&
        other.shopName == shopName &&
        other.shopId == shopId &&
        other.takeAway == takeAway &&
        other.takeAwayTempOff == takeAwayTempOff;
  }

  @override
  int get hashCode {
    return pickupTime.hashCode ^
        takeAwayDiscountPercentage.hashCode ^
        minimumAmtForTakeAwayDiscount.hashCode ^
        shopName.hashCode ^
        shopId.hashCode ^
        takeAway.hashCode ^
        takeAwayTempOff.hashCode;
  }
}

class PickupTime {
  PickupTime({
    this.valid,
    this.currentTime,
    this.pickupTime,
  });

  final String? valid;
  final DateTime? currentTime;
  final DateTime? pickupTime;

  PickupTime copyWith({
    String? valid,
    DateTime? currentTime,
    DateTime? pickupTime,
  }) {
    return PickupTime(
      valid: valid ?? this.valid,
      currentTime: currentTime ?? this.currentTime,
      pickupTime: pickupTime ?? this.pickupTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'valid': valid,
      'currentTime': currentTime?.millisecondsSinceEpoch,
      'pickupTime': pickupTime?.millisecondsSinceEpoch,
    };
  }

  factory PickupTime.fromMap(Map<String, dynamic> map) {
    return PickupTime(
      valid: map['valid'] != null ? map['valid'] as String : null,
      currentTime: map['currentTime'] != null
          ? DateTime.parse(map['currentTime'])
          : null,
      pickupTime:
          map['pickupTime'] != null ? DateTime.parse(map['pickupTime']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PickupTime.fromJson(String source) =>
      PickupTime.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PickupTime(valid: $valid, currentTime: $currentTime, pickupTime: $pickupTime)';

  @override
  bool operator ==(covariant PickupTime other) {
    if (identical(this, other)) return true;

    return other.valid == valid &&
        other.currentTime == currentTime &&
        other.pickupTime == pickupTime;
  }

  @override
  int get hashCode =>
      valid.hashCode ^ currentTime.hashCode ^ pickupTime.hashCode;
}
