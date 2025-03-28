import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProductCategoryModel {
  final List<CategoryData>? items;

  ProductCategoryModel({
    this.items,
  });

  ProductCategoryModel copyWith({
    List<CategoryData>? items,
  }) {
    return ProductCategoryModel(
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'items': items?.map((x) => x.toMap()).toList(),
    };
  }

  factory ProductCategoryModel.fromMap(Map<String, dynamic> map) {
    return ProductCategoryModel(
      items: map['items'] != null
          ? List<CategoryData>.from(
              (map['items'] as List<dynamic>).map<CategoryData?>(
                (x) => CategoryData.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductCategoryModel.fromJson(String source) =>
      ProductCategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ProductCategorySubDataModel(items: $items)';

  @override
  bool operator ==(covariant ProductCategoryModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.items, items);
  }

  @override
  int get hashCode => items.hashCode;
}

class CategoryData {
  final String? cID;
  final String? name;
  final String? description;
  final String? shopID;
  final String? shopSpecificID;
  final String? status;
  final String? categoryStatus;
  final String? parentID;
  final String? defaultFlag;
  final String? image;
  final String? sortOrder;
  final List<CategoryData>? childrens;
  final ProductsCount? productsCount;

  CategoryData(
      {this.cID,
      this.name,
      this.description,
      this.shopID,
      this.shopSpecificID,
      this.status,
      this.categoryStatus,
      this.parentID,
      this.defaultFlag,
      this.sortOrder,
      this.image,
      this.childrens,
      this.productsCount});

  CategoryData copyWith(
      {String? cID,
      String? name,
      String? description,
      String? shopID,
      String? shopSpecificID,
      String? status,
      String? categoryStatus,
      String? parentID,
      String? defaultFlag,
      String? image,
      String? sortOrder,
      List<CategoryData>? childrens,
      ProductsCount? productsCount}) {
    return CategoryData(
        cID: cID ?? this.cID,
        name: name ?? this.name,
        description: description ?? this.description,
        shopID: shopID ?? this.shopID,
        shopSpecificID: shopSpecificID ?? this.shopSpecificID,
        status: status ?? this.status,
        categoryStatus: categoryStatus ?? this.categoryStatus,
        parentID: parentID ?? this.parentID,
        defaultFlag: defaultFlag ?? this.defaultFlag,
        sortOrder: sortOrder ?? this.sortOrder,
        childrens: childrens ?? this.childrens,
        image: image ?? this.image,
        productsCount: productsCount ?? this.productsCount);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cID': cID,
      'name': name,
      'description': description,
      'shopID': shopID,
      'shopSpecificID': shopSpecificID,
      'status': status,
      'categoryStatus': categoryStatus,
      'parentID': parentID,
      'defaultFlag': defaultFlag,
      'sortOrder': sortOrder,
      'image': image,
      'childrens': childrens?.map((x) => x.toMap()).toList(),
      'productsCount': productsCount?.toMap(),
    };
  }

  factory CategoryData.fromMap(Map<String, dynamic> map) {
    return CategoryData(
        cID: map['cID'] != null ? map['cID'] as String : null,
        name: map['name'] != null ? map['name'] as String : null,
        description: map['description'] != null ? map['description'] as String : null,
        shopID: map['shopID'] != null ? map['shopID'] as String : null,
        shopSpecificID: map['shopSpecificID'] != null ? map['shopSpecificID'] as String : null,
        status: map['status'] != null ? map['status'] as String : null,
        categoryStatus: map['categoryStatus'] != null ? map['categoryStatus'] as String : null,
        parentID: map['parentID'] != null ? map['parentID'] as String : null,
        defaultFlag: map['defaultFlag'] != null ? map['defaultFlag'] as String : null,
        sortOrder: map['sortOrder'] != null ? map['sortOrder'] as String : null,
        image: map['image'] != null ? map['image'] as String : null,
        childrens: map['childrens'] != null
            ? List<CategoryData>.from(
                (map['childrens'] as List<dynamic>).map<CategoryData?>(
                  (x) => CategoryData.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
        productsCount:
            map['productsCount'] != null ? ProductsCount.fromMap(map['productsCount'] as Map<String, dynamic>) : null);
  }

  String toJson() => json.encode(toMap());

  factory CategoryData.fromJson(String source) => CategoryData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductCategoryItemDataModel(cID: $cID, name: $name, description: $description, shopID: $shopID, shopSpecificID: $shopSpecificID, status: $status, categoryStatus: $categoryStatus, parentID: $parentID, defaultFlag: $defaultFlag, sortOrder: $sortOrder, childrens: $childrens, image: $image)';
  }

  @override
  bool operator ==(covariant CategoryData other) {
    if (identical(this, other)) return true;

    return other.cID == cID &&
        other.name == name &&
        other.description == description &&
        other.shopID == shopID &&
        other.shopSpecificID == shopSpecificID &&
        other.status == status &&
        other.categoryStatus == categoryStatus &&
        other.parentID == parentID &&
        other.defaultFlag == defaultFlag &&
        other.image == image &&
        other.sortOrder == sortOrder &&
        other.productsCount == productsCount &&
        listEquals(other.childrens, childrens);
  }

  @override
  int get hashCode {
    return cID.hashCode ^
        name.hashCode ^
        description.hashCode ^
        shopID.hashCode ^
        shopSpecificID.hashCode ^
        status.hashCode ^
        categoryStatus.hashCode ^
        parentID.hashCode ^
        defaultFlag.hashCode ^
        sortOrder.hashCode ^
        image.hashCode ^
        productsCount.hashCode ^
        childrens.hashCode;
  }
}

class ProductsCount {
  final int? online;
  final int? dininge;

  ProductsCount({
    this.online,
    this.dininge,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'online': online,
      'dininge': dininge,
    };
  }

  factory ProductsCount.fromMap(Map<String, dynamic> map) {
    return ProductsCount(
      online: map['online'] as int?,
      dininge: map['dininge'] as int?,
    );
  }

  @override
  String toString() => 'ProductsCount(online: $online, dininge: $dininge)';

  @override
  bool operator ==(covariant ProductsCount other) {
    return other.online == online && other.dininge == dininge;
  }

  @override
  int get hashCode => online.hashCode ^ dininge.hashCode;
}
