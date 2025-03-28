// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class StoreDeliverySlotModel {
  final String? shopId;
  final String? shopName;
  final StoreDeliverySlotDataResponse? deliverySlots;
  StoreDeliverySlotModel({
    this.shopId,
    this.shopName,
    this.deliverySlots,
  });

  StoreDeliverySlotModel copyWith({
    String? shopId,
    String? shopName,
    StoreDeliverySlotDataResponse? deliverySlots,
  }) {
    return StoreDeliverySlotModel(
      shopId: shopId ?? this.shopId,
      shopName: shopName ?? this.shopName,
      deliverySlots: deliverySlots ?? this.deliverySlots,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'shopId': shopId,
      'shopName': shopName,
      'deliverySlots': deliverySlots?.toMap(),
    };
  }

  factory StoreDeliverySlotModel.fromMap(Map<String, dynamic> map) {
    return StoreDeliverySlotModel(
      shopId: map['shopId'] != null ? map['shopId'] as String : null,
      shopName: map['shopName'] != null ? map['shopName'] as String : null,
      deliverySlots: map['deliverySlots'] != null
          ? StoreDeliverySlotDataResponse.fromMap(
              map['deliverySlots'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreDeliverySlotModel.fromJson(String source) =>
      StoreDeliverySlotModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'StoreDeliverySlotModel(shopId: $shopId, shopName: $shopName, deliverySlots: $deliverySlots)';

  @override
  bool operator ==(covariant StoreDeliverySlotModel other) {
    if (identical(this, other)) return true;

    return other.shopId == shopId &&
        other.shopName == shopName &&
        other.deliverySlots == deliverySlots;
  }

  @override
  int get hashCode =>
      shopId.hashCode ^ shopName.hashCode ^ deliverySlots.hashCode;
}

class StoreDeliverySlotDataResponse {
  final List<StoreDeliverySlotDataModelResponse>? monday;
  final List<StoreDeliverySlotDataModelResponse>? tuesday;
  final List<StoreDeliverySlotDataModelResponse>? wednesday;
  final List<StoreDeliverySlotDataModelResponse>? thursday;
  final List<StoreDeliverySlotDataModelResponse>? friday;
  final List<StoreDeliverySlotDataModelResponse>? saturday;
  final List<StoreDeliverySlotDataModelResponse>? sunday;
  StoreDeliverySlotDataResponse({
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
  });

  StoreDeliverySlotDataResponse copyWith({
    List<StoreDeliverySlotDataModelResponse>? monday,
    List<StoreDeliverySlotDataModelResponse>? tuesday,
    List<StoreDeliverySlotDataModelResponse>? wednesday,
    List<StoreDeliverySlotDataModelResponse>? thursday,
    List<StoreDeliverySlotDataModelResponse>? friday,
    List<StoreDeliverySlotDataModelResponse>? saturday,
    List<StoreDeliverySlotDataModelResponse>? sunday,
  }) {
    return StoreDeliverySlotDataResponse(
      monday: monday ?? this.monday,
      tuesday: tuesday ?? this.tuesday,
      wednesday: wednesday ?? this.wednesday,
      thursday: thursday ?? this.thursday,
      friday: friday ?? this.friday,
      saturday: saturday ?? this.saturday,
      sunday: sunday ?? this.sunday,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'monday': monday?.map((x) => x.toMap()).toList(),
      'tuesday': tuesday?.map((x) => x.toMap()).toList(),
      'wednesday': wednesday?.map((x) => x.toMap()).toList(),
      'thursday': thursday?.map((x) => x.toMap()).toList(),
      'friday': friday?.map((x) => x.toMap()).toList(),
      'saturday': saturday?.map((x) => x.toMap()).toList(),
      'sunday': sunday?.map((x) => x.toMap()).toList(),
    };
  }

  factory StoreDeliverySlotDataResponse.fromMap(Map<String, dynamic> map) {
    return StoreDeliverySlotDataResponse(
      monday: map['monday'] != null
          ? List<StoreDeliverySlotDataModelResponse>.from(
              (map['monday'] as List<dynamic>)
                  .map<StoreDeliverySlotDataModelResponse?>(
                (x) => StoreDeliverySlotDataModelResponse.fromMap(
                    x as Map<String, dynamic>),
              ),
            )
          : [],
      tuesday: map['tuesday'] != null
          ? List<StoreDeliverySlotDataModelResponse>.from(
              (map['tuesday'] as List<dynamic>)
                  .map<StoreDeliverySlotDataModelResponse?>(
                (x) => StoreDeliverySlotDataModelResponse.fromMap(
                    x as Map<String, dynamic>),
              ),
            )
          : [],
      wednesday: map['wednesday'] != null
          ? List<StoreDeliverySlotDataModelResponse>.from(
              (map['wednesday'] as List<dynamic>)
                  .map<StoreDeliverySlotDataModelResponse?>(
                (x) => StoreDeliverySlotDataModelResponse.fromMap(
                    x as Map<String, dynamic>),
              ),
            )
          : [],
      thursday: map['thursday'] != null
          ? List<StoreDeliverySlotDataModelResponse>.from(
              (map['thursday'] as List<dynamic>)
                  .map<StoreDeliverySlotDataModelResponse?>(
                (x) => StoreDeliverySlotDataModelResponse.fromMap(
                    x as Map<String, dynamic>),
              ),
            )
          : [],
      friday: map['friday'] != null
          ? List<StoreDeliverySlotDataModelResponse>.from(
              (map['friday'] as List<dynamic>)
                  .map<StoreDeliverySlotDataModelResponse?>(
                (x) => StoreDeliverySlotDataModelResponse.fromMap(
                    x as Map<String, dynamic>),
              ),
            )
          : [],
      saturday: map['saturday'] != null
          ? List<StoreDeliverySlotDataModelResponse>.from(
              (map['saturday'] as List<dynamic>)
                  .map<StoreDeliverySlotDataModelResponse?>(
                (x) => StoreDeliverySlotDataModelResponse.fromMap(
                    x as Map<String, dynamic>),
              ),
            )
          : [],
      sunday: map['sunday'] != null
          ? List<StoreDeliverySlotDataModelResponse>.from(
              (map['sunday'] as List<dynamic>)
                  .map<StoreDeliverySlotDataModelResponse?>(
                (x) => StoreDeliverySlotDataModelResponse.fromMap(
                    x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreDeliverySlotDataResponse.fromJson(String source) =>
      StoreDeliverySlotDataResponse.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StoreDeliverySlotDataResponse(monday: $monday, tuesday: $tuesday, wednesday: $wednesday, thursday: $thursday, friday: $friday, saturday: $saturday, sunday: $sunday)';
  }

  @override
  bool operator ==(covariant StoreDeliverySlotDataResponse other) {
    if (identical(this, other)) return true;

    return listEquals(other.monday, monday) &&
        listEquals(other.tuesday, tuesday) &&
        listEquals(other.wednesday, wednesday) &&
        listEquals(other.thursday, thursday) &&
        listEquals(other.friday, friday) &&
        listEquals(other.saturday, saturday) &&
        listEquals(other.sunday, sunday);
  }

  @override
  int get hashCode {
    return monday.hashCode ^
        tuesday.hashCode ^
        wednesday.hashCode ^
        thursday.hashCode ^
        friday.hashCode ^
        saturday.hashCode ^
        sunday.hashCode;
  }
}

class StoreDeliverySlotDataModelResponse {
  final String? slotId;
  final String? day;
  final String? daytitle;
  final String? openingTime;
  final String? closingTime;
  final String? status;
  StoreDeliverySlotDataModelResponse({
    this.slotId,
    this.day,
    this.daytitle,
    this.openingTime,
    this.closingTime,
    this.status,
  });

  StoreDeliverySlotDataModelResponse copyWith({
    String? slotId,
    String? day,
    String? daytitle,
    String? openingTime,
    String? closingTime,
    String? status,
  }) {
    return StoreDeliverySlotDataModelResponse(
      slotId: slotId ?? this.slotId,
      day: day ?? this.day,
      daytitle: daytitle ?? this.daytitle,
      openingTime: openingTime ?? this.openingTime,
      closingTime: closingTime ?? this.closingTime,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'slotId': slotId,
      'day': day,
      'daytitle': daytitle,
      'openingTime': openingTime,
      'closingTime': closingTime,
      'status': status,
    };
  }

  factory StoreDeliverySlotDataModelResponse.fromMap(Map<String, dynamic> map) {
    return StoreDeliverySlotDataModelResponse(
      slotId: map['slotId'] != null ? map['slotId'] as String : null,
      day: map['day'] != null ? map['day'] as String : null,
      daytitle: map['daytitle'] != null ? map['daytitle'] as String : null,
      openingTime:
          map['openingTime'] != null ? map['openingTime'] as String : null,
      closingTime:
          map['closingTime'] != null ? map['closingTime'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreDeliverySlotDataModelResponse.fromJson(String source) =>
      StoreDeliverySlotDataModelResponse.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StoreDeliverySlotDataModelResponse(slotId: $slotId, day: $day, daytitle: $daytitle, openingTime: $openingTime, closingTime: $closingTime, status: $status)';
  }

  @override
  bool operator ==(covariant StoreDeliverySlotDataModelResponse other) {
    if (identical(this, other)) return true;

    return other.slotId == slotId &&
        other.day == day &&
        other.daytitle == daytitle &&
        other.openingTime == openingTime &&
        other.closingTime == closingTime &&
        other.status == status;
  }

  @override
  int get hashCode {
    return slotId.hashCode ^
        day.hashCode ^
        daytitle.hashCode ^
        openingTime.hashCode ^
        closingTime.hashCode ^
        status.hashCode;
  }
}
