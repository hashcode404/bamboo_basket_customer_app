// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserAddressListDataModel {
  final bool? error;
  final UserAddressListSubDataModel? data;
  UserAddressListDataModel({
    this.error,
    this.data,
  });

  UserAddressListDataModel copyWith({
    bool? error,
    UserAddressListSubDataModel? data,
  }) {
    return UserAddressListDataModel(
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'error': error,
      'data': data?.toMap(),
    };
  }

  factory UserAddressListDataModel.fromMap(Map<String, dynamic> map) {
    return UserAddressListDataModel(
      error: map['error'] != null ? map['error'] as bool : null,
      data: map['data'] != null
          ? UserAddressListSubDataModel.fromMap(
          map['data'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAddressListDataModel.fromJson(String source) =>
      UserAddressListDataModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserAddressListDataModel(error: $error, data: $data)';

  @override
  bool operator ==(covariant UserAddressListDataModel other) {
    if (identical(this, other)) return true;

    return other.error == error && other.data == data;
  }

  @override
  int get hashCode => error.hashCode ^ data.hashCode;
}

class UserAddressListSubDataModel {
  final List<UserAddressDataModel>? list;
  UserAddressListSubDataModel({
    this.list,
  });

  UserAddressListSubDataModel copyWith({
    List<UserAddressDataModel>? list,
  }) {
    return UserAddressListSubDataModel(
      list: list ?? this.list,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'list': list?.map((x) => x.toMap()).toList(),
    };
  }

  factory UserAddressListSubDataModel.fromMap(Map<String, dynamic> map) {
    return UserAddressListSubDataModel(
      list: map['list'] != null
          ? List<UserAddressDataModel>.from(
        (map['list'] as List<dynamic>).map<UserAddressDataModel?>(
              (x) => UserAddressDataModel.fromMap(x as Map<String, dynamic>),
        ),
      )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAddressListSubDataModel.fromJson(String source) =>
      UserAddressListSubDataModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserAddressListSubDataModel(list: $list)';

  @override
  bool operator ==(covariant UserAddressListSubDataModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.list, list);
  }

  @override
  int get hashCode => list.hashCode;
}

class UserAddressDataModel {
  final String? uaID;
  final String? userID;
  final String? addressTitle;
  final String? firstName;
  final String? lastName;
  final String? line1;
  final String? line2;
  final String? town;
  final String? postcode;
  final String? county;
  final String? landmark;
  final String? dDefault;
  final String? addedAt;
  UserAddressDataModel({
    this.uaID,
    this.userID,
    this.addressTitle,
    this.firstName,
    this.lastName,
    this.line1,
    this.line2,
    this.town,
    this.postcode,
    this.county,
    this.landmark,
    this.dDefault,
    this.addedAt,
  });

  UserAddressDataModel copyWith({
    String? uaID,
    String? userID,
    String? addressTitle,
    String? firstName,
    String? lastName,
    String? line1,
    String? line2,
    String? town,
    String? postcode,
    String? county,
    String? landmark,
    String? dDefault,
    String? addedAt,
  }) {
    return UserAddressDataModel(
      uaID: uaID ?? this.uaID,
      userID: userID ?? this.userID,
      addressTitle: addressTitle ?? this.addressTitle,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      line1: line1 ?? this.line1,
      line2: line2 ?? this.line2,
      town: town ?? this.town,
      postcode: postcode ?? this.postcode,
      county: county ?? this.county,
      landmark: landmark ?? this.landmark,
      dDefault: dDefault ?? this.dDefault,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uaID': uaID,
      'userID': userID,
      'addressTitle': addressTitle,
      'firstName': firstName,
      'lastName': lastName,
      'line1': line1,
      'line2': line2,
      'town': town,
      'postcode': postcode,
      'county': county,
      'landmark': landmark,
      'dDefault': dDefault,
      'addedAt': addedAt,
    };
  }

  factory UserAddressDataModel.fromMap(Map<String, dynamic> map) {
    return UserAddressDataModel(
      uaID: map['uaID'] != null ? map['uaID'] as String : null,
      userID: map['userID'] != null ? map['userID'] as String : null,
      addressTitle:
      map['addressTitle'] != null ? map['addressTitle'] as String : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      line1: map['line1'] != null ? map['line1'] as String : null,
      line2: map['line2'] != null ? map['line2'] as String : null,
      town: map['town'] != null ? map['town'] as String : null,
      postcode: map['postcode'] != null ? map['postcode'] as String : null,
      county: map['county'] != null ? map['county'] as String : null,
      landmark: map['landmark'] != null ? map['landmark'] as String : null,
      dDefault: map['default'] != null ? map['default'] as String : null,
      addedAt: map['addedAt'] != null ? map['addedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAddressDataModel.fromJson(String source) =>
      UserAddressDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserAddressDataModel(uaID: $uaID, userID: $userID, addressTitle: $addressTitle, firstName: $firstName, lastName: $lastName, line1: $line1, line2: $line2, town: $town, postcode: $postcode, county: $county, landmark: $landmark, dDefault: $dDefault, addedAt: $addedAt)';
  }

  @override
  bool operator ==(covariant UserAddressDataModel other) {
    if (identical(this, other)) return true;

    return other.uaID == uaID &&
        other.userID == userID &&
        other.addressTitle == addressTitle &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.line1 == line1 &&
        other.line2 == line2 &&
        other.town == town &&
        other.postcode == postcode &&
        other.county == county &&
        other.landmark == landmark &&
        other.dDefault == dDefault &&
        other.addedAt == addedAt;
  }

  @override
  int get hashCode {
    return uaID.hashCode ^
    userID.hashCode ^
    addressTitle.hashCode ^
    firstName.hashCode ^
    lastName.hashCode ^
    line1.hashCode ^
    line2.hashCode ^
    town.hashCode ^
    postcode.hashCode ^
    county.hashCode ^
    landmark.hashCode ^
    dDefault.hashCode ^
    addedAt.hashCode;
  }

  String get userFullname {
    return "$firstName $lastName";
  }

  String get userFulladdress {
    if (line2?.isEmpty == true || line2 == null) {
      return "$line1, $town, $county, $postcode";
    }
    return "$line1, $line2, $town, $county, $postcode";
  }
}
