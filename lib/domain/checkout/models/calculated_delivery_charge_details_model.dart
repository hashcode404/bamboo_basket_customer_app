// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CalculatedDeliveryChargeDetailsModel {
  final String? message;
  final String? status;
  final String? userType;
  final double? cart_GrossAmount;
  final double? discountAmount;
  final double? cart_NetAmount;
  final int? deliveryFeeAmount;
  final DeliveryFeeGeneralData? generalData;
  final DeliveryFeeDeliverySettings? calculatedDeliverySettings;

  CalculatedDeliveryChargeDetailsModel({
    this.message,
    this.status,
    this.userType,
    this.cart_GrossAmount,
    this.discountAmount,
    this.cart_NetAmount,
    this.deliveryFeeAmount,
    this.generalData,
    this.calculatedDeliverySettings,
  });

  CalculatedDeliveryChargeDetailsModel copyWith({
    String? message,
    String? status,
    String? userType,
    double? cart_GrossAmount,
    double? discountAmount,
    double? cart_NetAmount,
    int? deliveryFeeAmount,
    DeliveryFeeGeneralData? generalData,
    DeliveryFeeDeliverySettings? calculatedDeliverySettings,
  }) {
    return CalculatedDeliveryChargeDetailsModel(
      message: message ?? this.message,
      status: status ?? this.status,
      userType: userType ?? this.userType,
      cart_GrossAmount: cart_GrossAmount ?? this.cart_GrossAmount,
      discountAmount: discountAmount ?? this.discountAmount,
      cart_NetAmount: cart_NetAmount ?? this.cart_NetAmount,
      deliveryFeeAmount: deliveryFeeAmount ?? this.deliveryFeeAmount,
      generalData: generalData ?? this.generalData,
      calculatedDeliverySettings:
          calculatedDeliverySettings ?? this.calculatedDeliverySettings,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'status': status,
      'userType': userType,
      'cart_GrossAmount': cart_GrossAmount,
      'discountAmount': discountAmount,
      'cart_NetAmount': cart_NetAmount,
      'deliveryFeeAmount': deliveryFeeAmount,
      'generalData': generalData?.toMap(),
      'calculatedDeliverySettings': calculatedDeliverySettings?.toMap(),
    };
  }

  factory CalculatedDeliveryChargeDetailsModel.fromMap(
      Map<String, dynamic> map) {
    return CalculatedDeliveryChargeDetailsModel(
      message: map['message'] != null ? map['message'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      userType: map['userType'] != null ? map['userType'] as String : null,
      cart_GrossAmount: map['cart_GrossAmount'] != null
          ? double.tryParse(map['cart_GrossAmount'].toString())
          : null,
      discountAmount: map['discountAmount'] != null
          ? double.tryParse(map['discountAmount'].toString())
          : null,
      cart_NetAmount: map['cart_NetAmount'] != null
          ? double.tryParse(map['cart_NetAmount'].toString())
          : null,
      deliveryFeeAmount: map['deliveryFeeAmount'] != null
          ? map['deliveryFeeAmount'] as int
          : null,
      generalData: map['generalData'] != null
          ? DeliveryFeeGeneralData.fromMap(
              map['generalData'] as Map<String, dynamic>)
          : null,
      calculatedDeliverySettings: map['calculatedDeliverySettings'] != null
          ? DeliveryFeeDeliverySettings.fromMap(
              map['calculatedDeliverySettings'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CalculatedDeliveryChargeDetailsModel.fromJson(String source) =>
      CalculatedDeliveryChargeDetailsModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CalculatedDeliveryChargeDetailsModel(message: $message, status: $status, userType: $userType, cart_GrossAmount: $cart_GrossAmount, discountAmount: $discountAmount, cart_NetAmount: $cart_NetAmount, deliveryFeeAmount: $deliveryFeeAmount, generalData: $generalData, calculatedDeliverySettings: $calculatedDeliverySettings)';
  }

  @override
  bool operator ==(covariant CalculatedDeliveryChargeDetailsModel other) {
    if (identical(this, other)) return true;

    return other.message == message &&
        other.status == status &&
        other.userType == userType &&
        other.cart_GrossAmount == cart_GrossAmount &&
        other.discountAmount == discountAmount &&
        other.cart_NetAmount == cart_NetAmount &&
        other.deliveryFeeAmount == deliveryFeeAmount &&
        other.generalData == generalData &&
        other.calculatedDeliverySettings == calculatedDeliverySettings;
  }

  @override
  int get hashCode {
    return message.hashCode ^
        status.hashCode ^
        userType.hashCode ^
        cart_GrossAmount.hashCode ^
        discountAmount.hashCode ^
        cart_NetAmount.hashCode ^
        deliveryFeeAmount.hashCode ^
        generalData.hashCode ^
        calculatedDeliverySettings.hashCode;
  }
}

class DeliveryFeeGeneralData {
  final String? shopID;
  final String? shopName;
  final String? sourcePostCode;
  final String? destinationPostCode;
  final String? distance;
  final int? calibratedDistance;
  final String? duration;
  final int? cartItemsCount;
  final int? discountPercentage;

  DeliveryFeeGeneralData({
    this.shopID,
    this.shopName,
    this.sourcePostCode,
    this.destinationPostCode,
    this.distance,
    this.calibratedDistance,
    this.duration,
    this.cartItemsCount,
    this.discountPercentage,
  });

  DeliveryFeeGeneralData copyWith({
    String? shopID,
    String? shopName,
    String? sourcePostCode,
    String? destinationPostCode,
    String? distance,
    int? calibratedDistance,
    String? duration,
    int? cartItemsCount,
    int? discountPercentage,
  }) {
    return DeliveryFeeGeneralData(
      shopID: shopID ?? this.shopID,
      shopName: shopName ?? this.shopName,
      sourcePostCode: sourcePostCode ?? this.sourcePostCode,
      destinationPostCode: destinationPostCode ?? this.destinationPostCode,
      distance: distance ?? this.distance,
      calibratedDistance: calibratedDistance ?? this.calibratedDistance,
      duration: duration ?? this.duration,
      cartItemsCount: cartItemsCount ?? this.cartItemsCount,
      discountPercentage: discountPercentage ?? this.discountPercentage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'shopID': shopID,
      'shopName': shopName,
      'sourcePostCode': sourcePostCode,
      'destinationPostCode': destinationPostCode,
      'distance': distance,
      'calibratedDistance': calibratedDistance,
      'duration': duration,
      'cartItemsCount': cartItemsCount,
      'discountPercentage': discountPercentage,
    };
  }

  factory DeliveryFeeGeneralData.fromMap(Map<String, dynamic> map) {
    return DeliveryFeeGeneralData(
      shopID: map['shopID'] != null ? map['shopID'] as String : null,
      shopName: map['shopName'] != null ? map['shopName'] as String : null,
      sourcePostCode: map['sourcePostCode'] != null
          ? map['sourcePostCode'] as String
          : null,
      destinationPostCode: map['destinationPostCode'] != null
          ? map['destinationPostCode'] as String
          : null,
      distance: map['distance'] != null ? map['distance'] as String : null,
      calibratedDistance: map['calibratedDistance'] != null
          ? map['calibratedDistance'] as int
          : null,
      duration: map['duration'] != null ? map['duration'] as String : null,
      cartItemsCount:
          map['cartItemsCount'] != null ? map['cartItemsCount'] as int : null,
      discountPercentage: map['discountPercentage'] != null
          ? map['discountPercentage'] as int
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeliveryFeeGeneralData.fromJson(String source) =>
      DeliveryFeeGeneralData.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CalculateDeliveryFeeGeneralDataModel(shopID: $shopID, shopName: $shopName, sourcePostCode: $sourcePostCode, destinationPostCode: $destinationPostCode, distance: $distance, calibratedDistance: $calibratedDistance, duration: $duration, cartItemsCount: $cartItemsCount, discountPercentage: $discountPercentage)';
  }

  @override
  bool operator ==(covariant DeliveryFeeGeneralData other) {
    if (identical(this, other)) return true;

    return other.shopID == shopID &&
        other.shopName == shopName &&
        other.sourcePostCode == sourcePostCode &&
        other.destinationPostCode == destinationPostCode &&
        other.distance == distance &&
        other.calibratedDistance == calibratedDistance &&
        other.duration == duration &&
        other.cartItemsCount == cartItemsCount &&
        other.discountPercentage == discountPercentage;
  }

  @override
  int get hashCode {
    return shopID.hashCode ^
        shopName.hashCode ^
        sourcePostCode.hashCode ^
        destinationPostCode.hashCode ^
        distance.hashCode ^
        calibratedDistance.hashCode ^
        duration.hashCode ^
        cartItemsCount.hashCode ^
        discountPercentage.hashCode;
  }
}

class DeliveryFeeDeliverySettings {
  final String? fixedDeliveryCharges;
  final String? freeDelivery;
  final int? calibratedDistance;
  final int? freeDeliveryRadius;
  final double? maxDeliveryRadius;
  final int? ratePerMile;
  final String? deliveryChargeType;
  final int? freeDeliveryMinOrder;
  final String? calculateNormalDeliveryFee;

  DeliveryFeeDeliverySettings({
    this.fixedDeliveryCharges,
    this.freeDelivery,
    this.calibratedDistance,
    this.freeDeliveryRadius,
    this.maxDeliveryRadius,
    this.ratePerMile,
    this.deliveryChargeType,
    this.freeDeliveryMinOrder,
    this.calculateNormalDeliveryFee,
  });

  DeliveryFeeDeliverySettings copyWith({
    String? fixedDeliveryCharges,
    String? freeDelivery,
    int? calibratedDistance,
    int? freeDeliveryRadius,
    double? maxDeliveryRadius,
    int? ratePerMile,
    String? deliveryChargeType,
    int? freeDeliveryMinOrder,
    String? calculateNormalDeliveryFee,
  }) {
    return DeliveryFeeDeliverySettings(
      fixedDeliveryCharges: fixedDeliveryCharges ?? this.fixedDeliveryCharges,
      freeDelivery: freeDelivery ?? this.freeDelivery,
      calibratedDistance: calibratedDistance ?? this.calibratedDistance,
      freeDeliveryRadius: freeDeliveryRadius ?? this.freeDeliveryRadius,
      maxDeliveryRadius: maxDeliveryRadius ?? this.maxDeliveryRadius,
      ratePerMile: ratePerMile ?? this.ratePerMile,
      deliveryChargeType: deliveryChargeType ?? this.deliveryChargeType,
      freeDeliveryMinOrder: freeDeliveryMinOrder ?? this.freeDeliveryMinOrder,
      calculateNormalDeliveryFee:
          calculateNormalDeliveryFee ?? this.calculateNormalDeliveryFee,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fixedDeliveryCharges': fixedDeliveryCharges,
      'freeDelivery': freeDelivery,
      'calibratedDistance': calibratedDistance,
      'freeDeliveryRadius': freeDeliveryRadius,
      'maxDeliveryRadius': maxDeliveryRadius,
      'ratePerMile': ratePerMile,
      'deliveryChargeType': deliveryChargeType,
      'freeDeliveryMinOrder': freeDeliveryMinOrder,
      'calculateNormalDeliveryFee': calculateNormalDeliveryFee,
    };
  }

  factory DeliveryFeeDeliverySettings.fromMap(Map<String, dynamic> map) {
    return DeliveryFeeDeliverySettings(
      fixedDeliveryCharges: map['fixedDeliveryCharges'] != null
          ? map['fixedDeliveryCharges'] as String
          : null,
      freeDelivery:
          map['freeDelivery'] != null ? map['freeDelivery'] as String : null,
      calibratedDistance: map['calibratedDistance'] != null
          ? map['calibratedDistance'] as int
          : null,
      freeDeliveryRadius: map['freeDeliveryRadius'] != null
          ? map['freeDeliveryRadius'] as int
          : null,
      maxDeliveryRadius: map['maxDeliveryRadius'] != null
          ? map["maxDeliveryRadius"] is int
              ? (map["maxDeliveryRadius"] as int).toDouble()
              : map["maxDeliveryRadius"]
          : null,
      ratePerMile:
          map['ratePerMile'] != null ? map['ratePerMile'] as int : null,
      deliveryChargeType: map['deliveryChargeType'] != null
          ? map['deliveryChargeType'] as String
          : null,
      freeDeliveryMinOrder: map['freeDeliveryMinOrder'] != null
          ? map['freeDeliveryMinOrder'] as int
          : null,
      calculateNormalDeliveryFee: map['calculateNormalDeliveryFee'] != null
          ? map['calculateNormalDeliveryFee'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeliveryFeeDeliverySettings.fromJson(String source) =>
      DeliveryFeeDeliverySettings.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CalculateDeliveryFeeDeliverySettingsDataModel(fixedDeliveryCharges: $fixedDeliveryCharges, freeDelivery: $freeDelivery, calibratedDistance: $calibratedDistance, freeDeliveryRadius: $freeDeliveryRadius, maxDeliveryRadius: $maxDeliveryRadius, ratePerMile: $ratePerMile, deliveryChargeType: $deliveryChargeType, freeDeliveryMinOrder: $freeDeliveryMinOrder, calculateNormalDeliveryFee: $calculateNormalDeliveryFee)';
  }

  @override
  bool operator ==(covariant DeliveryFeeDeliverySettings other) {
    if (identical(this, other)) return true;

    return other.fixedDeliveryCharges == fixedDeliveryCharges &&
        other.freeDelivery == freeDelivery &&
        other.calibratedDistance == calibratedDistance &&
        other.freeDeliveryRadius == freeDeliveryRadius &&
        other.maxDeliveryRadius == maxDeliveryRadius &&
        other.ratePerMile == ratePerMile &&
        other.deliveryChargeType == deliveryChargeType &&
        other.freeDeliveryMinOrder == freeDeliveryMinOrder &&
        other.calculateNormalDeliveryFee == calculateNormalDeliveryFee;
  }

  @override
  int get hashCode {
    return fixedDeliveryCharges.hashCode ^
        freeDelivery.hashCode ^
        calibratedDistance.hashCode ^
        freeDeliveryRadius.hashCode ^
        maxDeliveryRadius.hashCode ^
        ratePerMile.hashCode ^
        deliveryChargeType.hashCode ^
        freeDeliveryMinOrder.hashCode ^
        calculateNormalDeliveryFee.hashCode;
  }
}
