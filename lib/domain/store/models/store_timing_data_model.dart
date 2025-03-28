// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';



class StoreTimingDataModel {
  final List<ShopTimingDetails> monday;
  final List<ShopTimingDetails> tuesday;
  final List<ShopTimingDetails> wednesday;
  final List<ShopTimingDetails> thursday;
  final List<ShopTimingDetails> friday;
  final List<ShopTimingDetails> saturday;
  final List<ShopTimingDetails> sunday;

  StoreTimingDataModel({
    this.monday = const [],
    this.tuesday = const [],
    this.wednesday = const [],
    this.thursday = const [],
    this.friday = const [],
    this.saturday = const [],
    this.sunday = const [],
  });

  StoreTimingDataModel copyWith({
    List<ShopTimingDetails>? monday,
    List<ShopTimingDetails>? tuesday,
    List<ShopTimingDetails>? wednesday,
    List<ShopTimingDetails>? thursday,
    List<ShopTimingDetails>? friday,
    List<ShopTimingDetails>? saturday,
    List<ShopTimingDetails>? sunday,
  }) {
    return StoreTimingDataModel(
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
      'monday': monday.map((x) => x.toMap()).toList(),
      'tuesday': tuesday.map((x) => x.toMap()).toList(),
      'wednesday': wednesday.map((x) => x.toMap()).toList(),
      'thursday': thursday.map((x) => x.toMap()).toList(),
      'friday': friday.map((x) => x.toMap()).toList(),
      'saturday': saturday.map((x) => x.toMap()).toList(),
      'sunday': sunday.map((x) => x.toMap()).toList(),
    };
  }

  factory StoreTimingDataModel.fromMap(Map<String, dynamic> map) {
    return StoreTimingDataModel(
      monday: List<ShopTimingDetails>.from(
        (map['monday'] as List<dynamic>).map<ShopTimingDetails?>(
          (x) => ShopTimingDetails.fromMap(x as Map<String, dynamic>),
        ),
      ),
      tuesday: List<ShopTimingDetails>.from(
        (map['tuesday'] as List<dynamic>).map<ShopTimingDetails?>(
          (x) => ShopTimingDetails.fromMap(x as Map<String, dynamic>),
        ),
      ),
      wednesday: List<ShopTimingDetails>.from(
        (map['wednesday'] as List<dynamic>).map<ShopTimingDetails?>(
          (x) => ShopTimingDetails.fromMap(x as Map<String, dynamic>),
        ),
      ),
      thursday: List<ShopTimingDetails>.from(
        (map['thursday'] as List<dynamic>).map<ShopTimingDetails?>(
          (x) => ShopTimingDetails.fromMap(x as Map<String, dynamic>),
        ),
      ),
      friday: List<ShopTimingDetails>.from(
        (map['friday'] as List<dynamic>).map<ShopTimingDetails?>(
          (x) => ShopTimingDetails.fromMap(x as Map<String, dynamic>),
        ),
      ),
      saturday: List<ShopTimingDetails>.from(
        (map['saturday'] as List<dynamic>).map<ShopTimingDetails?>(
          (x) => ShopTimingDetails.fromMap(x as Map<String, dynamic>),
        ),
      ),
      sunday: List<ShopTimingDetails>.from(
        (map['sunday'] as List<dynamic>).map<ShopTimingDetails?>(
          (x) => ShopTimingDetails.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreTimingDataModel.fromJson(String source) =>
      StoreTimingDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StoreTimingDataModel(monday: $monday, tuesday: $tuesday, wednesday: $wednesday, thursday: $thursday, friday: $friday, saturday: $saturday, sunday: $sunday)';
  }

  @override
  bool operator ==(covariant StoreTimingDataModel other) {
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

class ShopTimingDetails {
  final String? slotId;
  final String? day;
  final String? daytitle;
  final String? openingTime;
  final String? closingTime;
  final String? status;

  ShopTimingDetails({
    this.slotId,
    this.day,
    this.daytitle,
    this.openingTime,
    this.closingTime,
    this.status,
  });

  ShopTimingDetails copyWith({
    String? slotId,
    String? day,
    String? daytitle,
    String? openingTime,
    String? closingTime,
    String? status,
  }) {
    return ShopTimingDetails(
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

  factory ShopTimingDetails.fromMap(Map<String, dynamic> map) {
    return ShopTimingDetails(
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

  factory ShopTimingDetails.fromJson(String source) =>
      ShopTimingDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ShopTimingDetails(slotId: $slotId, day: $day, daytitle: $daytitle, openingTime: $openingTime, closingTime: $closingTime, status: $status)';
  }

  @override
  bool operator ==(covariant ShopTimingDetails other) {
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
