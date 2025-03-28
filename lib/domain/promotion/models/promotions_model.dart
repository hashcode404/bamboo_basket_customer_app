// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PromotionsModel {
  final int? offerId;
  final int? rId;
  final String? title;
  final String? description;
  final String? offerCode;
  final bool? web;
  final bool? mobile;
  final String? wPosition;
  final String? mPosition;
  final String? paymentType;
  final dynamic price;
  final dynamic discount_price;
  final String? startDate;
  final String? endDate;
  final int? usage_count;
  final String? locations;
  final bool? doorDelivery;
  final bool? takeAway;
  final int? active;
  final String? file;
  PromotionsModel({
    this.offerId,
    this.rId,
    this.title,
    this.description,
    this.offerCode,
    this.web,
    this.mobile,
    this.wPosition,
    this.mPosition,
    this.paymentType,
    required this.price,
    required this.discount_price,
    this.startDate,
    this.endDate,
    this.usage_count,
    this.locations,
    this.doorDelivery,
    this.takeAway,
    this.active,
    this.file,
  });

  PromotionsModel copyWith({
    int? offerId,
    int? rId,
    String? title,
    String? description,
    String? offerCode,
    bool? web,
    bool? mobile,
    String? wPosition,
    String? mPosition,
    String? paymentType,
    dynamic? price,
    dynamic? discount_price,
    String? startDate,
    String? endDate,
    int? usage_count,
    String? locations,
    bool? doorDelivery,
    bool? takeAway,
    int? active,
    String? file,
  }) {
    return PromotionsModel(
      offerId: offerId ?? this.offerId,
      rId: rId ?? this.rId,
      title: title ?? this.title,
      description: description ?? this.description,
      offerCode: offerCode ?? this.offerCode,
      web: web ?? this.web,
      mobile: mobile ?? this.mobile,
      wPosition: wPosition ?? this.wPosition,
      mPosition: mPosition ?? this.mPosition,
      paymentType: paymentType ?? this.paymentType,
      price: price ?? this.price,
      discount_price: discount_price ?? this.discount_price,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      usage_count: usage_count ?? this.usage_count,
      locations: locations ?? this.locations,
      doorDelivery: doorDelivery ?? this.doorDelivery,
      takeAway: takeAway ?? this.takeAway,
      active: active ?? this.active,
      file: file ?? this.file,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'offerId': offerId,
      'rId': rId,
      'title': title,
      'description': description,
      'offerCode': offerCode,
      'web': web,
      'mobile': mobile,
      'wPosition': wPosition,
      'mPosition': mPosition,
      'paymentType': paymentType,
      'price': price,
      'discount_price': discount_price,
      'startDate': startDate,
      'endDate': endDate,
      'usage_count': usage_count,
      'locations': locations,
      'doorDelivery': doorDelivery,
      'takeAway': takeAway,
      'active': active,
      'file': file,
    };
  }

  factory PromotionsModel.fromMap(Map<String, dynamic> map) {
    return PromotionsModel(
      offerId: map['offerId'] != null ? map['offerId'] as int : null,
      rId: map['rId'] != null ? map['rId'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      offerCode: map['offerCode'] != null ? map['offerCode'] as String : null,
      web: map['web'] != null ? map['web'] as bool : null,
      mobile: map['mobile'] != null ? map['mobile'] as bool : null,
      wPosition: map['wPosition'] != null ? map['wPosition'] as String : null,
      mPosition: map['mPosition'] != null ? map['mPosition'] as String : null,
      paymentType: map['paymentType'] != null ? map['paymentType'] as String : null,
      price: map['price'] as dynamic,
      discount_price: map['discount_price'] as dynamic,
      startDate: map['startDate'] != null ? map['startDate'] as String : null,
      endDate: map['endDate'] != null ? map['endDate'] as String : null,
      usage_count: map['usage_count'] != null ? map['usage_count'] as int : null,
      locations: map['locations'] != null ? map['locations'] as String : null,
      doorDelivery: map['doorDelivery'] != null ? map['doorDelivery'] as bool : null,
      takeAway: map['takeAway'] != null ? map['takeAway'] as bool : null,
      active: map['active'] != null ? map['active'] as int : null,
      file: map['file'] != null ? map['file'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PromotionsModel.fromJson(String source) => PromotionsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PromotionsModel(offerId: $offerId, rId: $rId, title: $title, description: $description, offerCode: $offerCode, web: $web, mobile: $mobile, wPosition: $wPosition, mPosition: $mPosition, paymentType: $paymentType, price: $price, discount_price: $discount_price, startDate: $startDate, endDate: $endDate, usage_count: $usage_count, locations: $locations, doorDelivery: $doorDelivery, takeAway: $takeAway, active: $active, file: $file)';
  }

  @override
  bool operator ==(covariant PromotionsModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.offerId == offerId &&
      other.rId == rId &&
      other.title == title &&
      other.description == description &&
      other.offerCode == offerCode &&
      other.web == web &&
      other.mobile == mobile &&
      other.wPosition == wPosition &&
      other.mPosition == mPosition &&
      other.paymentType == paymentType &&
      other.price == price &&
      other.discount_price == discount_price &&
      other.startDate == startDate &&
      other.endDate == endDate &&
      other.usage_count == usage_count &&
      other.locations == locations &&
      other.doorDelivery == doorDelivery &&
      other.takeAway == takeAway &&
      other.active == active &&
      other.file == file;
  }

  @override
  int get hashCode {
    return offerId.hashCode ^
      rId.hashCode ^
      title.hashCode ^
      description.hashCode ^
      offerCode.hashCode ^
      web.hashCode ^
      mobile.hashCode ^
      wPosition.hashCode ^
      mPosition.hashCode ^
      paymentType.hashCode ^
      price.hashCode ^
      discount_price.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      usage_count.hashCode ^
      locations.hashCode ^
      doorDelivery.hashCode ^
      takeAway.hashCode ^
      active.hashCode ^
      file.hashCode;
  }
}
