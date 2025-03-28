// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class AddProductCartRequestDataModel {
  final String? pID;
  final String? rID;
  final String? qty;
  final CartCOptionsDataModel? cOption;

  AddProductCartRequestDataModel({
    this.pID,
    this.rID,
    this.qty,
    this.cOption,
  });

  AddProductCartRequestDataModel copyWith({
    String? pID,
    String? rID,
    String? qty,
    CartCOptionsDataModel? cOption,
  }) {
    return AddProductCartRequestDataModel(
      pID: pID ?? this.pID,
      rID: rID ?? this.rID,
      qty: qty ?? this.qty,
      cOption: cOption ?? this.cOption,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pID': pID,
      'rID': rID,
      'qty': qty,
      'cOption': cOption?.toMap(),
    };
  }

  factory AddProductCartRequestDataModel.fromMap(Map<String, dynamic> map) {
    return AddProductCartRequestDataModel(
      pID: map['pID'] != null ? map['pID'] as String : null,
      rID: map['rID'] != null ? map['rID'] as String : null,
      qty: map['qty'] != null ? map['qty'] as String : null,
      cOption: map['cOption'] != null
          ? CartCOptionsDataModel.fromMap(
              map['cOption'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddProductCartRequestDataModel.fromJson(String source) =>
      AddProductCartRequestDataModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddProductCartRequestDataModel(pID: $pID, rID: $rID, qty: $qty, cOption: $cOption)';
  }

  @override
  bool operator ==(covariant AddProductCartRequestDataModel other) {
    if (identical(this, other)) return true;

    return other.pID == pID &&
        other.rID == rID &&
        other.qty == qty &&
        other.cOption == cOption;
  }

  @override
  int get hashCode {
    return pID.hashCode ^ rID.hashCode ^ qty.hashCode ^ cOption.hashCode;
  }
}

class CartCOptionsDataModel {
  final String? pvID;
  final Map<String, List<String>> addons;
  final Map<String, List<String>> masterAddons;

  CartCOptionsDataModel({
    this.pvID,
    required this.addons,
    required this.masterAddons,
  });

  CartCOptionsDataModel copyWith({
    String? pvID,
    Map<String, List<String>>? addons,
    Map<String, List<String>>? masterAddons,
  }) {
    return CartCOptionsDataModel(
      pvID: pvID ?? this.pvID,
      addons: addons ?? this.addons,
      masterAddons: masterAddons ?? this.masterAddons,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pvID': pvID,
      'addons': addons,
      'masterAddons': masterAddons,
    };
  }

  factory CartCOptionsDataModel.fromMap(Map<String, dynamic> map) {
    return CartCOptionsDataModel(
      pvID: map['pvID'] != null ? map['pvID'] as String : null,
      addons: map['addons'] is Map<String, dynamic>
          ? Map<String, List<String>>.fromEntries(
              (map['addons'] as Map<String, dynamic>).entries.map(
                    (entry) => MapEntry(
                      entry.key,
                      entry.value is List
                          ? List<String>.from(entry.value)
                          : <String>[],
                    ),
                  ),
            )
          : <String, List<String>>{},
      masterAddons: map['masterAddons'] is Map<String, dynamic>
          ? Map<String, List<String>>.fromEntries(
              (map['masterAddons'] as Map<String, dynamic>).entries.map(
                    (entry) => MapEntry(
                      entry.key,
                      entry.value is List
                          ? List<String>.from(entry.value)
                          : <String>[],
                    ),
                  ),
            )
          : <String, List<String>>{},
    );
  }

  String toJson() => json.encode(toMap());

  factory CartCOptionsDataModel.fromJson(String source) =>
      CartCOptionsDataModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AddProductCartCOptionsRequestDataModel(pvID: $pvID, addons: $addons, masterAddons: $masterAddons)';

  @override
  bool operator ==(covariant CartCOptionsDataModel other) {
    if (identical(this, other)) return true;

    return other.pvID == pvID &&
        mapEquals(other.addons, addons) &&
        mapEquals(other.masterAddons, masterAddons);
  }

  @override
  int get hashCode => pvID.hashCode ^ addons.hashCode ^ masterAddons.hashCode;
}
