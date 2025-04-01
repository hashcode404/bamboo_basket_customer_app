// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bamboo_basket_customer_app/domain/store/models/product_details_model.dart';
import 'package:flutter/foundation.dart';

class ProductDetailsPagination {
  final List<ProductDataModel> dataList;
  ProductDetailsPagination({
    required this.dataList,
  });

  ProductDetailsPagination copyWith({
    List<ProductDataModel>? dataList,
  }) {
    return ProductDetailsPagination(
      dataList: dataList ?? this.dataList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dataList': dataList.map((x) => x.toMap()).toList(),
    };
  }

  factory ProductDetailsPagination.fromMap(Map<String, dynamic> map) {
    return ProductDetailsPagination(
      dataList: List<ProductDataModel>.from(
        (map['dataList'] as List<dynamic>).map<ProductDataModel>(
          (x) => ProductDataModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductDetailsPagination.fromJson(String source) =>
      ProductDetailsPagination.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ProductDetailsPagination(dataList: $dataList)';

  @override
  bool operator ==(covariant ProductDetailsPagination other) {
    if (identical(this, other)) return true;

    return listEquals(other.dataList, dataList);
  }

  @override
  int get hashCode => dataList.hashCode;
}

class ProductDetailsPaginationSettings {
  final int? totalDishes;
  final String? dishesPerPage;
  final int? totalPages;
  final int? currentPage;
  final int? firstPage;
  final int? nextpage;
  final int? previousPage;
  final int? lastPage;
  final String? imagePlaceholder;
  ProductDetailsPaginationSettings({
    this.totalDishes,
    this.dishesPerPage,
    this.totalPages,
    this.currentPage,
    this.firstPage,
    this.nextpage,
    this.previousPage,
    this.lastPage,
    this.imagePlaceholder,
  });

  ProductDetailsPaginationSettings copyWith({
    int? totalDishes,
    String? dishesPerPage,
    int? totalPages,
    int? currentPage,
    int? firstPage,
    int? nextpage,
    int? previousPage,
    int? lastPage,
    String? imagePlaceholder,
  }) {
    return ProductDetailsPaginationSettings(
      totalDishes: totalDishes ?? this.totalDishes,
      dishesPerPage: dishesPerPage ?? this.dishesPerPage,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
      firstPage: firstPage ?? this.firstPage,
      nextpage: nextpage ?? this.nextpage,
      previousPage: previousPage ?? this.previousPage,
      lastPage: lastPage ?? this.lastPage,
      imagePlaceholder: imagePlaceholder ?? this.imagePlaceholder,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalDishes': totalDishes,
      'dishesPerPage': dishesPerPage,
      'totalPages': totalPages,
      'currentPage': currentPage,
      'firstPage': firstPage,
      'nextpage': nextpage,
      'previousPage': previousPage,
      'lastPage': lastPage,
      'imagePlaceholder': imagePlaceholder,
    };
  }

  factory ProductDetailsPaginationSettings.fromMap(Map<String, dynamic> map) {
    return ProductDetailsPaginationSettings(
      totalDishes:
          map['totalDishes'] != null ? map['totalDishes'] as int : null,
      dishesPerPage:
          map['dishesPerPage'] != null ? map['dishesPerPage'] as String : null,
      totalPages: map['totalPages'] != null ? map['totalPages'] as int : null,
      currentPage:
          map['currentPage'] != null ? map['currentPage'] as int : null,
      firstPage: map['firstPage'] != null ? map['firstPage'] as int : null,
      nextpage: map['nextpage'] != null ? map['nextpage'] as int : null,
      previousPage:
          map['previousPage'] != null ? map['previousPage'] as int : null,
      lastPage: map['lastPage'] != null ? map['lastPage'] as int : null,
      imagePlaceholder: map['imagePlaceholder'] != null
          ? map['imagePlaceholder'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductDetailsPaginationSettings.fromJson(String source) =>
      ProductDetailsPaginationSettings.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductDetailsPaginationSettings(totalDishes: $totalDishes, dishesPerPage: $dishesPerPage, totalPages: $totalPages, currentPage: $currentPage, firstPage: $firstPage, nextpage: $nextpage, previousPage: $previousPage, lastPage: $lastPage, imagePlaceholder: $imagePlaceholder)';
  }

  @override
  bool operator ==(covariant ProductDetailsPaginationSettings other) {
    if (identical(this, other)) return true;

    return other.totalDishes == totalDishes &&
        other.dishesPerPage == dishesPerPage &&
        other.totalPages == totalPages &&
        other.currentPage == currentPage &&
        other.firstPage == firstPage &&
        other.nextpage == nextpage &&
        other.previousPage == previousPage &&
        other.lastPage == lastPage &&
        other.imagePlaceholder == imagePlaceholder;
  }

  @override
  int get hashCode {
    return totalDishes.hashCode ^
        dishesPerPage.hashCode ^
        totalPages.hashCode ^
        currentPage.hashCode ^
        firstPage.hashCode ^
        nextpage.hashCode ^
        previousPage.hashCode ^
        lastPage.hashCode ^
        imagePlaceholder.hashCode;
  }
}
